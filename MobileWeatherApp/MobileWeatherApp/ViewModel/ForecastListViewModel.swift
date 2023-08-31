//
//  ForecastListViewModel.swift
//  MobileWeatherApp
//
//  Created by Renato on 28/08/23.
//
import CoreLocation
import Foundation
import SwiftUI

class ForecastListViewModel: ObservableObject {

	struct AppError: Identifiable {
		let id = UUID().uuidString
		let errorString: String
	}

	@Published var forecasts: [ForecastViewModel] = []
	var appError: AppError?  = nil
	@Published var isLoading: Bool = false
	@AppStorage("location") var storageLocation: String = ""
	@Published var location = ""
	@AppStorage("system") var system: Int = 0 {
		didSet {
			for i in 0..<forecasts.count{
				forecasts[i].system = system
			} //end for i in 0
		} //end didSet
	} //end var system

	init() {
		location = storageLocation
		getWeatherForecast()
	} //end init()

	

	func getWeatherForecast(){
		storageLocation = location //setando o campo para vazio
		UIApplication.shared.endEditing()

		if location == "" { //se o campo for vazio nao vamos fazer outra chamado para a api, vamos setar ele como um array vazio
			forecasts = []
		} else {
			isLoading = true
			let apiService = APIServiceCombine.shared

			CLGeocoder().geocodeAddressString(location) { (placemarks, error) in
				if let error = error as? CLError {
					switch error.code {

						case .locationUnknown, .geocodeFoundNoResult, .geocodeFoundPartialResult:
							self.appError = AppError(errorString: NSLocalizedString("Unable to determine location from this text", comment: ""))
							//					case .denied:
							//						<#code#>
						case .network:
							self.appError = AppError(errorString: NSLocalizedString("You do not appear to have a network connection", comment: ""))
							//					case .headingFailure:
							//						<#code#>
							//					case .regionMonitoringDenied:
							//						<#code#>
							//					case .regionMonitoringFailure:
							//						<#code#>
							//					case .regionMonitoringSetupDelayed:
							//						<#code#>
							//					case .regionMonitoringResponseDelayed:
							//						<#code#>
							//					case .geocodeFoundNoResult:
							//						<#code#>
							//					case .geocodeFoundPartialResult:
							//						<#code#>
							//					case .geocodeCanceled:
							//						<#code#>
							//					case .deferredFailed:
							//						<#code#>
							//					case .deferredNotUpdatingLocation:
							//						<#code#>
							//					case .deferredAccuracyTooLow:
							//						<#code#>
							//					case .deferredDistanceFiltered:
							//						<#code#>
							//					case .deferredCanceled:
							//						<#code#>
							//					case .rangingUnavailable:
							//						<#code#>
							//					case .rangingFailure:
							//						<#code#>
							//					case .promptDeclined:
							//						<#code#>
							//					case .historicalLocationError:
							//						<#code#>
							//					@unknown default:
							//						<#code#>
						default:
							self.appError = AppError(errorString: error.localizedDescription)
					}
					self.isLoading = false
//					self.appError = AppError(errorString: error.localizedDescription)
					print("Error: \(error.localizedDescription)")
				}
				if let lat = placemarks?.first?.location?.coordinate.latitude,
				   let lon = placemarks?.first?.location?.coordinate.longitude{

					//		latitude = 15.792844
					//		longitude = -47.882494
					apiService.getJSON(urlString: "https://api.openweathermap.org/data/3.0/onecall?lat=\(lat)&lon=\(lon)&exclude=current,minutely,hourly,alerts&appid=c2d1ab6f8542a3e7d6cc14a5bc5c32f2", dateDecodingStrategy: .secondsSince1970) { (result: Result<Forecast, APIServiceCombine.APIError>) in
						switch result {
							case .success(let forecast):
								DispatchQueue.main.async {
									self.isLoading = false
									self.forecasts = forecast.daily.map { ForecastViewModel(forecast: $0, system: self.system)}
								}
							case .failure(let apiError):
								switch apiError{
									case .error(let errorString):
										self.isLoading = false
										self.appError = AppError(errorString: errorString)
										print(errorString)
								} //end switch apiError
						} //end switch result
					} //end apiService.getJSON
				} //end if let lat and if let lon
			} //end CLGeocoder
		} //end func getWeatherForecast
	} //end if location
} //end class ForecastListViewModel

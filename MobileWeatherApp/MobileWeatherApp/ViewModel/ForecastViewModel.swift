//  ForecastViewModel.swift
//  MobileWeatherApp
//
//  Created by Renato on 28/08/23.
//

import Foundation

struct ForecastViewModel {
	let forecast: Forecast.Daily
	var system: Int

	private static var  dateFomatter: DateFormatter {
		let dateFomatter = DateFormatter()
		dateFomatter.dateFormat = "E, MMM, d"
		return dateFomatter
	} //end private static dateFormatter

	private static var numberFomatter: NumberFormatter{
		let numberFomatter = NumberFormatter()
		numberFomatter.maximumFractionDigits = 0
		return numberFomatter
	} //end private static numberFomatter

	private static var numberFomatter2: NumberFormatter{
		let numberFomatter = NumberFormatter()
		numberFomatter.numberStyle = .percent
		return numberFomatter
	} //end private static numberFomatter


	func convert(_ temp: Double) -> Double{
		let celsius = temp - 273.5
		if system == 0 {
			return celsius
		} else {
			return celsius * 9 / 5 + 32
		}
	} //end func convert
	var day: String {
		return Self.dateFomatter.string(from: forecast.dt)
	}
	var overview: String {
		forecast.weather[0].description.capitalized
	}

	var high: String{
		return "H: \(Self.numberFomatter.string(for: convert(forecast.temp.max)) ?? "0")°"
	}
	var low: String{
		return "L: \(Self.numberFomatter.string(for: convert(forecast.temp.min)) ?? "0")"
	}
	var pop: String{
		return "💧 \(Self.numberFomatter2.string(for: forecast.pop) ?? "0%")"
	}
	var clouds: String {
		return "☁️ \(forecast.clouds)%"
	}
	var humidity: String{
		return "Humidity: \(forecast.humidity)%"
	}
	var weatherIconURL: URL {
		let urlString = "https://openweathermap.org/img/wn/\(forecast.weather[0].icon)@2x.png"
		return URL(string: urlString)!
	}
} //end struct ForecastViewModel

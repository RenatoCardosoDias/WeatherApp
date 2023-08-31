//
//  ContentView.swift
//  MobileWeatherApp
//
//  Created by Renato on 27/08/23.
//

import SDWebImageSwiftUI
import SwiftUI


struct ContentView: View {

	@StateObject private var vmList = ForecastListViewModel()

	var body: some View {
		ZStack {
			NavigationView {
				VStack {
					Picker (selection: $vmList.system, label: Text("System")){
						Text("°C").tag(0)
						Text("°F").tag(1)
					} //end Picker
					.pickerStyle(SegmentedPickerStyle())
					.frame(width: 100)
					.padding(.vertical)
					HStack{
						TextField("Enter Location", text: $vmList.location, onCommit: {
							vmList.getWeatherForecast()
						})
							.textFieldStyle(RoundedBorderTextFieldStyle())
							.overlay (
								Button(action: {
									vmList.location = ""
									vmList.getWeatherForecast()
								}) {
									Image(systemName: "xmark.circle")
										.foregroundColor(.gray)
								} //end Button
								.padding(.horizontal),
								alignment: .trailing
							) //end .overlay
						Button {
							vmList.getWeatherForecast()
						} label: {
							Image(systemName: "magnifyingglass.circle.fill")
								.font(.title3)
						} //end Button
					} //end HStack
					List(vmList.forecasts, id: \.day) { day in
						VStack (alignment: .leading){
							Text(day.day)
								.fontWeight(.bold)
							HStack(alignment: .center){
								WebImage(url: day.weatherIconURL)
									.resizable()
									.placeholder{
										Image(systemName: "hourglass")
									}
									.scaledToFit()
									.frame(width: 75)
								VStack(alignment: .leading){
									Text(day.overview)
										.font(.title2)
									HStack{
										Text(day.high)
										Text(day.low)
									} //end HStack
									HStack{
										Text(day.clouds)
										Text(day.pop)
									}
									Text(day.humidity)
								}
							} //end HStack
						} //end VStack
					} //end List
					.listStyle(PlainListStyle())
				} //end VStack
				.padding(.horizontal)
				.navigationTitle("Mobile Weather")
				.alert(item: $vmList.appError) { appAlert in
					Alert(title: Text("Error"),
						  message: Text("""
								\(appAlert.errorString)
									Please try again later
							""" )
					) //end Alert
				} //end .alert
			} //end NavigationView
			if vmList.isLoading{
				ZStack {
					Color(.white)
						.opacity(0.3)
					.ignoresSafeArea()
					ProgressView("Fetching Weather")
						.padding()
						.background(
						RoundedRectangle(cornerRadius: 10)
							.fill(Color(.systemBackground))
						) //end background
						.shadow(radius: 10)
				}//end ZStack
			} //end if vmList.isLoadin
		} //end ZStack
	} //end var body
} //end struct ContentView



struct ContentView_Previews: PreviewProvider {
	static var previews: some View {
		ContentView()
	}
}

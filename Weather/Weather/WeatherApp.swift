//
//  WeatherApp.swift
//  Weather
//
//  Created by Renato on 28/02/23.
//

import SwiftUI

@main
struct WeatherApp: App {
    var body: some Scene {
        WindowGroup {
            let weatherService = WeatherService()
            let viewModel = WeatherViewModel(weatherService: <#T##WeatherService#>)
            WeatherView(viewModel: viewModel)
        }
    }
}

//
//  WeatherApp.swift
//  Weather
//
//  Created by Renato on 28/02/23.
//

//vamos criar o WeatherService, vamos definir o nosso WeatherViewModel que precisa de um serivço

import SwiftUI

@main
struct WeatherApp: App {
    var body: some Scene {
        WindowGroup {
            let weatherService = WeatherService()
            let viewModel = WeatherViewModel(weatherService: weatherService)
            //vamos atualizar o parametros da nossa WeatherView
            WeatherView(viewModel: viewModel)
            //agora nossa view tem um WeatherViewModel que vai dar os dados necessarios para mostrar em nosso app
        }
    }
}

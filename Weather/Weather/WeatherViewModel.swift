//
//  WeatherViewModel.swift
//  Weather
//
//  Created by Renato on 01/03/23.
//
// Vamos pegar os dados no nosso serviços e converte ele em modelo para informação que nossa visualização precisa para mostrar no nosso aplicativo
import Foundation

private let defaultIcon = "❓"
private let iconMap = [
    "Drizzle" : "💦",
    "Thunderstorm": "⛈️",
    "Rain": "🌧️",
    "Snow": "❄️",
    "Clear": "☀️",
    "Clouds": "☁️"
] //end private let iconMap


public class WeaterViewModel: ObservableObject {
    @Published var cityName: String = "City Name"
    @Published var temperature: String = "--"
    @Published var weatherDescription: String = "--"
    @Published var weatherIcon: String = defaultIcon
} //end public class WeaterViewModel

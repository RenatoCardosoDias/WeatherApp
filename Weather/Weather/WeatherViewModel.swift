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


    //vamos precisar de um servidor de clima (weather service) dentro da noss visualização, que vai ser usado para fornecer os dados do clima
    public let weatherService: WeatherService

    //incializar o serviço do clima quando nosso model inicializar
    public init(weatherService: WeatherService){
        //atribuindo a propriedade do serviço
        self.weatherService = weatherService
    } //end public init


    public func refresh() {

    }


} //end public class WeaterViewModel



//
//  WeatherService.swift
//  Weather
//
//  Created by Renato on 28/02/23.
//
import CoreLocation
import Foundation

public final class WeatherService: NSObject{

    private let locationManager = CLLocationManager()
    private let API_KEY = "84baba4890f4175928c249fae5112589"
    private var complitionHandler: ((Weather) -> Void)? //a função nao aceita nenhum valor ou nenhum parametro, nao retorna nenhum valor e é um opcional

    public override init() {
        super.init()
        locationManager.delegate  = self

    } //end public override init()

    public func loadWeatherData(_ complitionHandler: @escaping((Weather) -> Void )) {
        self.complitionHandler = complitionHandler
        locationManager.requestWhenInUseAuthorization() //requisita a localização em quanto estiver usando
        locationManager.startUpdatingLocation() //iniciar o processo de atualizaçnao da localização do usuário
    } //end public func loadWeatherData

    ///https://api.openweathermap.org/data/2.5/weather?lat={lat}&lon={lon}&appid={API key}
    /// makeDataRequest - manda uma requisição para abir  o site weahter map e se a requisiçnao for tudo bem entao chama o nosso complition handler com o weather model do objeto 
    private func makeDataRequest (forCoodiantes coordinates: CLLocationCoordinate2D) {
        guard let urlString = "https://api.openweathermap.org/data/2.5/weather?lat=\(coordinates.latitude)&lon=\(coordinates.longitude)&appid=\(API_KEY)&units=metric&lang=pt_br"
            .addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else { return }
        guard let url = URL(string: urlString) else { return }

        URLSession.shared.dataTask(with: url) { data, response, error in
            guard error == nil, let data = data else { return }
            if let response = try? JSONDecoder().decode(APIResponse.self, from: data) {
                self.complitionHandler?(Weather(response: response))
            } //end if let response
        } //end URLSession
        .resume()
    } //end private func makeDataRequest
} //end public final class WeatherService

struct APIResponse: Decodable {
    let name: String
    let main: APIMain
    let weather: [APIWeather]
} //end struct APIResponse

struct APIMain: Decodable {
    let temp: Double
} //end struct APIMain


struct APIWeather: Decodable {
    let description: String
    let iconName: String

    enum CodingKeys: String, CodingKey {
        case description
        case iconName = "main"
    } //end enum codingKeys
} //end struct APIWeater

extension WeatherService: CLLocationManagerDelegate {
    //primeiro metodo é acionando quando a localização do usuario é atualizada
    public func locationManager (_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        //vamos tentar receber a primeira localização dentro desta lista e se for capaz de receber isso entao vamos enviar uma requisição usando a função MakeDataRequest
        guard let location = locations.first else { return }
        makeDataRequest(forCoodiantes: location.coordinate)
    } //end public locationManager

    public func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Something went wrong: \(error.localizedDescription)")
    } //end public func locationManager()
} //end extension WeatherService

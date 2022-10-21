//
//  ViewModel.swift
//  WeatherApp
//
//  Created by Tim Wagner on 21.10.22.
//

import Foundation

class WeatherVM : ObservableObject {
    @Published
    var description: String
    
    init() {
        description = "Drücken Sie den Knopf."
    }
    
    func fetchWeather() {
        var urlComponents = URLComponents()
        
        urlComponents.scheme = "https"
        urlComponents.host = "api.openweathermap.org"
        urlComponents.path = "/data/2.5/weather"
        urlComponents.queryItems = [
            URLQueryItem(name: "lang", value: "de"),
            URLQueryItem(name: "lat", value: "50.31297"),
            URLQueryItem(name: "lon", value: "11.91261"),
            URLQueryItem(name: "appid", value: Constants.apiKey),
        ]
        
        let response = NetworkClerk().getJsonFrom(urlComponents: urlComponents)
        
        guard let weatherData = response.1 else {
            description = "Fehler beim Abrufen der Daten. (\(response.0))"
            return
        }
        
        description = weatherData.weather.description
    }
}

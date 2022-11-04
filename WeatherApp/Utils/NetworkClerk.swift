//
//  NetworkClerk.swift
//  WeatherApp
//
//  Created by Tim Wagner on 21.10.22.
//

import Foundation

enum NetworkError {
    case url
    case prepare
    case decode
    case okay
}

class NetworkClerk {
    func getWeatherJsonFor(lat: String, lon: String) -> (NetworkError, ServerResponse?) {
        var urlComponents = URLComponents()
        
        urlComponents.scheme = "https"
        urlComponents.host = "api.openweathermap.org"
        urlComponents.path = "/data/2.5/weather"
        urlComponents.queryItems = [
            URLQueryItem(name: "lang", value: "de"),
            URLQueryItem(name: "units", value: "metric"),
            URLQueryItem(name: "lat", value: lat),
            URLQueryItem(name: "lon", value: lon),
            URLQueryItem(name: "appid", value: Constants.apiKey),
        ]
        
        guard let url = urlComponents.url else {
            return (.url, nil)
        }
        
        guard let rawData = try? Data(contentsOf: url) else {
            return (.prepare, nil)
        }
        
        guard let weather = try? JSONDecoder().decode(ServerResponse.self, from: rawData) else {
            return (.decode, nil)
        }
        
        return (.okay, weather)
    }
}

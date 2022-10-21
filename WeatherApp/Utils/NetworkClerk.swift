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
    func getJsonFrom(urlComponents: URLComponents) -> (NetworkError, WeatherResponse?) {
        guard let url = urlComponents.url else {
            return (.url, nil)
        }
        
        guard let rawData = try? Data(contentsOf: url) else {
            return (.prepare, nil)
        }
        
        guard let weather = try? JSONDecoder().decode(WeatherResponse.self, from: rawData) else {
            return (.decode, nil)
        }
        
        return (.okay, weather)
    }
}

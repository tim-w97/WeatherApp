//
//  NetworkClerk.swift
//  WeatherApp
//
//  Created by Tim Wagner on 21.10.22.
//

import Foundation
import Combine

class NetworkClerk {
    
    fileprivate var cancellable: AnyCancellable?
    
    let modelInterface = ModelInterface()
    
    func fetchWeather(forId: UUID, lat: Double, lon: Double) {
        
        var urlComponents = URLComponents()
        
        urlComponents.scheme = "https"
        urlComponents.host = "api.openweathermap.org"
        urlComponents.path = "/data/2.5/weather"
        urlComponents.queryItems = [
            URLQueryItem(name: "lang", value: "de"),
            URLQueryItem(name: "units", value: "metric"),
            URLQueryItem(name: "lat", value: String(lat)),
            URLQueryItem(name: "lon", value: String(lon)),
            URLQueryItem(name: "appid", value: Constants.apiKey),
        ]
        
        guard let url = urlComponents.url else {
            return
        }
        
        cancellable = URLSession.shared.dataTaskPublisher(for: url)
            .receive(on: DispatchQueue.main)
            .map { $0.data }
            .decode(type: ServerResponse.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
            .sink(receiveCompletion: {
                print("Received completion: \($0)")
            }, receiveValue: { response in
                let updatedWeather = WeatherData(serverResponse: response)
                self.modelInterface.updateEntry(withId: forId, newEntry: updatedWeather)
            })
    }
}

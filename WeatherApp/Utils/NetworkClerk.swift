//
//  NetworkClerk.swift
//  WeatherApp
//
//  Created by Tim Wagner on 21.10.22.
//

import Foundation
import Combine

class NetworkClerk {
    
    static let shared = NetworkClerk()
    
    fileprivate var cancellables: [AnyCancellable?] = []
    
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
        
        var cancellable: AnyCancellable?
        
        cancellable = URLSession.shared.dataTaskPublisher(for: url)
            // RunLoop.main wird (genauso wie Benutzereingaben) dringlich behandelt
            // Dringlichkeit von DispatchQueue.main kann vom BS bestimmt werden
            .receive(on: DispatchQueue.main)
            .map { $0.data }
            .decode(type: ServerResponse.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
            .sink(receiveCompletion: { completion in
                // receiveCompletion closure wird nur einmal aufgerufen
                // deswegen lieber hier aufräumen

                switch completion {
                case .finished:
                    print("Finished fetching weather")
                    break
                    
                case .failure(let error):
                    print(error.localizedDescription)
                    
                    self.modelInterface.setErrorHasOccurred(to: true)
                    
                    break
                    
                    #error("wetter daten auf nil setzen und error string anzeigen, error string ist immer da")
                }
                
                self.cancellables.removeAll(where: { storedCancellable in
                    storedCancellable == cancellable
                })
            }, receiveValue: { responseData in
                // receiveValue closure wird evtl. mehrmals aufgerufen
                
                let updatedWeather = WeatherData(responseData: responseData)
                self.modelInterface.updateEntry(withId: forId, newEntry: updatedWeather)
            })
        
        cancellables.append(cancellable)
    }
}

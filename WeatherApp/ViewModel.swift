//
//  ViewModel.swift
//  WeatherApp
//
//  Created by Tim Wagner on 21.10.22.
//

import Foundation

class WeatherVM : ObservableObject {
    @Published
    var weatherEntries: [WeatherData]
    
    var lat: String = ""
    var lon: String = ""
    
    let modelInterface = ModelInterface()
    
    init() {
        weatherEntries = []
        loadWeatherEntries()
    }
    
    func addCity() {
        guard let weatherResponse = fetchWeather() else {
            return
        }
        
        let newWeatherData = WeatherData(
            id: weatherResponse.id,
            city: weatherResponse.name,
            temp: Int(weatherResponse.main.temp)
        )
        
        modelInterface.addEntry(entry: newWeatherData)
        
        loadWeatherEntries()
        
        lat = ""
        lon = ""
    }
    
    func moveEntries(_ indices: IndexSet, to: Int) {
        weatherEntries.move(fromOffsets: indices, toOffset: to)
    }
    
    func removeEntries(indices: IndexSet) {
        for index in indices {
            let id = weatherEntries[index].id
            modelInterface.removeEntry(id: id)
        }
        
        loadWeatherEntries()
    }
    
    private func loadWeatherEntries() {
        weatherEntries = []
        
        guard let firstEntry = modelInterface.getFirstEntry() else {
            return
        }
        
        var entry: WeatherData? = firstEntry
        
        while entry != nil {
            weatherEntries.append(entry!)
            entry = modelInterface.getNextEntry()
        }
    }
    
    func fetchWeather() -> WeatherResponse? {
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
        
        let response = NetworkClerk().getJsonFrom(urlComponents: urlComponents)
        
        print(response.0)
        
        return response.1
    }
}

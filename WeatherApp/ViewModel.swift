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
    
    let modelInterface = ModelInterface()
    
    init() {
        weatherEntries = []
        loadWeatherEntries()
    }
    
    func refreshEntries() {
        for entry in weatherEntries {
            guard let serverResponse = fetchWeather(lat: entry.lat, lon: entry.lon) else {
                return
            }
            
            let newWeatherData = WeatherData(
                serverResponse: serverResponse
            )
            
            modelInterface.updateEntry(withId: entry.id, newEntry: newWeatherData)
        }
        
        loadWeatherEntries()
    }
    
    /*
    func addCity() {
        guard let serverResponse = fetchWeather(lat: lat, lon: lon) else {
            return
        }
        
        let newWeatherData = WeatherData(
            serverResponse: serverResponse
        )
        
        modelInterface.addEntry(entry: newWeatherData)
        
        loadWeatherEntries()
    }
     */
    
    func moveEntries(_ indices: IndexSet, to: Int) {
        modelInterface.moveEntries(fromOffsets: indices, toOffset: to)
        loadWeatherEntries()
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
    
    private func fetchWeather(lat: Double, lon: Double) -> ServerResponse? {
        let response = NetworkClerk().getWeatherJsonFor(
            lat: String(lat),
            lon: String(lon)
        )
        
        print(response.0)
        
        return response.1
    }
}

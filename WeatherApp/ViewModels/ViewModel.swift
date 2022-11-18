//
//  ViewModel.swift
//  WeatherApp
//
//  Created by Tim Wagner on 21.10.22.
//

import Foundation
import Combine

class WeatherVM : ObservableObject {
    @Published
    var weatherEntries: [WeatherData]
    
    let modelInterface = ModelInterface()
    
    var subscription: AnyCancellable?
    
    init() {
        weatherEntries = []
        loadWeatherEntries()
        
        subscription = modelInterface.modelNotifier().sink {
            self.weatherEntries = []
            self.loadWeatherEntries()
        }
    }
    
    func refreshEntries() {
        for entry in weatherEntries {
            fetchWeather(forId: entry.id, lat: entry.lat, lon: entry.lon)
        }
    }
    
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
    
    func fetchWeather(forId: UUID, lat: Double, lon: Double) {
        NetworkClerk.shared.fetchWeather(forId: forId, lat: lat, lon: lon)
    }
}

//
//  ViewModel.swift
//  WeatherApp
//
//  Created by Tim Wagner on 21.10.22.
//

import Foundation
import Combine
import MapKit

class WeatherVM : ObservableObject {
    @Published
    var weatherEntries: [WeatherData]
    
    @Published var errorHasOccurred = false
    
    @Published var bottomSheetIsVisible = false
    
    @Published var mapLocation: CLLocationCoordinate2D
    
    let modelInterface = ModelInterface()
    
    var subscription: AnyCancellable?
    
    init() {
        mapLocation = CLLocationCoordinate2D()
        
        weatherEntries = []
        loadWeatherEntries()
        
        subscription = modelInterface.modelNotifier()
            .sink{
                self.weatherEntries = []
                
                if self.modelInterface.errorHasOccurred() {
                    self.errorHasOccurred = true
                    return
                }
                
                self.loadWeatherEntries()
            }
        
        initMap()
    }
    
    private func initMap() {
        guard let firstWeatherEntry = weatherEntries.first else {
            return
        }
        
        mapLocation.latitude = firstWeatherEntry.lat
        mapLocation.longitude = firstWeatherEntry.lon
    }

    func refreshEntries() {
        modelInterface.setErrorHasOccurred(to: false)
        errorHasOccurred = false
        
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

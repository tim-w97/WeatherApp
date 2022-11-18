//
//  Database.swift
//  WeatherApp
//
//  Created by Tim Wagner on 04.11.22.
//

import Foundation

class Database : ObservableObject {
    static let sharedInstance = Database()
    
    @Published var modelHasChanged = false
    
    var weatherEntries : [WeatherData] = [
        WeatherData(weatherId: 1, city: "Bla", temp: -999, lat: 50.717758, lon: 11.329310),
        WeatherData(weatherId: 2, city: "Bli", temp: -999, lat: 52.520008, lon: 13.404954),
        WeatherData(weatherId: 3, city: "Blubb", temp: -999, lat: 51.088470, lon: 11.623660)
    ]
}

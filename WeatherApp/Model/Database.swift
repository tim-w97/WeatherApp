//
//  Database.swift
//  WeatherApp
//
//  Created by Tim Wagner on 04.11.22.
//

import Foundation

class Database {
    static let sharedInstance = Database()
    
    var weatherEntries : [WeatherData] = [
        WeatherData(id: 1, city: "Rudolstadt", temp: -999, lat: 50.717758, lon: 11.329310),
        WeatherData(id: 2, city: "Berlin", temp: -999, lat: 52.520008, lon: 13.404954),
        WeatherData(id: 3, city: "Bad Sulza", temp: -999, lat: 51.088470, lon: 11.623660)
    ]
}

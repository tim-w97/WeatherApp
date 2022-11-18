//
//  WeatherData.swift
//  WeatherApp
//
//  Created by Tim Wagner on 21.10.22.
//

import Foundation

struct WeatherData : Identifiable {
    let id: UUID
    let weatherId: Int
    let city: String
    let temp: Double
    
    let lat: Double
    let lon: Double
    
    init(responseData: ServerResponse) {
        id = UUID()
        weatherId = responseData.id
        city = responseData.name
        temp = responseData.main.temp
        
        lat = responseData.coord.lat
        lon = responseData.coord.lon
    }
    
    // For Preview
    init() {
        id = UUID()
        weatherId = 42
        city = "Buxtehude"
        temp = 23.4
        
        lat = 53
        lon = 10
    }
    
    init(weatherId: Int, city: String, temp: Double, lat: Double, lon: Double) {
        self.id = UUID()
        self.weatherId = weatherId
        self.city = city
        self.temp = temp
        self.lat = lat
        self.lon = lon
    }
}

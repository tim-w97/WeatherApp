//
//  Model.swift
//  WeatherApp
//
//  Created by Tim Wagner on 21.10.22.
//

import Foundation

class ModelInterface {
    func addEntry(entry: WeatherData) {
        Database.sharedInstance.weatherEntries.removeAll(where: { existingEntry in
            existingEntry.city == entry.city
        })
        
        Database.sharedInstance.weatherEntries.append(entry)
    }
    
    func removeEntry(city: String) {
        Database.sharedInstance.weatherEntries.removeAll(where: { entry in
            entry.city == city
        })
    }
}

class Database {
    static let sharedInstance = Database()
    
    var weatherEntries : [WeatherData] = [
        WeatherData(id: 0, city: "Erfurt", temp: 12),
        WeatherData(id: 1, city: "Hof", temp: 14),
        WeatherData(id: 2, city: "Buxtehude", temp: 19),
        WeatherData(id: 3, city: "Köthen", temp: 4),
        WeatherData(id: 4, city: "Aschersleben", temp: 10)
    ]
}

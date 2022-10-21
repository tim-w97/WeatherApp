//
//  Model.swift
//  WeatherApp
//
//  Created by Tim Wagner on 21.10.22.
//

import Foundation

class ModelInterface {
    var index: Int = 0
    
    func getFirstEntry() -> WeatherData? {
        index = 0
        
        if Database.sharedInstance.weatherEntries.count == 0 {
            return nil
        }
        
        return Database.sharedInstance.weatherEntries[index]
    }
    
    func getNextEntry() -> WeatherData? {
        index += 1
        
        if index >= Database.sharedInstance.weatherEntries.count {
            return nil
        }
        
        return Database.sharedInstance.weatherEntries[index]
    }
    
    func addEntry(entry: WeatherData) {
        Database.sharedInstance.weatherEntries.append(entry)
    }
    
    func removeEntry(id: Int) {
        Database.sharedInstance.weatherEntries.removeAll(where: { entry in
            entry.id == id
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

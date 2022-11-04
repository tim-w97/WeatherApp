//
//  Model.swift
//  WeatherApp
//
//  Created by Tim Wagner on 21.10.22.
//

import Foundation

class ModelInterface {
    var index: Int = 0
    
    func updateEntry(withObjectId: UUID, newEntry: WeatherData) {
        guard let indexToUpdate = Database.sharedInstance.weatherEntries.firstIndex(where: { entry in
            entry.objectId == withObjectId
        }) else {
            return
        }
        
        Database.sharedInstance.weatherEntries[indexToUpdate] = newEntry
    }
    
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

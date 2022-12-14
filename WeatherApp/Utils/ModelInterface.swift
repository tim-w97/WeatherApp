//
//  Model.swift
//  WeatherApp
//
//  Created by Tim Wagner on 21.10.22.
//

import Foundation
import Combine

class ModelInterface {
    var index: Int = 0
    
    func moveEntries(fromOffsets: IndexSet, toOffset: Int) {
        Database.sharedInstance.weatherEntries.move(fromOffsets: fromOffsets, toOffset: toOffset)
        
        readyToUse()
    }
    
    func errorHasOccurred() -> Bool {
        return Database.sharedInstance.errorHasOccurred
    }
    
    func setErrorHasOccurred(to: Bool) {
        Database.sharedInstance.errorHasOccurred = to
        
        readyToUse()
    }
    
    func updateEntry(withId: UUID, newEntry: WeatherData) {
        guard let indexToUpdate = Database.sharedInstance.weatherEntries.firstIndex(where: { entry in
            entry.id == withId
        }) else {
            return
        }
        
        Database.sharedInstance.weatherEntries[indexToUpdate] = newEntry
        
        readyToUse()
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
        
        readyToUse()
    }
    
    func removeEntry(id: UUID) {
        Database.sharedInstance.weatherEntries.removeAll(where: { entry in
            entry.id == id
        })
    }
    
    func modelNotifier() -> ObservableObjectPublisher {
        return Database.sharedInstance.objectWillChange
    }
    
    func readyToUse() {
        Database.sharedInstance.modelHasChanged = true
    }
}

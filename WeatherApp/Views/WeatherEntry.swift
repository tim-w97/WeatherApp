//
//  WeatherEntry.swift
//  WeatherApp
//
//  Created by Tim Wagner on 21.10.22.
//

import SwiftUI

struct WeatherEntry: View {
    // TODO: create a dedicated struct for the view
    
    // TODO: Error String einbauen, vllt mit umgebendem Struct Container, testen: WLAN ausmachen
    let data : WeatherData
    
    var body: some View {
        HStack {
            Text(data.city)
            Spacer()
            Text(String(format: "%.2f", data.temp) + " °C")
        }
    }
}

struct WeatherEntry_Previews: PreviewProvider {
    static var previews: some View {
        WeatherEntry(data: WeatherData())
    }
}

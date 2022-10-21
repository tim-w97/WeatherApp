//
//  ContentView.swift
//  WeatherApp
//
//  Created by Tim Wagner on 21.10.22.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var vm: WeatherVM
    
    var body: some View {
        /*
        NavigationStack {
            List(vm.weatherEntries) {entry in
                WeatherEntry(data: entry)
            }.navigationTitle("Deine Orte")
        }
         */
        
        VStack {
            Text(vm.description).padding()
            Button("Wetterdaten abrufen", action: {
                vm.fetchWeather()
            })
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(vm: WeatherVM())
    }
}

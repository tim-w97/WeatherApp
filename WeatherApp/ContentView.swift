//
//  ContentView.swift
//  WeatherApp
//
//  Created by Tim Wagner on 21.10.22.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject
    var vm: WeatherVM
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(vm.weatherEntries) { entry in
                    WeatherEntry(data: entry)
                }
                .onMove { indices, newIndex in
                    vm.moveEntries(indices, to: newIndex)
                }
                .onDelete { indices in
                    vm.removeEntries(indices: indices)
                }
            }
            .navigationTitle("Deine Orte")
            .toolbar {
                TextField("Breitengrad", text: $vm.lat)
                TextField("Längengrad", text: $vm.lon)
                Button("Hinzufügen") {
                    vm.addCity()
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(vm: WeatherVM())
    }
}

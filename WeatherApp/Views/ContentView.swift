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
            if(vm.errorHasOccurred) {
                Text("Es ist ein Fehler passiert. 😪\nBitte versuche es später nochmal.")
                    .foregroundColor(.red)
                    .padding()
            }
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
            .refreshable {
                vm.refreshEntries()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(vm: WeatherVM())
    }
}

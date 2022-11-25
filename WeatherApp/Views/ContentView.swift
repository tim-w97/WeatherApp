//
//  ContentView.swift
//  WeatherApp
//
//  Created by Tim Wagner on 25.11.22.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var vm: WeatherVM
    
    var body: some View {
        TabView {
            CityList(vm: vm)
                .tabItem {
                    Label("Städte", systemImage: "location")
                }
            
            MapView(vm: vm)
                .tabItem {
                    Label("Karte", systemImage: "map")
                }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(vm: WeatherVM())
    }
}

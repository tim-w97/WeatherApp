//
//  WeatherAppApp.swift
//  WeatherApp
//
//  Created by Tim Wagner on 21.10.22.
//

import SwiftUI

@main
struct WeatherApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView(vm: WeatherVM())
        }
    }
}

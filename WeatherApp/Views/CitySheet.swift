//
//  CitySheet.swift
//  WeatherApp
//
//  Created by Tim Wagner on 25.11.22.
//

import SwiftUI

struct CitySheet: View {
    @Binding var visibleBinding: Bool
    
    let city: String
    
    var body: some View {
        VStack {
            Text("Willkommen bei")
            
            Text(city)
                .font(.largeTitle)
            
            Button("Ich will wieder hier raus. 🏃🏻") {
                visibleBinding = false
            }.buttonStyle(.bordered)
        }
    }
}

struct CitySheet_Previews: PreviewProvider {
    static var previews: some View {
        CitySheet(visibleBinding: .constant(true), city: "Buxtehude")
    }
}

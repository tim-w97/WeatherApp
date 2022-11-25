//
//  MapView.swift
//  WeatherApp
//
//  Created by Tim Wagner on 25.11.22.
//

import SwiftUI
import MapKit

struct MapView: View {
    @ObservedObject
    var vm: WeatherVM
    
    let dummyCity = City(name: "Jena", location: CLLocationCoordinate2D(
        latitude: 50.927223, longitude: 11.586111
    ))
    
    @State var region : MKCoordinateRegion
    
    let dummyCities = [
        City(name: "Jena", location: CLLocationCoordinate2D(
            latitude: 50.927223, longitude: 11.586111
        ))
    ]
    
    init(vm: WeatherVM) {
        self.vm = vm
        
        _region = State(initialValue: MKCoordinateRegion(
            center: vm.mapLocation,
            // how much should be visible?
            span: MKCoordinateSpan(
                latitudeDelta: 0.5,
                longitudeDelta: 0.5
            )
        ))
    }
    
    var body: some View {
        Map(coordinateRegion: $region, annotationItems: vm.weatherEntries)
        { weatherData in
            MapAnnotation(coordinate: CLLocationCoordinate2D(
                latitude: weatherData.lat,
                longitude: weatherData.lon
            )) {
                Image(systemName: "chevron.down")
                    .font(.system(size: 80))
                    .foregroundColor(.red)
                    .shadow(radius: 100)
                    .onTapGesture {
                        vm.bottomSheetIsVisible = true
                    }.sheet(isPresented: $vm.bottomSheetIsVisible, content: {
                        CitySheet(
                            visibleBinding: $vm.bottomSheetIsVisible,
                            city: weatherData.city
                        )
                    })
            }
        }
    }
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView(vm: WeatherVM())
    }
}

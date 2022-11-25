//
//  City.swift
//  WeatherApp
//
//  Created by Tim Wagner on 25.11.22.
//

import Foundation
import MapKit

struct City : Identifiable {
    let id = UUID()
    let name: String
    let location: CLLocationCoordinate2D
}

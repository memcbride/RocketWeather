// ------------------------------------------------------
// Project: RocketWeather
// File: City.swift
// Created by Mark McBride on 2024.09.05
// Last Updated:  2024.09.06
// GitHub: https://github.com/memcbride
// ------------------------------------------------------
// Copyright © 2024 by MacModeler.  All rights reserved.


import Foundation
import CoreLocation

struct City: Identifiable, Hashable {
    var id = UUID()
    var name: String
    var latitude: Double
    var longitude: Double
    
    var coordinate: CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
    
    var clLocation: CLLocation {
        CLLocation(latitude: latitude, longitude: longitude)
    }
    
    static var cities: [City] {
        [
            .init(name: "Paris, France", latitude: 48.856788, longitude: 2.351077),
            .init(name: "Syndey, Australia", latitude: -33.872710, longitude: 151.205694),
            .init(name: "Washington, DC", latitude: 38.895438, longitude: -77.031281),
            .init(name: "Cincinnati", latitude: 39.07642, longitude: -84.33590)
        ]
    }
    
    static var mockCurrent: City {
        .init(name: "Cincinnati", latitude: 39.07642, longitude: -84.33590)
    }
}

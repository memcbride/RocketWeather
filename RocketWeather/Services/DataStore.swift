// ------------------------------------------------------
// Project: RocketWeather
// File: DataStore.swift
// Created by Mark McBride on 2024.09.08
// Last Updated:  2024.09.08
// GitHub: https://github.com/memcbride
// ------------------------------------------------------
// Copyright © 2024 by MacModeler.  All rights reserved.


import Foundation

@Observable
class DataStore {
    var forPreviews: Bool
    var cities: [City]
    
    init(forPreviews: Bool = false) {
        self.forPreviews = forPreviews
        self.cities = []
        self.cities = loadCities()
    }
    
    func loadCities() -> [City] {
        if forPreviews {
            return City.cities
        } else {
            return []
        }
    }
}

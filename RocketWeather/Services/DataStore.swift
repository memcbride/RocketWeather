// ------------------------------------------------------
// Project: RocketWeather
// File: DataStore.swift
// Created by Mark McBride on 2024.09.08
// Last Updated:  2024.09.09
// GitHub: https://github.com/memcbride
// ------------------------------------------------------
// Copyright © 2024 by MacModeler.  All rights reserved.


import Foundation

@Observable
class DataStore {
    var forPreviews: Bool
    var cities: [City]
    let filemanager = FileManager()
    
    init(forPreviews: Bool = false) {
        self.forPreviews = forPreviews
        self.cities = []
        self.cities = loadCities()
    }
    
    func loadCities() -> [City] {
        if forPreviews {
            return City.cities
        } else {
            if filemanager.fileExists() {
                do {
                    let data = try filemanager.readFile()
                    cities = try JSONDecoder().decode([City].self, from: data)
                } catch {
                    print(error.localizedDescription)
                }
            }
            return cities
        }
    }
    
    func saveCities() {
        if !forPreviews {
            do {
                let data = try JSONEncoder().encode(cities)
                let jsonString = String(decoding: data, as: UTF8.self)
                try filemanager.saveFile(contents: jsonString)
            } catch {
                print(error.localizedDescription)
            }
        }
    }
}

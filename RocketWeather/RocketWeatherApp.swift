// ------------------------------------------------------
// Project: RocketWeather
// File: RocketWeatherApp.swift
// Created by Mark McBride on 2024.09.05
// Last Updated:  2024.09.09
// GitHub: https://github.com/memcbride
// ------------------------------------------------------
// Copyright © 2024 by MacModeler.  All rights reserved.


import SwiftUI

@main
struct RocketWeatherApp: App {
    @State private var locationManager = LocationManager()
    @State private var store = DataStore()
    var body: some Scene {
        WindowGroup {
            if locationManager.isAuthorized {
                ForecastView()
                    .onAppear {
                        print(URL.documentsDirectory.path())
                    }
            } else {
                LocationDeniedView()
            }
        }
        .environment(locationManager)
        .environment(store)
    }
}

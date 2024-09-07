// ------------------------------------------------------
// Project: RocketWeather
// File: CurrentWeatherView.swift
// Created by Mark McBride on 2024.09.06
// Last Updated:  2024.09.06
// GitHub: https://github.com/memcbride
// ------------------------------------------------------
// Copyright © 2024 by MacModeler.  All rights reserved.


import SwiftUI
import WeatherKit

struct CurrentWeatherView: View {
    let weatherManager = WeatherManager.shared
    let currentWeather: CurrentWeather
    let highTemperature: String?
    let lowTemperature: String?
    let timezone: TimeZone
    var body: some View {
        Text(currentWeather.date.localDate(for: timezone))
        Text(currentWeather.date.localTime(for: timezone))
        Image(systemName: currentWeather.symbolName)
            .renderingMode(.original)
            .symbolVariant(.fill)
            .font(.system(size: 60.0,weight: .bold))
            .padding()
            .background(
                RoundedRectangle(cornerRadius: 20)
                    .fill(.secondary.opacity(0.2))
            )
        let temp = weatherManager.temperatureFormatter.string(from: currentWeather.temperature)
        Text(temp)
            .font(.title2)
        if let highTemperature, let lowTemperature {
            Text("H: \(highTemperature) L:\(lowTemperature)")
                .bold()
        }
        Text(currentWeather.condition.description)
            .font(.title3)
    }
}


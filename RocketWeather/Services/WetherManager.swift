// ------------------------------------------------------
// Project: RocketWeather
// File: WetherManager.swift
// Created by Mark McBride on 2024.09.05
// Last Updated:  2024.09.07
// GitHub: https://github.com/memcbride
// ------------------------------------------------------
// Copyright © 2024 by MacModeler.  All rights reserved.

import Foundation
import WeatherKit
import CoreLocation

class WeatherManager {
    static let shared = WeatherManager()
    let service = WeatherService.shared
    
    var temperatureFormatter: MeasurementFormatter = {
        let formatter = MeasurementFormatter()
        formatter.numberFormatter.maximumFractionDigits = 0
        return formatter
    }()
    
    func currentWeather (for location: CLLocation) async -> CurrentWeather? {
        let currentWeather = await Task.detached(priority: .userInitiated) {
            let forecast = try? await self.service.weather(
                for: location,
                including: .current
            )
            return forecast
        }.value
        return currentWeather
    }
    
    func hourlyForecast (for location: CLLocation) async -> Forecast<HourWeather>? {
        let hourlyForecast = await Task.detached(priority: .userInitiated) {
            let forecast = try? await self.service.weather(
                for: location,
                including: .hourly
            )
            return forecast
        }.value
        return hourlyForecast
    }
    
    func dailyForecast (for location: CLLocation) async -> Forecast<DayWeather>? {
        let dailyForecast = await Task.detached(priority: .userInitiated) {
            let forecast = try? await self.service.weather(
                for: location,
                including: .daily
            )
            return forecast
        }.value
        return dailyForecast
    }
    
    func weatherAttribution() async -> WeatherAttribution? {
        let attribution = await Task(priority: .userInitiated) {
            return try? await self.service.attribution
        }.value
        return attribution
    }
}

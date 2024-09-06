// ------------------------------------------------------
// Project: RocketWeather
// File: ContentView.swift
// Created by Mark McBride on 2024.09.05
// Last Updated:  2024.09.06
// GitHub: https://github.com/memcbride
// ------------------------------------------------------
// Copyright © 2024 by MacModeler.  All rights reserved.

// 39.07642° N, 84.33590° W

import SwiftUI
import WeatherKit
import CoreLocation

struct ForecastView: View {
    @Environment(LocationManager.self) var locationManager
    @Environment(\.scenePhase) private var scenePhase
    @State private var selectedCity: City?
    let weatherManager = WeatherManager.shared
    @State private var currentWeather: CurrentWeather?
    @State private var isLoading = false
    @State private var showCityList = false
    @State private var timezone: TimeZone = .current
    
    var body: some View {
        VStack {
            if let selectedCity {
                if isLoading {
                    ProgressView()
                    Text("Fetching Weather...")
                } else {
                    Text(selectedCity.name)
                        .font(.title)
                    if let currentWeather {
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
                        Text(currentWeather.condition.description)
                            .font(.title3)
                        Spacer()
                        AttributionView()
                            .tint(.white)
                    }
                }
            }
        }
        .padding()
        .background {
            if selectedCity != nil,
               let condition = currentWeather?.condition {
                BackgroundView(condition: condition)
            }
        }
        .preferredColorScheme(.dark)
        .safeAreaInset(edge: .bottom) {
            Button {
                showCityList.toggle()
            } label: {
                Image(systemName: "list.star")
            }
            .padding()
            .background(Color(.darkGray))
            .clipShape(.circle)
            .foregroundStyle(.white)
            .padding(.horizontal)
            .frame(maxWidth: .infinity, alignment: .trailing)
        }
        .fullScreenCover(isPresented: $showCityList) {
            CitiesListView(currentLocation: locationManager.currentLocation, selectedCity: $selectedCity)
        }
        .onChange(of: scenePhase) {
            if scenePhase == .active {
                selectedCity = locationManager.currentLocation
                if let selectedCity {
                    Task {
                        await fetchWeather(for: selectedCity)
                    }
                }
            }
        }
        .task(id: locationManager.currentLocation) {
            if let currentLocation = locationManager.currentLocation, selectedCity == nil {
                selectedCity = currentLocation
            }
        }
        .task(id: selectedCity) {
            if let selectedCity {
                await fetchWeather(for: selectedCity)
            }
        }
    }
    
    func fetchWeather(for city: City) async {
        isLoading = true
        Task.detached { @MainActor in
            currentWeather = await weatherManager.currentWeather(for: city.clLocation)
            timezone = await locationManager.getTimezone(for: city.clLocation)
        }
        isLoading = false
    }
}

#Preview {
    ForecastView()
        .environment(LocationManager())
}

// ------------------------------------------------------
// Project: RocketWeather
// File: CitiesListView.swift
// Created by Mark McBride on 2024.09.06
// Last Updated:  2024.09.06
// GitHub: https://github.com/memcbride
// ------------------------------------------------------
// Copyright © 2024 by MacModeler.  All rights reserved.


import SwiftUI

struct CitiesListView: View {
    @Environment(\.dismiss) private var dismiss
    let currentLocation: City?
    @Binding var selectedCity: City?
    
    var body: some View {
        NavigationStack {
            List {
                if let currentLocation {
                    Text(currentLocation.name)
                        .onTapGesture {
                            selectedCity = currentLocation
                            dismiss()
                        }
                }
                ForEach(City.cities) { city in
                    Text(city.name)
                        .onTapGesture {
                            selectedCity = city
                            dismiss()
                        }
                }
            }
            .listStyle(.plain)
            .navigationTitle("My Cities")
            .navigationBarTitleDisplayMode(.inline)
            .preferredColorScheme(.dark)
        }
    }
}

#Preview {
    CitiesListView(currentLocation: City.mockCurrent, selectedCity: .constant(nil))
}

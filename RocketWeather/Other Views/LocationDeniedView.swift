// ------------------------------------------------------
// Project: RocketWeather
// File: LocationDeniedView.swift
// Created by Mark McBride on 2024.09.05
// Last Updated:  2024.09.06
// GitHub: https://github.com/memcbride
// ------------------------------------------------------
// Copyright © 2024 by MacModeler.  All rights reserved.


import SwiftUI

struct LocationDeniedView: View {
    var body: some View {
        ContentUnavailableView {
            Label("Location Services",systemImage: "gear")
        } description: {
            Text("""
1. Tap on the button below to go to "Privacy and Security"
2. Tap on "Location Services"
3. Locate the "RocketWeather" app and tap on it
4. Change the setting to "While Using the App"
""").multilineTextAlignment(.leading)
        } actions: {
            Button(action:{
                UIApplication.shared.open(
                    URL(string: UIApplication.openSettingsURLString)!,
                    options: [:],
                    completionHandler: nil
                )
            }) {
                Text("Open Settings")
            }
            .buttonStyle(.borderedProminent)
        }

    }
}

#Preview {
    LocationDeniedView()
}

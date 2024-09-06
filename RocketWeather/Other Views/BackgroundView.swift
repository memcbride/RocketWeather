// ------------------------------------------------------
// Project: RocketWeather
// File: BackgroundView.swift
// Created by Mark McBride on 2024.09.06
// Last Updated:  2024.09.06
// GitHub: https://github.com/memcbride
// ------------------------------------------------------
// Copyright © 2024 by MacModeler.  All rights reserved.


import SwiftUI
import WeatherKit

struct BackgroundView: View {
    let condition: WeatherCondition
    
    var body: some View {
        Image(condition.rawValue)
            .blur(radius: 5)
            .colorMultiply(.white.opacity(0.8))
    }
}

#Preview {
    BackgroundView(condition: .cloudy)
}

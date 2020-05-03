//
//  DoubleExtension.swift
//  LocationWeather
//
//  Created by Vivatum on 30/04/2020.
//  Copyright © 2020 com.vivatum. All rights reserved.
//

import Foundation

extension Double {
    
    func kelvinToString() -> String {
        let formatter = MeasurementFormatter()
        formatter.unitStyle = .medium
        formatter.locale = Locale.current
        let measurementKelvin = Measurement(value: self, unit: UnitTemperature.kelvin)
        return formatter.string(from: measurementKelvin)
    }
}

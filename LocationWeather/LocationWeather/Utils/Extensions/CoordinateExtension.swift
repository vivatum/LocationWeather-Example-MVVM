//
//  CoordinateExtension.swift
//  LocationWeather
//
//  Created by Vivatum on 01/05/2020.
//  Copyright © 2020 com.vivatum. All rights reserved.
//

import MapKit

extension CLLocationCoordinate2D {
    
    func shortToString() -> String {
        let latString = String(format: "%.3f", self.latitude)
        let lonString = String(format: "%.3f", self.longitude)
        return "lat: \(latString), lon: \(lonString)"
    }
    
    func longToString(_ needTwoLines: Bool = false) -> String {
        let latString = String(describing: self.latitude)
        let lonString = String(describing: self.longitude)
        let newLineSym = needTwoLines ? "\n" : " "
        return "lat: \(latString),\(newLineSym)lon: \(lonString)"
    }
}

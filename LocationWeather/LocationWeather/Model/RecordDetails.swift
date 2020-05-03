//
//  RecordDetails.swift
//  LocationWeather
//
//  Created by Vivatum on 30/04/2020.
//  Copyright © 2020 com.vivatum. All rights reserved.
//

import Foundation
import MapKit

struct RecordDetails {
    
    let dataString: String
    let latitude: Double
    let longitude: Double
    let description: String
    let temperatureDalyMax: String
    
    init(weatherRecord: WeatherRecord, maxTemperature: Double) {
        dataString = weatherRecord.date.toString(format: .longDateAndTime)
        latitude = Double(weatherRecord.latitude)
        longitude = Double(weatherRecord.longitude)
        description = weatherRecord.weatherDescription
        temperatureDalyMax = maxTemperature.kelvinToString()
    }
}

extension RecordDetails {
    
//    func longCoordinateToString() -> String {
//        let latString = String(describing: self.latitude)
//        let lonString = String(describing: self.longitude)
//        return "lat: \(latString)\nlon: \(lonString)"
//    }
    
    func coordinate() -> CLLocationCoordinate2D {
        return CLLocationCoordinate2D(latitude: Double(self.latitude), longitude: Double(self.longitude))
    }
    
    func weatherDescription() -> String {
        return self.description + ",\nmax t: \(self.temperatureDalyMax)"
    }
}

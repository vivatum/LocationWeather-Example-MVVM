//
//  RecordAnnotation.swift
//  LocationWeather
//
//  Created by Vivatum on 30/04/2020.
//  Copyright © 2020 com.vivatum. All rights reserved.
//

import MapKit

final class RecordAnnotation: MKPointAnnotation {

    var details: RecordDetails
    
    init(details: RecordDetails) {
        self.details = details
        super.init()
        
        coordinate = CLLocationCoordinate2D(latitude: details.latitude, longitude: details.longitude)
        title = "Selected location"
        
        // TODO: clean...
//        let latString = String(format: "%.3f", location.coordinate.latitude)
//        let lonString = String(format: "%.3f", location.coordinate.longitude)
        
        subtitle = details.longCoordinateToString()
    }
}

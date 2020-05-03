//
//  RecordAnnotation.swift
//  LocationWeather
//
//  Created by Vivatum on 30/04/2020.
//  Copyright © 2020 com.vivatum. All rights reserved.
//

import MapKit

final class RecordAnnotation: MKPointAnnotation {

    private var details: RecordDetails
    
    init(details: RecordDetails) {
        self.details = details
        super.init()
        coordinate = CLLocationCoordinate2D(latitude: self.details.latitude, longitude: self.details.longitude)
        title = self.details.dataString
        subtitle = self.details.weatherDescription()
    }
}

//
//  URLFactory.swift
//  LocationWeather
//
//  Created by Vivatum on 29/04/2020.
//  Copyright © 2020 com.vivatum. All rights reserved.
//

import Foundation

final class URLFactory {
    
    enum URLComponent: String {
        case baseURL = "http://api.openweathermap.org/data/2.5/weather?"
        case lat = "lat="
        case and = "&"
        case lon = "lon="
        case appid = "appid="
        case apiKey = "f3cccde3a0c525eb4f919d7303a75bdb"
    }
    
    
    static func requestURL(_ lat: Double, _ lon: Double) -> URL? {
        
        let variableString: String = URLComponent.lat.rawValue +
            String(describing: lat) +
            URLComponent.and.rawValue +
            URLComponent.lon.rawValue +
            String(describing: lon)
        
        let urlString = URLComponent.baseURL.rawValue +
            variableString +
            URLComponent.and.rawValue +
            URLComponent.appid.rawValue +
            URLComponent.apiKey.rawValue
        
        
        return URL(string: urlString)
    }
}

//
//  WeatherData.swift
//  LocationWeather
//
//  Created by Vivatum on 29/04/2020.
//  Copyright © 2020 com.vivatum. All rights reserved.
//

import Foundation

fileprivate struct RawResponse: Decodable {
    
    struct Temperature: Decodable {
        var temp: Double
        var temp_max: Double
    }

    struct Weather: Decodable {
        var description: String
    }

    var main: Temperature
    var weather: [Weather]
}

struct WeatherResponse: Decodable {
    
    let temperature: Double
    let temperatureMax: Double
    let description: String
    
    init(from decoder: Decoder) throws {
        let rawResponse = try RawResponse(from: decoder)
        temperature = rawResponse.main.temp
        temperatureMax = rawResponse.main.temp_max
        description = rawResponse.weather.first?.description ?? "NO_WEATHER_DESCRIPTION"
    }
}

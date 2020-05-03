//
//  WeatherRequestHandler.swift
//  LocationWeather
//
//  Created by Vivatum on 29/04/2020.
//  Copyright © 2020 com.vivatum. All rights reserved.
//

import Foundation
import CocoaLumberjack

class WeatherRequestHandler {
    
    func parseWeatherData(_ weatherData: Data, completion: @escaping (Result<WeatherResponse, ActionError>) -> Void) {
        
        let decoder = JSONDecoder()
        DispatchQueue.global(qos: .background).async(execute: {
            do {
                let weather = try decoder.decode(WeatherResponse.self, from: weatherData)
                completion(.success(weather))
                DDLogInfo("Weather data parsed successfully")
            } catch {
                let errorMessage = "Can't parse Weather List: \(error.localizedDescription)"
                DDLogError(errorMessage)
                completion(.failure(.parser(errorMessage)))
            }
        })
    }
}

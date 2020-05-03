//
//  WeatherFetchService.swift
//  LocationWeather
//
//  Created by Vivatum on 29/04/2020.
//  Copyright © 2020 com.vivatum. All rights reserved.
//

import Foundation
import MapKit
import CocoaLumberjack

protocol WeatherFetchServiceProtocol: class {
    func fetchWeatherInfo(for location: CLLocation, _ completion: @escaping ((Result<WeatherResponse, ActionError>) -> Void))
}

final class WeatherFetchService: WeatherRequestHandler, WeatherFetchServiceProtocol {
    
    static let shared = WeatherFetchService()
    private override init() {}
    
    var task: URLSessionTask?
    
    func fetchWeatherInfo(for location: CLLocation, _ completion: @escaping ((Result<WeatherResponse, ActionError>) -> Void)) {
        
        guard let url = URLFactory.requestURL(location.coordinate.latitude, location.coordinate.longitude) else {
            completion(.failure(.network("Wrong url format")))
            return
        }
                
        guard Network.isReachable else {
            let errorMessage = "Can't load Data: Network unreachable!"
            DDLogError(errorMessage)
            return completion(.failure(.network(errorMessage)))
        }
        
        self.cancelFetchWeather()
        
        task = RequestService().loadData(url: url) { result in
            switch result {
            case .success(let data):
                self.parseWeatherData(data, completion: completion)
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func cancelFetchWeather() {
        guard let currentTask = task else { return }
        currentTask.cancel()
        task = nil
    }
}

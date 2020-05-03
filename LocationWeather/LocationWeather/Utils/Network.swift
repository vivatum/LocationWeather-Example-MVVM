//
//  Network.swift
//  LocationWeather
//
//  Created by Vivatum on 29/04/2020.
//  Copyright © 2020 com.vivatum. All rights reserved.
//

import Foundation
import Alamofire

struct Network {
    static var isReachable: Bool {
        guard let manager = NetworkReachabilityManager() else { return false }
        return manager.isReachable
    }
}

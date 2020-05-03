//
//  AppNotification.swift
//  LocationWeather
//
//  Created by Vivatum on 29/04/2020.
//  Copyright © 2020 com.vivatum. All rights reserved.
//

import Foundation

struct AppNotification {
    
    static func send(notification: AppNotificationKey, object: Any? = nil, userInfo: [AnyHashable: Any]? = nil) {
        DispatchQueue.main.async {
            NotificationCenter.default.post(name: Notification.Name(rawValue: notification.rawValue), object: object, userInfo: userInfo)
        }
    }
}

enum AppNotificationKey: String {
    case UserLocationUpdated = "UserLocationUpdatedNotification"
}

enum NotificationUserInfoKey: String {
    case location = "locationInfo"
}

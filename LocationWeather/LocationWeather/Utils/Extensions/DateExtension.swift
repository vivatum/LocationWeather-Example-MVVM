//
//  DateExtension.swift
//  LocationWeather
//
//  Created by Vivatum on 30/04/2020.
//  Copyright © 2020 com.vivatum. All rights reserved.
//

import Foundation

enum FormatForStringDate: String {
    
    case longDate = "HH:mm | E MMM dd yyyy"
    case shortDateTime = "HH:mm"
    case timeAndDay = "HH:mm MMM dd"
    case dayAndTime = "MMM dd HH:mm"
    case longDateAndTime = "dd MMM yyyy HH:mm:ss"
    case simplyDate = "dd.MM.yyyy"
    case simplyReverseDate = "yyyy.MM.dd"
}

extension Date {
    
    func toString(format: FormatForStringDate) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone.current
        dateFormatter.locale = NSLocale.current
        dateFormatter.dateFormat = format.rawValue
        return dateFormatter.string(from: self)
    }
}

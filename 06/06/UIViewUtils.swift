//
//  UIViewUtils.swift
//  06
//
//  Created by Vadym on 811//16.
//  Copyright © 2016 Vadym Mitin. All rights reserved.
//

import UIKit

class UIViewUtils{
    
    static func weatherImage(weather: Weather) -> UIImage?{
        switch weather {
        case .sun:
            return UIImage(named: "weather_sun")
        case .cloud:
            return UIImage(named: "weather_cloud")
        case .rain:
            return UIImage(named: "weather_rain")
        case .storm:
            return UIImage(named: "weather_storm")
        case .snow:
            return UIImage(named: "weather_snow")
        }
    }
    
    static func shortDateString(date: Date) -> String{
        let dateFormater = DateFormatter()
        dateFormater.dateStyle = .short
        dateFormater.timeStyle = .none
        
        return dateFormater.string(from: date)
    }
    
    static func weatherColor(weather: Weather) -> UIColor{
        switch weather {
        case .sun:
            return UIColor.orange
        case .cloud:
            return UIColor.lightGray
        case .rain:
            return UIColor.darkGray
        case .storm:
            return UIColor.black
        case .snow:
            return UIColor.blue
        }
    }
}

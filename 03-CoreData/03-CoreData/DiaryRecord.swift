//
//  DiaryRecord.swift
//  02-Storyboards
//
//  Created by Vadym on 1910//16.
//  Copyright © 2016 Vadym Mitin. All rights reserved.
//

import Foundation

enum Weather: Int{
    case sun = 0
    case cloud = 1
    case rain = 2
    case storm = 3
    case snow = 4
}

class DiaryRecord{
    
    let dateCreated: Date
    var titleText: String?
    var descriptionText: String?
    var weather: Weather?
    
    init(dateCreated: Date? = nil, titleText: String? = nil, descriptionText: String? = nil, weather: Weather? = nil) {
        if let dateCreated = dateCreated{
            self.dateCreated = dateCreated
        }
        else{
            self.dateCreated = Date()
        }
        
        self.titleText = titleText
        self.descriptionText = descriptionText
        self.weather = weather
    }
    
    func getTitle() -> String{
        return titleText ?? ""
    }
    
    func getDescription() -> String{
        return descriptionText ?? ""
    }
    
    func getDateCreated() -> String{
        return getDateCreatedString()
    }
    
    func fullDescription() -> String{
        var result: String = ""
        
        result += getDateCreatedString()
        result += getString(fromOptionalStringProperty: titleText)
        result += getString(fromOptionalStringProperty: descriptionText)
        
        return result
    }
    
    /* Utility methods */
    
    private func getDateCreatedString() -> String{
        let calendar = Calendar.current
        let dateFormater = DateFormatter()
        
        dateFormater.timeStyle = (Settings.instance.dateFormat == .dateAndTime) ? .short : .none
        
        if calendar.isDateInToday(dateCreated){
            dateFormater.dateStyle = .none
            dateFormater.timeStyle = .short
        }
        else if calendar.isDateInYesterday(dateCreated){
            dateFormater.dateStyle = .medium
            dateFormater.doesRelativeDateFormatting = true
        }
        else{
            let dateWeekAgo = Date(timeIntervalSinceNow: -(3600 * 24 * 7))
            
            if dateCreated > calendar.startOfDay(for: dateWeekAgo) {
                let weekday = calendar.component(.weekday, from: dateCreated)
                
                return dateFormater.weekdaySymbols[weekday - 1] + " " + dateFormater.string(from: dateCreated)
            }
            else{
                dateFormater.dateStyle = .medium
            }
        }
        
        return dateFormater.string(from: dateCreated)
    }
    
    private func getString(fromOptionalStringProperty stringProperty: String?) -> String{
        if let stringProperty = stringProperty{
            return stringProperty
        }
        
        return ""
    }
}

extension DiaryRecord: CustomStringConvertible{
    var description: String{
        return fullDescription()
    }
}

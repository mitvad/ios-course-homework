//
//  DiaryRecord+CoreDataClass.swift
//  03-CoreData
//
//  Created by Vadym on 2610//16.
//  Copyright © 2016 Vadym Mitin. All rights reserved.
//

import Foundation
import CoreData


public class DiaryRecord: NSManagedObject {
    
    enum Section: String{
        case today = "g1"
        case thisWeek = "g2"
        case thisMonth = "g3"
        case earlier = "Earlier"
        
        func title() -> String{
            switch self {
            case .today:
                return "Today"
            case .thisWeek:
                return "This Week"
            case .thisMonth:
                return "This Month"
            default:
                return "Earlier"
            }
        }
    }
    
    fileprivate func section() -> Section{
        let calendar = Calendar.current
        let dateCreated = self.dateCreated as! Date
        
        if calendar.isDateInToday(dateCreated){
            return Section.today
        }
        else{
            let dateNow = Date()
            
            let currentWeekDay = calendar.component(.weekday, from: dateNow) - 1
            let firstWeekDay = Date(timeIntervalSinceNow: -Double(currentWeekDay * 24 * 3600))
            if dateCreated >= calendar.startOfDay(for: firstWeekDay){
                return Section.thisWeek
            }
            else{
                let currentMonthDay = calendar.component(.day, from: dateNow) - 1
                let firstMonthDay = Date(timeIntervalSinceNow: -Double(currentMonthDay * 24 * 3600))
                if dateCreated >= calendar.startOfDay(for: firstMonthDay){
                    return Section.thisMonth
                }
            }
        }
        
        return Section.earlier
    }
    
    var sectionId: String{
        return self.section().rawValue
    }
    
    var sectionTitle: String{
        return self.section().title()
    }
    
    convenience init(){
        self.init(entity: CoreDataManager.instance.entityForName(entityName: "DiaryRecord"), insertInto: CoreDataManager.instance.managedObjectContext)
        
        self.dateCreated = NSDate()
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
    
    func getWeatherIndex() -> Int{
        return Int(weather)
    }
    
    /* Utility methods */
    
    private func getDateCreatedString() -> String{
        let calendar = Calendar.current
        let dateFormater = DateFormatter()
        let dateCreated = self.dateCreated as! Date
        
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

}

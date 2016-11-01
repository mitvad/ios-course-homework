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
    
    var section: String{
        let calendar = Calendar.current
        let dateCreated = self.dateCreated as! Date
        
        if calendar.isDateInToday(dateCreated){
            return "g1"
        }
        else{
            let dateNow = Date()

            let currentWeekDay = calendar.component(.weekday, from: dateNow) - 1
            let firstWeekDay = Date(timeIntervalSinceNow: -Double(currentWeekDay * 24 * 3600))
            if dateCreated >= calendar.startOfDay(for: firstWeekDay){
                return "g2"
            }
            else{
                let currentMonthDay = calendar.component(.day, from: dateNow) - 1
                let firstMonthDay = Date(timeIntervalSinceNow: -Double(currentMonthDay * 24 * 3600))
                if dateCreated >= calendar.startOfDay(for: firstMonthDay){
                    return "g3"
                }
            }
        }

        
        return "g4"
    }
    
    var sectionTitle: String{
        switch self.section {
        case "g1":
            return "Today"
        case "g2":
            return "This Week"
        case "g3":
            return "This Month"
        default:
            return "Earlier"
        }
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

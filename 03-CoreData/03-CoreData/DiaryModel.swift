//
//  DiaryModel.swift
//  02-Storyboards
//
//  Created by Vadym on 1910//16.
//  Copyright © 2016 Vadym Mitin. All rights reserved.
//

import Foundation

class DiaryModel{
    
    var records: Array<DiaryRecord>!
    
    var recordsCount: Int {
        return records.count
    }
    
    init() {
        fillDefaultRecords()
    }
    
    func getRecord(at index: Int) -> DiaryRecord?{
        if records.count >= index{
            return records[index]
        }
        
        return nil
    }
    
    func newRecord() -> DiaryRecord{
        let newRecord = DiaryRecord()
        
        records.insert(newRecord, at: 0)
        
        return newRecord
    }
    
    func removeRecord(at index: Int) -> DiaryRecord?{
        if records.count >= index{
            return records.remove(at: index)
        }
        
        return nil
    }
    
    private func fillDefaultRecords(){
        let timeIntervalDay: TimeInterval = 3600 * 24
        let timeIntervalTwoDays: TimeInterval = timeIntervalDay * 2
        let timeIntervalThreeDays: TimeInterval = timeIntervalDay * 3
        let timeIntervalWeek: TimeInterval = timeIntervalDay * 7
        let timeIntervalTwoWeeks: TimeInterval = timeIntervalWeek * 2
        
        let dateNow = Date()
        let dateYesterday = Date(timeIntervalSinceNow: -timeIntervalDay)
        let dateTwoDaysAgo = Date(timeIntervalSinceNow: -timeIntervalTwoDays)
        let dateThreeDaysAgo = Date(timeIntervalSinceNow: -timeIntervalThreeDays)
        let dateWeekAgo = Date(timeIntervalSinceNow: -timeIntervalWeek)
        let dateTwoWeeksAgo = Date(timeIntervalSinceNow: -timeIntervalTwoWeeks)
        
        let diaryRecord1 = DiaryRecord(dateCreated: dateNow, weather: Weather.sun)
        let diaryRecord2 = DiaryRecord(dateCreated: dateTwoWeeksAgo, titleText: "Record 2", weather: Weather.cloud)
        let diaryRecord3 = DiaryRecord(dateCreated: dateWeekAgo, titleText: "Some description text", weather: Weather.rain)
        let diaryRecord4 = DiaryRecord(dateCreated: dateTwoDaysAgo, titleText: "Rcord 4", descriptionText: "And description", weather: Weather.storm)
        let diaryRecord5 = DiaryRecord(dateCreated: dateYesterday, weather: Weather.snow)
        let diaryRecord6 = DiaryRecord(dateCreated: dateThreeDaysAgo, titleText: "Rcord 6", descriptionText: "Description", weather: Weather.sun)
        
        records = [diaryRecord1, diaryRecord2, diaryRecord3, diaryRecord4, diaryRecord5, diaryRecord6]
        records.sort{$0.dateCreated > $1.dateCreated}
    }
}

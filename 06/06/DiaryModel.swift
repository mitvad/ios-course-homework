//
//  DiaryModel.swift
//  05
//
//  Created by Vadym on 611//16.
//  Copyright © 2016 Vadym Mitin. All rights reserved.
//

import Foundation
import CoreData

class DiaryModel{
    
    static let instance: DiaryModel = DiaryModel()
    
    var diaryFetchResultController: NSFetchedResultsController<DiaryRecord>
    
    var diaryRecordToEdit: DiaryRecord?{
        didSet{
            if diaryRecordToEdit != nil{
                NotificationCenter.default.post(Notification(name: NSNotification.Name.DiaryModelEditRecord))
            }
        }
    }
    
    var weatherSelectedFilter: Weather?{
        didSet{
            if weatherSelectedFilter != oldValue{
                if let weatherSelectedFilter = weatherSelectedFilter{
                    diaryFetchResultController.fetchRequest.predicate = NSPredicate(format: "weather == \(Int16(weatherSelectedFilter.rawValue))")
                }
                else{
                    weatherLastSelectedFilter = oldValue
                    
                    diaryFetchResultController.fetchRequest.predicate = nil
                }
                
                fetchData()
                
                NotificationCenter.default.post(Notification(name: NSNotification.Name.DiaryModelFetchResultChanged))
            }
            
        }
    }
    
    var weatherLastSelectedFilter: Weather?
    
    private init() {
        diaryFetchResultController = CoreDataManager.instance.fetchedResultsController(entityName: "DiaryRecord", keyForSort: "dateCreated", sectionNameKeyPath: "sectionId")
        
        fetchData()
    }
    
    private func fetchData(){
        do {
            try diaryFetchResultController.performFetch()
        }
        catch {
            print(error)
        }
        
    }


}

extension NSNotification.Name{
    static let DiaryModelEditRecord: NSNotification.Name = NSNotification.Name.init(rawValue: "DiaryModelEditRecord")
    static let DiaryModelFetchResultChanged: NSNotification.Name = NSNotification.Name.init(rawValue: "DiaryModelFetchResultChanged")
}

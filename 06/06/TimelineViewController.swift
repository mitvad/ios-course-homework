//
//  TimelineViewController.swift
//  06
//
//  Created by Vadym on 711//16.
//  Copyright © 2016 Vadym Mitin. All rights reserved.
//

import UIKit
import CoreData

class TimelineViewController: UIViewController{
    
    var recordsView: DiaryRecordsUIView!
    
    override func viewDidLoad() {
        recordsView = DiaryRecordsUIView(frame: CGRect(x: 0, y: 20, width: view.frame.width, height: view.frame.height))
        view.addSubview(recordsView)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        recordsView.clearRecords()
        
        if let fetchedObjects = DiaryModel.instance.diaryFetchResultController.fetchedObjects{
            for diaryRecord in fetchedObjects{
                let recordView = DiaryRecordUIView(diaryRecord: diaryRecord, showDate: true)
                recordsView.addDiaryRecord(view: recordView)
            }

        }
    }
}

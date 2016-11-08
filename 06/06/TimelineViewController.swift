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
    
    var myView: DiaryRecordUIView!
    
    override func viewDidLoad() {
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if myView != nil{
            myView.removeFromSuperview()
        }
        
        if let fetchedObjects = DiaryModel.instance.diaryFetchResultController.fetchedObjects{
            if !fetchedObjects.isEmpty{
                let diaryRecord = fetchedObjects[0]
                myView = DiaryRecordUIView(diaryRecord: diaryRecord, showDate: true)
            }
            else{
                myView = DiaryRecordUIView()
            }
        }
        else{
            myView = DiaryRecordUIView(frame: CGRect(x: 10, y: 250, width: 100, height: 40))
        }
        
        view.addSubview(myView)

    }
}

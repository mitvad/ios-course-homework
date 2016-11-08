//
//  DiaryViewController.swift
//  05
//
//  Created by Vadym on 311//16.
//  Copyright © 2016 Vadym Mitin. All rights reserved.
//

import UIKit

class DiaryViewController: UIViewController{
    
    @IBAction func addDiaryRecord(){
        let newDiaryRecord = DiaryRecord()
        newDiaryRecord.dateCreated = NSDate()
        
        DiaryModel.instance.diaryRecordToEdit = newDiaryRecord
    }
    
    override func viewDidAppear(_ animated: Bool) {
        DiaryModel.instance.weatherSelectedFilter = nil
    }
    
    override func viewDidLoad() {
        NotificationCenter.default.addObserver(forName: Notification.Name.DiaryModelEditRecord, object: nil, queue: nil, using: {(notification) in self.showEditView()})
    }
    
    func showEditView(){
        performSegue(withIdentifier: "EditDiaryRecordSegue", sender: self)
    }

}

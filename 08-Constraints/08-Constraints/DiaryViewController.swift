//
//  DiaryViewController.swift
//  05
//
//  Created by Vadym on 311//16.
//  Copyright © 2016 Vadym Mitin. All rights reserved.
//

import UIKit

class DiaryViewController: UIViewController{
    
    private var observer: Any!
    
    @IBAction func addDiaryRecord(){
        let newDiaryRecord = DiaryRecord()
        newDiaryRecord.dateCreated = NSDate()
        
        DiaryModel.instance.diaryRecordToEdit = newDiaryRecord
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        NotificationCenter.default.removeObserver(observer)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        observer = NotificationCenter.default.addObserver(forName: Notification.Name.DiaryModelEditRecord, object: nil, queue: nil, using: {(notification) in self.showEditView()})
        
        DiaryModel.instance.weatherSelectedFilter = nil
    }
    
    func showEditView(){
        performSegue(withIdentifier: "EditDiaryRecordSegue", sender: self)
    }

}

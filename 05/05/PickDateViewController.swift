//
//  PickDateViewController.swift
//  04
//
//  Created by Vadym on 3110//16.
//  Copyright © 2016 Vadym Mitin. All rights reserved.
//

import UIKit

class PickDateViewController: UIViewController{
    
    @IBOutlet weak var cancelButton: UIBarButtonItem!
    @IBOutlet weak var doneButton: UIBarButtonItem!
    @IBOutlet weak var datePicker: UIDatePicker!
    
    var diaryRecord: DiaryRecord!
    
    override func viewDidLoad() {
        datePicker.date = diaryRecord.dateCreated as! Date
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let sender = sender{
            if sender as? UIBarButtonItem === doneButton{
                diaryRecord.dateCreated = datePicker.date as NSDate?
                
                CoreDataManager.instance.saveContext()
            }
        }
    }
}

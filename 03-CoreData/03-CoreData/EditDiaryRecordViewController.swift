//
//  EditDiaryRecordViewController.swift
//  02-Storyboards
//
//  Created by Vadym on 2410//16.
//  Copyright © 2016 Vadym Mitin. All rights reserved.
//

import UIKit

class EditDiaryRecordViewController: UIViewController {
    
    @IBOutlet weak var weather: UISegmentedControl!
    @IBOutlet weak var titleText: UITextField!
    @IBOutlet weak var descriptionText: UITextView!
    
    var diaryRecord: DiaryRecord!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        titleText.text = diaryRecord.getTitle()
        descriptionText.text = diaryRecord.getDescription()
        weather.selectedSegmentIndex = diaryRecord.getWeatherIndex()
        
        self.title = diaryRecord.getDateCreated()
        
        NotificationCenter.default.addObserver(forName: Notification.Name.UIApplicationWillTerminate, object: self, queue: nil, using: {(notification) in self.save()})
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        save()
        
        NotificationCenter.default.removeObserver(self)
    }
    
    func save() {
        diaryRecord.titleText = titleText.text
        diaryRecord.descriptionText = descriptionText.text
        diaryRecord.weather = Int16(weather.selectedSegmentIndex)
        CoreDataManager.instance.saveContext()
    }

}

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
        
        if let weatherIndex = diaryRecord.weather?.rawValue{
            weather.selectedSegmentIndex = weatherIndex
        }
        
        self.title = diaryRecord.getDateCreated()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        diaryRecord.titleText = titleText.text
        diaryRecord.descriptionText = descriptionText.text
        diaryRecord.weather = Weather(rawValue: weather.selectedSegmentIndex)
    }

}

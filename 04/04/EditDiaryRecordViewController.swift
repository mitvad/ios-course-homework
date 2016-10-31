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
    
    @IBAction func unwindToEditDiaryRecord(sender: UIStoryboardSegue){
        self.title = diaryRecord.getDateCreated()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        titleText.text = diaryRecord.getTitle()
        descriptionText.text = diaryRecord.getDescription()
        weather.selectedSegmentIndex = diaryRecord.getWeatherIndex()
        
        self.title = diaryRecord.getDateCreated()
        
        titleText.delegate = self
        descriptionText.delegate = self
        
        NotificationCenter.default.addObserver(forName: Notification.Name.UIApplicationWillTerminate, object: self, queue: nil, using: {(notification) in self.save()})
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        save()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "PickDateSegue"{
            if let pickDateViewController = segue.destination as? PickDateViewController{
                pickDateViewController.diaryRecord = diaryRecord
            }
        }
    }
    
    func save() {
        diaryRecord.titleText = titleText.text
        diaryRecord.descriptionText = descriptionText.text
        diaryRecord.weather = Int16(weather.selectedSegmentIndex)
        CoreDataManager.instance.saveContext()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }

}

extension EditDiaryRecordViewController: UITextFieldDelegate{
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        descriptionText.becomeFirstResponder()
        
        return true
    }
}

extension EditDiaryRecordViewController: UITextViewDelegate{
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if text == "\n"{
            descriptionText.resignFirstResponder()
        }
        
        return true
    }
}

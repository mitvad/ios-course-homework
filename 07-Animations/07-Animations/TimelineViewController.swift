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
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    
    private var diaryViews: [DiaryRecordUIView] = []
    
    @IBAction func changeView(_ sender: UISegmentedControl) {
         showView()
    }
    
    @IBAction func addNewDiaryRecord(_ sender: UIBarButtonItem) {
        let newDiaryRecord = DiaryRecord()
        newDiaryRecord.dateCreated = NSDate()
        
        CoreDataManager.instance.saveContext()
        
        let recordView = DiaryRecordUIView(
            date: UIViewUtils.shortDateString(date: newDiaryRecord.dateCreated),
            weatherImage: UIViewUtils.weatherImage(weather: newDiaryRecord.weather),
            title: newDiaryRecord.titleText,
            tint: UIViewUtils.weatherColor(weather: newDiaryRecord.weather))
        
        recordView.frame = CGRect(x: 0, y: -100, width: Int(scrollView.frame.width), height: 60)
        scrollView.addSubview(recordView)
        
        diaryViews.insert(recordView, at: 0)
        
        animateNewRecord(recordView)
    }

    override func viewDidAppear(_ animated: Bool) {
        DiaryModel.instance.weatherSelectedFilter = nil
        
        showView()
    }
    
    private func showView(){
        if segmentedControl.selectedSegmentIndex == 0{
            showEventsView()
        }
        else{
            showTimelineView()
        }
    }
    
    private func showEventsView(){
        clearRecords()
        
        if let fetchedObjects = DiaryModel.instance.diaryFetchResultController.fetchedObjects{
            for diaryRecord in fetchedObjects{
                addRecord(date: UIViewUtils.shortDateString(date: diaryRecord.dateCreated),
                          weatherImage: UIViewUtils.weatherImage(weather: diaryRecord.weather),
                          title: diaryRecord.titleText,
                          tint: UIViewUtils.weatherColor(weather: diaryRecord.weather))
            }
            
            setScrollContentSize()
        }
    }
    
    private func showTimelineView(){
        clearRecords()
        
        if let fetchedObjects = DiaryModel.instance.diaryFetchResultController.fetchedObjects{
            
            var previouseDiaryRecord: DiaryRecord?
            
            for diaryRecord in fetchedObjects{
                var dateString: String? = UIViewUtils.shortDateString(date: diaryRecord.dateCreated)
                
                if let previouseDiaryRecord = previouseDiaryRecord{
                    let date1 = Calendar.current.startOfDay(for: previouseDiaryRecord.dateCreated as! Date)
                    let date2 = Calendar.current.startOfDay(for: diaryRecord.dateCreated as! Date)
                    
                    if date1 == date2{
                        dateString = nil
                    }
                    else{
                        let daysInBetween = abs(Int(date1.timeIntervalSince(date2) / 86400)) - 1
                        
                        if daysInBetween == 1{
                            let dateToInsert = Date(timeInterval: 86400, since: date2)
                            addRecord(date: UIViewUtils.shortDateString(date: dateToInsert as NSDate?))
                        }
                        else if daysInBetween > 1{
                            addRecord(date: "...")
                        }
                    }
                    
                }
                
                addRecord(date: dateString,
                          weatherImage: UIViewUtils.weatherImage(weather: diaryRecord.weather),
                          title: diaryRecord.titleText,
                          tint: UIViewUtils.weatherColor(weather: diaryRecord.weather))
                
                previouseDiaryRecord = diaryRecord
            }
            
            setScrollContentSize()
        }
    }
    
    private func addRecord(date: String? = nil, weatherImage: UIImage? = nil, title: String? = nil, tint: UIColor? = nil){
        let recordView = DiaryRecordUIView(
            date: date,
            weatherImage: weatherImage,
            title: title,
            tint: tint)
        
        recordView.frame = CGRect(x: 0, y: diaryViews.count * 60, width: Int(scrollView.frame.width), height: 60)
        scrollView.addSubview(recordView)
        
        diaryViews.append(recordView)
        
        if recordView.frame.origin.y < scrollView.bounds.height{
            recordView.alpha = 0
            
            UIView.animate(withDuration: (diaryViews.count <= 5) ? 0.3 - Double(diaryViews.count) * 0.04 : 0.0,
                           delay: Double(diaryViews.count) * 0.05,
                           options: [.beginFromCurrentState, .transitionCurlUp],
                           animations: {
                            recordView.alpha = 1
            },
                           completion: nil)
        }
    }
    
    func clearRecords(){
        for view in diaryViews{
            view.removeFromSuperview()
        }
        
        diaryViews = []
    }
    
    func setScrollContentSize(){
        scrollView.contentOffset = CGPoint(x: 0, y: 0)
        scrollView.contentSize = CGSize(width: scrollView.frame.width, height: CGFloat(diaryViews.count * 60 + 60))
    }
    
    func animateNewRecord(_ recordView: DiaryRecordUIView){
        func showNewRecord(finished: Bool){
            UIView.animate(withDuration: 1,
                           delay: 0,
                           usingSpringWithDamping: 0.3,
                           initialSpringVelocity: 0.3,
                           options: [.beginFromCurrentState],
                           animations: {
                            recordView.frame = CGRect(x: 0, y: 0, width: Int(self.scrollView.frame.width), height: 60)},
                           completion: nil)
        }
        
        func moveAllRecordsDown(finished: Bool){
            UIView.animate(withDuration: 0.3,
                           delay: 0,
                           options: [.beginFromCurrentState, .transitionCurlUp],
                           animations: {
                            for index in 1..<self.diaryViews.count{
                                self.diaryViews[index].frame = CGRect(x: 0, y: index * 60, width: Int(self.scrollView.frame.width), height: 60)
                            }},
                           completion: showNewRecord)
        }
        
        UIView.animate(withDuration: (scrollView.contentOffset.y > 0) ? 0.2 : 0,
                       delay: 0,
                       options: [.beginFromCurrentState, .transitionCurlUp],
                       animations: setScrollContentSize,
                       completion: moveAllRecordsDown)
    }
}

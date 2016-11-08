//
//  WeatherViewController.swift
//  05
//
//  Created by Vadym on 611//16.
//  Copyright © 2016 Vadym Mitin. All rights reserved.
//

import UIKit

class WeatherViewController: UIViewController{
    
    @IBAction func weatherFilterChange(_ sender: UISegmentedControl) {
        
        DiaryModel.instance.weatherSelectedFilter = Weather(rawValue: sender.selectedSegmentIndex + 1)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        DiaryModel.instance.weatherSelectedFilter = DiaryModel.instance.weatherLastSelectedFilter
    }
    
    override func viewDidLoad() {
        NotificationCenter.default.addObserver(forName: Notification.Name.DiaryModelEditRecord, object: nil, queue: nil, using: {(notification) in self.showEditView()})
        
        DiaryModel.instance.weatherLastSelectedFilter = Weather.sun
    }
    
    func showEditView(){
        performSegue(withIdentifier: "EditDiaryRecordSegue", sender: self)
    }
}

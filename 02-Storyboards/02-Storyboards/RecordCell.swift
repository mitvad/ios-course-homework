//
//  DiaryRecordCell.swift
//  02-Storyboards
//
//  Created by Vadym on 1910//16.
//  Copyright © 2016 Vadym Mitin. All rights reserved.
//

import UIKit

class RecordCell: UITableViewCell{
    
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var date: UILabel!
    
    func setTitle(text: String){
        title.text = text
    }
    
    func setDate(text: String){
        date.text = text
    }
}

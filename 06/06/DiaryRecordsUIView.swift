//
//  DiaryRecordsUIView.swift
//  06
//
//  Created by Vadym on 811//16.
//  Copyright © 2016 Vadym Mitin. All rights reserved.
//

import UIKit

class DiaryRecordsUIView: UIView{
    
    private var views: [DiaryRecordUIView] = []
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    
    func addDiaryRecord(view: DiaryRecordUIView){
        view.frame = CGRect(x: 0, y: views.count * 60, width: Int(self.frame.width), height: 60)
        addSubview(view)
        
        views.append(view)
        
        if view.frame.origin.y < self.bounds.height{
            view.alpha = 0
            
            UIView.animate(withDuration: (views.count <= 5) ? 0.3 - Double(views.count) * 0.04 : 0.0,
                           delay: Double(views.count) * 0.05,
                           options: [.beginFromCurrentState, .transitionCurlUp],
                           animations: {
                                view.alpha = 1
                           },
                           completion: nil)
        }
    }
    
    func clearRecords(){
        for view in views{
            view.removeFromSuperview()
        }
        
        views = []
    }
}

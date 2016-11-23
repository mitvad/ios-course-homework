//
//  DiaryRecordUIView.swift
//  06
//
//  Created by Vadym on 711//16.
//  Copyright © 2016 Vadym Mitin. All rights reserved.
//

import UIKit

@IBDesignable
class DiaryRecordUIView: UIView{
    
    @IBOutlet weak var dateView: UIViewWithRoundedCorners!
    @IBOutlet weak var dateLabel: UILabel!
    
    @IBOutlet weak var weatherView: UIViewWithRoundedCorners!
    @IBOutlet weak var weatherImageView: UIImageView!
    
    @IBOutlet weak var titleView: UIViewWithRoundedCorners!
    @IBOutlet weak var titleLabel: UILabel!

    @IBOutlet weak var horizontalLine: UIView!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        loadNibNamed(for: DiaryRecordUIView.self)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        loadNibNamed(for: DiaryRecordUIView.self)
    }
    
    func fixLineConstraints(){
        var trailing: NSLayoutConstraint
        
        if !titleView.isHidden{
            trailing = NSLayoutConstraint(item: horizontalLine,
                                          attribute: .trailing,
                                          relatedBy: .equal,
                                          toItem: titleView,
                                          attribute: .leading,
                                          multiplier: 1,
                                          constant: 0)

        }
        else if !weatherView.isHidden{
            trailing = NSLayoutConstraint(item: horizontalLine,
                                          attribute: .trailing,
                                          relatedBy: .equal,
                                          toItem: weatherView,
                                          attribute: .leading,
                                          multiplier: 1,
                                          constant: 0)
        }
        else{
            trailing = NSLayoutConstraint(item: horizontalLine,
                                          attribute: .width,
                                          relatedBy: .equal,
                                          toItem: nil,
                                          attribute: .notAnAttribute,
                                          multiplier: 1,
                                          constant: 0)
        }
        
        addConstraint(trailing)
    }
    
//    func drawLines(){
//        var offsetX: CGFloat
//        
//        if !titleView.isHidden{
//            offsetX = titleView.frame.origin.x
//        }
//        else if !weatherView.isHidden{
//            offsetX = weatherView.frame.origin.x
//        }
//        else if !dateView.isHidden{
//            offsetX = dateView.frame.origin.x
//        }
//        else{
//            offsetX = dateView.frame.width / 2
//        }
//        
//        let linesView = UIView(frame: CGRect(
//            x: 0,
//            y: 0,
//            width: offsetX,
//            height: contentOffsetY + 60 / 2))
//        
//        let linePath = UIBezierPath()
//        linePath.move(to: CGPoint(
//            x: contentOffsetX + dateView.frame.width / 2,
//            y: 0))
//        linePath.addLine(to: CGPoint(
//            x: contentOffsetX + dateView.frame.width / 2,
//            y: contentOffsetY + blockHeight))
//        linePath.move(to: CGPoint(
//            x: contentOffsetX + dateView.frame.width / 2,
//            y: contentOffsetY + blockHeight / 2))
//        linePath.addLine(to: CGPoint(
//            x: offsetX,
//            y: contentOffsetY + blockHeight / 2))
//        
//        let shapeLayer = CAShapeLayer()
//        shapeLayer.path = linePath.cgPath
//        shapeLayer.strokeColor = UIColor.gray.cgColor
//        shapeLayer.fillColor = UIColor.clear.cgColor
//        shapeLayer.lineWidth = borderWidth
//        
//        linesView.layer.addSublayer(shapeLayer)
//        
//        insertSubview(linesView, at: 0)
//    }
}

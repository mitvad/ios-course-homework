//
//  DiaryRecordUIView.swift
//  06
//
//  Created by Vadym on 711//16.
//  Copyright © 2016 Vadym Mitin. All rights reserved.
//

import UIKit

class DiaryRecordUIView: UIView{
    
    private let spaceBetweenBlocks: CGFloat = 20
    private let blockHeight: CGFloat = 40
    private let contentOffsetY: CGFloat = 20
    private let contentOffsetX: CGFloat = 20
    private let textOffsetX: CGFloat = 7
    private let imageOffset: CGFloat = 7
    private let borderWidth: CGFloat = 2
    private let recordBackgroundColor: UIColor = UIColor.white
    
    private var recordTintColor: UIColor = UIColor.blue
    
    private var dateView: UIView!
    private var weatherView: UIView!
    private var titleView: UIView!
    private var linesView: UIView!
    
    private var date: Date?
    private var diaryRecord: DiaryRecord?
    
    private var showDate: Bool = true
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    
    convenience init(){
        self.init(frame: CGRect.zero)
        
        drawContent()
    }
    
    convenience init(date: Date){
        self.init(frame: CGRect.zero)
        
        self.date = date
        
        drawContent()
    }
    
    convenience init(diaryRecord: DiaryRecord, showDate: Bool = true){
        self.init(frame: CGRect.zero)
        
        self.diaryRecord = diaryRecord
        self.showDate = showDate
        
        recordTintColor = UIViewUtils.weatherColor(weather: diaryRecord.weather)
        
        drawContent()
    }
    
    private func drawContent(){
        drawDate()
        drawWeather()
        drawTitle()
        drawLines()
    }
    
    private func drawDate(){
        dateView = UIView(frame: CGRect(x: contentOffsetX, y: contentOffsetY, width: 70, height: blockHeight))
        
        dateView.backgroundColor = recordBackgroundColor
        
        dateView.layer.borderWidth = borderWidth
        dateView.layer.borderColor = recordTintColor.cgColor
        dateView.layer.cornerRadius = dateView.frame.height / 2
        
        let dateText = UILabel(frame: CGRect(x: textOffsetX, y: 0, width: dateView.bounds.width - textOffsetX * 2, height: dateView.bounds.height))
        
        if let dateCreated = diaryRecord?.dateCreated{
            dateText.text = UIViewUtils.shortDateString(date: dateCreated as Date)
        }
        else if let date = date
        {
            dateText.text = UIViewUtils.shortDateString(date: date as Date)
        }
        else{
            dateText.text = "???"
        }
        
        dateText.textColor = recordTintColor
        dateView.addSubview(dateText)
        
        let textBounds = dateText.textRect(forBounds: dateView.bounds, limitedToNumberOfLines: 1)
        
        dateView.frame = CGRect(x: contentOffsetX, y: contentOffsetY, width: textBounds.width + textOffsetX * 2, height: blockHeight)
        
        addSubview(dateView)
        
        if !showDate{
            dateView.isHidden = true
        }
    }
    
    private func drawWeather(){
        weatherView = UIView(frame: CGRect(x: dateView.frame.origin.x + dateView.frame.width + spaceBetweenBlocks, y: contentOffsetY, width: blockHeight, height: blockHeight))
        
        weatherView.backgroundColor = recordBackgroundColor
        
        weatherView.layer.borderWidth = borderWidth
        weatherView.layer.borderColor = recordTintColor.cgColor
        weatherView.layer.cornerRadius = weatherView.frame.height / 2
        
        if let diaryRecord = diaryRecord{
            let weatherImageView = UIImageView(frame: CGRect(x: imageOffset, y: imageOffset, width: blockHeight - imageOffset * 2, height: blockHeight - imageOffset * 2))
            weatherImageView.image = UIViewUtils.weatherImage(weather: diaryRecord.weather)?.withRenderingMode(.alwaysTemplate)
            weatherImageView.tintColor = recordTintColor
            weatherView.addSubview(weatherImageView)
        }
        
        
        addSubview(weatherView)
    }
    
    private func drawTitle(){
        titleView = UIView(frame: CGRect(x: weatherView.frame.origin.x + weatherView.frame.width + spaceBetweenBlocks, y: 0, width: 200, height: blockHeight))
        
        titleView.backgroundColor = recordBackgroundColor
        
        titleView.layer.borderWidth = borderWidth
        titleView.layer.borderColor = recordTintColor.cgColor
        titleView.layer.cornerRadius = titleView.frame.height / 2
        
        let titleText = UILabel(frame: CGRect(x: textOffsetX, y: 0, width: titleView.bounds.width - textOffsetX * 2, height: titleView.bounds.height))
        titleText.textAlignment = .left
        
        if let title = diaryRecord?.getTitle(){
            titleText.text = title
        }
        else{
            titleText.text = "  ...  "
        }
        
        titleText.textColor = recordTintColor
        titleView.addSubview(titleText)
        
        let textBounds = titleText.textRect(forBounds: titleView.bounds, limitedToNumberOfLines: 1)
        
        titleView.frame = CGRect(x: weatherView.frame.origin.x + weatherView.frame.width + spaceBetweenBlocks, y: contentOffsetY, width: textBounds.width + textOffsetX * 2, height: blockHeight)
        
        addSubview(titleView)
    }
    
    private func drawLines(){
        linesView = UIView(frame: CGRect(x: contentOffsetX + dateView.frame.width / 2, y: 0, width: titleView.frame.origin.x, height: contentOffsetY + blockHeight / 2))
        
        func lineShapeLayer(start: CGPoint, end: CGPoint) -> CAShapeLayer{
            let linePath = UIBezierPath()
            linePath.move(to: start)
            linePath.addLine(to: end)
            
            let shapeLayer = CAShapeLayer()
            shapeLayer.path = linePath.cgPath
            shapeLayer.strokeColor = UIColor.gray.cgColor
            shapeLayer.lineWidth = borderWidth
            
            return shapeLayer
        }
        
        linesView.layer.addSublayer(lineShapeLayer(start: CGPoint(x: 0, y: 0), end: CGPoint(x: 0, y: contentOffsetY + blockHeight / 2)))
        linesView.layer.addSublayer(lineShapeLayer(start: CGPoint(x: 0, y: contentOffsetY + blockHeight / 2), end: CGPoint(x: titleView.frame.origin.x, y: contentOffsetY + blockHeight / 2)))
        
        insertSubview(linesView, at: 0)
    }
    
}

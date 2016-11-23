//
//  UIViewWithRoundedCorners.swift
//  08-Constraints
//
//  Created by Vadym on 2211//16.
//  Copyright © 2016 Vadym Mitin. All rights reserved.
//

import UIKit

@IBDesignable
class UIViewWithRoundedCorners: UIView{
    
    @IBInspectable
    var cornerRadius: CGFloat{
        get{
            return layer.cornerRadius
        }
        set{
            layer.cornerRadius = newValue
        }
    }
    
    @IBInspectable
    var borderColor: UIColor{
        get{
            if let color = layer.borderColor{
                return UIColor.init(cgColor: color)
            }
            else{
                return UIColor.clear
            }
        }
        set{
            layer.borderColor = newValue.cgColor
        }
    }
    
    @IBInspectable
    var borderWidth: Double{
        get{
            return Double(layer.borderWidth)
        }
        set{
            layer.borderWidth = CGFloat(newValue)
        }
    }
}

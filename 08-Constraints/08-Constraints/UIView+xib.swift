//
//  UIView+xib.swift
//  08-Constraints
//
//  Created by Vadym on 2311//16.
//  Copyright © 2016 Vadym Mitin. All rights reserved.
//

import UIKit

extension UIView{
    
    @discardableResult
    func loadNibNamed(for selfClass: AnyClass) -> UIView?{
        translatesAutoresizingMaskIntoConstraints = false
        let bundle = Bundle(for: selfClass.self)
        
        guard let view = bundle.loadNibNamed(String(describing: type(of: self)), owner: self, options: nil)?[0] as? UIView else{
            return nil
        }
        
        self.addSubview(view)
        
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layoutAttachAll(to: self)
        
        return view
    }
    
    func layoutAttachAll(to view: UIView){
        let top = NSLayoutConstraint(item: self, attribute: .top, relatedBy: .equal, toItem: view, attribute: .top, multiplier: 1, constant: 0)
        let bottom = NSLayoutConstraint(item: self, attribute: .bottom, relatedBy: .equal, toItem: view, attribute: .bottom, multiplier: 1, constant: 0)
        let leading = NSLayoutConstraint(item: self, attribute: .leading, relatedBy: .equal, toItem: view, attribute: .leading, multiplier: 1, constant: 0)
        let trailing = NSLayoutConstraint(item: self, attribute: .trailing, relatedBy: .equal, toItem: view, attribute: .trailing, multiplier: 1, constant: 0)
        
        view.addConstraints([top, bottom, leading, trailing])
    }
}

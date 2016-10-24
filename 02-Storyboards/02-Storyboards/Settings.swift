//
//  Settings.swift
//  02-Storyboards
//
//  Created by Vadym on 2210//16.
//  Copyright © 2016 Vadym Mitin. All rights reserved.
//

import Foundation

class Settings{
    
    var dateFormat: SettingsDateFormat = .dateAndTime
    var naturalLanguageSupport: Bool = false
    
    func saveInUserDefaults() {
        // perform save in UserDefaults
    }
    
    private init(){}
    
    public static var instance : Settings {
        get { return singletoneInstance }
    }
    
    static let singletoneInstance : Settings = Settings()
}

enum SettingsDateFormat {
    
    case dateAndTime
    case dateOnly
}

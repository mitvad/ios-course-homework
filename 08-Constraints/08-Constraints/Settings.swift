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
        let jsonString = "{\"dateFormat\": \"\(dateFormat)\", \"naturalLanguageSupport\": \(naturalLanguageSupport)}"
        let jsonData = jsonString.data(using: .utf8, allowLossyConversion: true) ?? Data()
        
        UserDefaults.standard.set(jsonData, forKey: "SettingsData")
    }
    
    private init(){
        if let jsonData = UserDefaults.standard.data(forKey: "SettingsData"){
            do {
                let jsonObject = try JSONSerialization.jsonObject(with: jsonData, options: [])
                
                if let dictionary = jsonObject as? [String: Any]{
                    let dateFormatString = dictionary["dateFormat"] as? String ?? ""
                    let naturalLanguageSupportBool = dictionary["naturalLanguageSupport"] as? Bool ?? false
                    
                    dateFormat = SettingsDateFormat(rawValue: dateFormatString) ?? SettingsDateFormat.dateAndTime
                    naturalLanguageSupport = naturalLanguageSupportBool
                }
                
                
            } catch {
                // Do nothing, because all settings have initial value
            }
        }
    }
    
    public static var instance : Settings {
        get { return singletoneInstance }
    }
    
    static let singletoneInstance : Settings = Settings()
}

enum SettingsDateFormat: String {
    
    case dateAndTime
    case dateOnly
}

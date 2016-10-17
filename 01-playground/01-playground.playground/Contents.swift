import Foundation

class DiaryRecord{
    let dateCreated: Date
    var title: String?
    var text: String?
    var tags: Set<String>?
    
    init(dateCreated: Date? = nil, title: String? = nil, text: String? = nil, tags: Set<String>? = nil) {
        if let dateCreated = dateCreated{
            self.dateCreated = dateCreated
        }
        else{
            self.dateCreated = Date()
        }
        
        self.title = title
        self.text = text
        self.tags = tags
    }
    
    func fullDescription() -> String{
        var result: String = ""
        
        result += getDateCreatedString()
        result += getString(fromOptionalStringProperty: title)
        result += getTagsString()
        result += getString(fromOptionalStringProperty: text)
        
        return result
    }
    
    /* Utility methods */
    
    private func getDateCreatedString() -> String{
        let calendar = Calendar.current
        let dateFormater = DateFormatter()
        
        if calendar.isDateInToday(dateCreated){
            dateFormater.dateStyle = .none
            dateFormater.timeStyle = .short
        }
        else if calendar.isDateInYesterday(dateCreated){
            dateFormater.dateStyle = .medium
            dateFormater.timeStyle = .none
            dateFormater.doesRelativeDateFormatting = true
        }
        else{
            let dateWeekAgo = Date(timeIntervalSinceNow: -(3600 * 24 * 7))
            
            if dateCreated > calendar.startOfDay(for: dateWeekAgo) {
                let weekday = calendar.component(.weekday, from: dateCreated)
                
                return dateFormater.weekdaySymbols[weekday - 1] + "\n"
            }
            else{
                dateFormater.dateStyle = .medium
                dateFormater.timeStyle = .none
            }
        }
        
        return dateFormater.string(from: dateCreated) + "\n"
    }
    
    private func getTagsString() -> String{
        if let tags = tags{
            if tags.count > 0
            {
                var result = ""
                
                for tag in tags{
                    result += "[\(tag)] "
                }
                
                result += "\n"
                
                return result
            }
        }
        
        return ""
    }
    
    private func getString(fromOptionalStringProperty stringProperty: String?) -> String{
        if let stringProperty = stringProperty{
            return stringProperty + "\n"
        }
        
        return ""
    }
}

extension DiaryRecord: CustomStringConvertible{
    var description: String{
        return fullDescription()
    }
}

// Testing section

let timeIntervalDay: TimeInterval = 3600 * 24
let timeIntervalTwoDays: TimeInterval = timeIntervalDay * 2
let timeIntervalThreeDays: TimeInterval = timeIntervalDay * 3
let timeIntervalWeek: TimeInterval = timeIntervalDay * 7
let timeIntervalTwoWeeks: TimeInterval = timeIntervalWeek * 2

let dateNow = Date()
let dateYesterday = Date(timeIntervalSinceNow: -timeIntervalDay)
let dateTwoDaysAgo = Date(timeIntervalSinceNow: -timeIntervalTwoDays)
let dateThreeDaysAgo = Date(timeIntervalSinceNow: -timeIntervalThreeDays)
let dateWeekAgo = Date(timeIntervalSinceNow: -timeIntervalWeek)
let dateTwoWeeksAgo = Date(timeIntervalSinceNow: -timeIntervalTwoWeeks)

let diaryRecord1 = DiaryRecord(dateCreated: dateNow)
let diaryRecord2 = DiaryRecord(dateCreated: dateTwoWeeksAgo, title: "Only title")
let diaryRecord3 = DiaryRecord(dateCreated: dateWeekAgo, text: "Only description")
let diaryRecord4 = DiaryRecord(dateCreated: dateTwoDaysAgo, title: "Title", text: "And description")
let diaryRecord5 = DiaryRecord(dateCreated: dateYesterday, tags: ["only", "tags"])
let diaryRecord6 = DiaryRecord(dateCreated: dateThreeDaysAgo, title: "Title", text: "Description", tags: ["and", "tags"])

var diaryRecords = [diaryRecord1, diaryRecord2, diaryRecord3, diaryRecord4, diaryRecord5, diaryRecord6]
diaryRecords.sort{$0.dateCreated > $1.dateCreated}

for diaryRecord in diaryRecords{
    print(diaryRecord);
}



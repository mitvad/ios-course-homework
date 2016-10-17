import Foundation

class DiaryRecord{
    private let dateCreated: Date
    
    var title: String?
    var description: String?
    var tags: Set<String>?
    
    init(title: String? = nil, description: String? = nil, tags: Set<String>? = nil) {
        self.dateCreated = Date()
        self.title = title
        self.description = description
        self.tags = tags
    }
    
    func fullDescription() -> String{
        var result: String = ""
        
        result += getDateCreatedString()
        result += getString(fromOptionalStringProperty: title)
        result += getTagsString()
        result += getString(fromOptionalStringProperty: description)
        
        return result
    }
    
    /* Utility methods */
    
    private func getDateCreatedString() -> String{
        let dateFormater = DateFormatter()
        dateFormater.dateStyle = .medium
        dateFormater.timeStyle = .none
        
        return dateFormater.string(from: dateCreated) + "\n"
    }
    
    private func getTagsString() -> String{
        if let tags = tags{
            if tags.count > 0
            {
                var result = ""
                
                for tag in tags{
                    result += "[\(tag)]"
                }
                
                result += "\n"
                
                return result
            }
        }
        
        return ""
    }
    
    private func getString(fromOptionalStringProperty property: String?) -> String{
        if let property = property{
            return property + "\n"
        }
        
        return ""
    }
}

let diaryRecord1 = DiaryRecord()
print(diaryRecord1.fullDescription())

let diaryRecord2 = DiaryRecord(title: "Only title")
print(diaryRecord2.fullDescription())

let diaryRecord3 = DiaryRecord(description: "Only description")
print(diaryRecord3.fullDescription())

let diaryRecord4 = DiaryRecord(title: "Title", description: "And description")
print(diaryRecord4.fullDescription())

let diaryRecord5 = DiaryRecord(tags: ["only", "tags"])
print(diaryRecord5.fullDescription())

let diaryRecord6 = DiaryRecord(title: "Title", description: "Description", tags: ["and", "tags"])
print(diaryRecord6.fullDescription())




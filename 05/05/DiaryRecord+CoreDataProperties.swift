//
//  DiaryRecord+CoreDataProperties.swift
//  04
//
//  Created by Vadym on 3110//16.
//  Copyright © 2016 Vadym Mitin. All rights reserved.
//

import Foundation
import CoreData


extension DiaryRecord {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<DiaryRecord> {
        return NSFetchRequest<DiaryRecord>(entityName: "DiaryRecord");
    }

    @NSManaged public var dateCreated: NSDate?
    @NSManaged public var descriptionText: String?
    @NSManaged public var titleText: String?
    @NSManaged public var weather: Int16

}

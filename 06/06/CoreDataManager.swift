//
//  CoreDataManager.swift
//  03-CoreData
//
//  Created by Vadym on 2610//16.
//  Copyright © 2016 Vadym Mitin. All rights reserved.
//

import Foundation
import CoreData

class CoreDataManager{
    
    static let instance: CoreDataManager = CoreDataManager()
    
    var managedObjectContext: NSManagedObjectContext {
        return self.persistentContainer.viewContext
    }
    
    func entityForName(entityName: String) -> NSEntityDescription {
        return NSEntityDescription.entity(forEntityName: entityName, in: self.managedObjectContext)!
    }
    
    func fetchedResultsController(entityName: String, keyForSort: String, sectionNameKeyPath: String) -> NSFetchedResultsController<DiaryRecord> {
        let fetchRequest = NSFetchRequest<DiaryRecord>(entityName: entityName)
        
        let sectionSortDescriptor = NSSortDescriptor(key: sectionNameKeyPath, ascending: false)
        let rowsSortDescriptor = NSSortDescriptor(key: keyForSort, ascending: false)
        fetchRequest.sortDescriptors = [sectionSortDescriptor, rowsSortDescriptor]
        
        let fetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: CoreDataManager.instance.managedObjectContext, sectionNameKeyPath: sectionNameKeyPath, cacheName: nil)
        return fetchedResultsController
    }
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "DiaryCoreDataModel")
        container.persistentStoreDescriptions[0].type = NSBinaryStoreType
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    func saveContext () {
        let managedObjectContext = persistentContainer.viewContext
        var error: NSError? = nil
        if managedObjectContext.hasChanges {
            do {
                try managedObjectContext.save()
            } catch let error1 as NSError {
                error = error1
                NSLog("Unresolved error \(error), \(error!.userInfo)")
                abort()
            }
        }
    }

}

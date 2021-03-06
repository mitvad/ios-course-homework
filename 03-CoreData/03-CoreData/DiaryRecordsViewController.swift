//
//  RecordViewController.swift
//  02-Storyboards
//
//  Created by Vadym on 2110//16.
//  Copyright © 2016 Vadym Mitin. All rights reserved.
//

import UIKit
import CoreData

class DiaryRecordsViewController: UIViewController {
    
    @IBOutlet weak var diaryRecordsTable: UITableView!
    
    @IBAction func unwindToDiaryRecords(sender: UIStoryboardSegue){

    }
    
    var fetchedResultsController = CoreDataManager.instance.fetchedResultsController(entityName: "DiaryRecord", keyForSort: "dateCreated")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchedResultsController.delegate = self
        
        do {
            try fetchedResultsController.performFetch()
        }
        catch {
            print(error)
        }
        
        diaryRecordsTable.dataSource = self
        diaryRecordsTable.delegate = self
        
        diaryRecordsTable.tableFooterView = UIView()
        diaryRecordsTable.bounces = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        diaryRecordsTable.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "EditDiaryRecordSegue"{
            if let editDiaryRecordController = segue.destination as? EditDiaryRecordViewController{
                if let cell = sender as? UITableViewCell{
                    if let indexPath = diaryRecordsTable.indexPath(for: cell){
                        editDiaryRecordController.diaryRecord = fetchedResultsController.object(at: indexPath)
                    }
                    
                }
            }
        }
        else if segue.identifier == "AddDiaryRecordSegue"{
            if let editDiaryRecordController = segue.destination as? EditDiaryRecordViewController{
                let newDiaryRecord = DiaryRecord()
                CoreDataManager.instance.saveContext()
                
                editDiaryRecordController.diaryRecord = newDiaryRecord
            }
        }
    }
    
}

extension DiaryRecordsViewController: UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "diaryRecordCell", for: indexPath)
        
        if let cell = cell as? RecordCell{
            let diaryRecord = fetchedResultsController.object(at: indexPath)
            cell.setTitle(text: diaryRecord.getTitle())
            cell.setDate(text: diaryRecord.getDateCreated())
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let sections = fetchedResultsController.sections{
            return sections[section].numberOfObjects
        }
        else{
            return 0
        }
    }

}

extension DiaryRecordsViewController: UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let action = UITableViewRowAction(
            style: UITableViewRowActionStyle.destructive,
            title: "Remove",
            handler: remove)
        
        return [action]
    }
    
    func remove(_ action: UITableViewRowAction, _ indexPath: IndexPath){
        let managedObject = fetchedResultsController.object(at: indexPath)
        
        CoreDataManager.instance.managedObjectContext.delete(managedObject)
        CoreDataManager.instance.saveContext()
    }
}

extension DiaryRecordsViewController: NSFetchedResultsControllerDelegate{
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        
        switch type {
        case .insert:
            if let indexPath = newIndexPath {
                diaryRecordsTable.insertRows(at: [indexPath], with: .automatic)
            }
        case .update:
            if let indexPath = indexPath {
                let diaryRecord = fetchedResultsController.object(at: indexPath)
                let cell = diaryRecordsTable.cellForRow(at: indexPath)
                if let cell = cell as? RecordCell{
                    cell.setTitle(text: diaryRecord.getTitle())
                    cell.setDate(text: diaryRecord.getDateCreated())

                }
            }
        case .move:
            if let indexPath = indexPath {
                diaryRecordsTable.deleteRows(at: [indexPath], with: .automatic)
            }
            if let newIndexPath = newIndexPath {
                diaryRecordsTable.insertRows(at: [newIndexPath], with: .automatic)
            }
        case .delete:
            if let indexPath = indexPath {
                diaryRecordsTable.deleteRows(at: [indexPath], with: .automatic)
            }
        }
    }
    
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        diaryRecordsTable.beginUpdates()
    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        diaryRecordsTable.endUpdates()
    }
    
}

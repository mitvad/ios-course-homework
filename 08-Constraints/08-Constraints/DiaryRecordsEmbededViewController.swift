//
//  RecordViewController.swift
//  02-Storyboards
//
//  Created by Vadym on 2110//16.
//  Copyright © 2016 Vadym Mitin. All rights reserved.
//

import UIKit
import CoreData

class DiaryRecordsEmbededViewController: UIViewController {
    
    @IBOutlet weak var diaryRecordsTable: UITableView!
    
    @IBAction func unwindToDiaryRecords(sender: UIStoryboardSegue){

    }
    
    private var observer: Any!
    
    var fetchedResultsController: NSFetchedResultsController<DiaryRecord>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchedResultsController = DiaryModel.instance.diaryFetchResultController
        
        diaryRecordsTable.tableFooterView = UIView()
        diaryRecordsTable.bounces = true
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        fetchedResultsController.delegate = nil
        diaryRecordsTable.dataSource = nil
        diaryRecordsTable.delegate = nil
        
        NotificationCenter.default.removeObserver(observer)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        fetchedResultsController.delegate = self
        diaryRecordsTable.dataSource = self
        diaryRecordsTable.delegate = self
        
        diaryRecordsTable.reloadData()
        
        observer = NotificationCenter.default.addObserver(forName: Notification.Name.DiaryModelFetchResultChanged, object: nil, queue: nil, using: {(notification) in self.diaryRecordsTable.reloadData()})
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
                newDiaryRecord.dateCreated = NSDate()
                //CoreDataManager.instance.saveContext()
                
                editDiaryRecordController.diaryRecord = newDiaryRecord
            }
        }
    }
    
}

// MARK: - extension UITableViewDataSource

extension DiaryRecordsEmbededViewController: UITableViewDataSource{
    
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
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if let sectionRecord = fetchedResultsController.sections?[section].objects?[0] as? DiaryRecord{
            return sectionRecord.sectionTitle
        }
        
        return ""
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        if let sections = fetchedResultsController.sections{
            return sections.count
        }
        else{
            return 0
        }
    }

}

// MARK: - extension UITableViewDelegate

extension DiaryRecordsEmbededViewController: UITableViewDelegate{
    
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        DiaryModel.instance.diaryRecordToEdit = fetchedResultsController.object(at: indexPath)
        
        if let cell = diaryRecordsTable.cellForRow(at: indexPath){
            cell.setSelected(false, animated: false)
        }
    }
}

// MARK: - extension NSFetchedResultsControllerDelegate

extension DiaryRecordsEmbededViewController: NSFetchedResultsControllerDelegate{
    
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
//                diaryRecordsTable.reloadRows(at: [indexPath], with: .automatic)
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
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange sectionInfo: NSFetchedResultsSectionInfo, atSectionIndex sectionIndex: Int, for type: NSFetchedResultsChangeType){
        switch type {
        case .insert:
            diaryRecordsTable.insertSections(IndexSet([sectionIndex]), with: .automatic)
        case .delete:
            diaryRecordsTable.deleteSections(IndexSet([sectionIndex]), with: .automatic)
        default:
            break
        }
    }
    
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        diaryRecordsTable.beginUpdates()
    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        diaryRecordsTable.endUpdates()
    }
    
}

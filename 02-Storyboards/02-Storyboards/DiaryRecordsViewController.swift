//
//  RecordViewController.swift
//  02-Storyboards
//
//  Created by Vadym on 2110//16.
//  Copyright © 2016 Vadym Mitin. All rights reserved.
//

import UIKit

class DiaryRecordsViewController: UIViewController {
    
    @IBOutlet weak var diaryRecordsTable: UITableView!
    
    @IBAction func unwindToDiaryRecords(sender: UIStoryboardSegue){

    }
    
    var diaryModel: DiaryModel
    
    required init?(coder aDecoder: NSCoder){
        diaryModel = DiaryModel()
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
                        if let diaryRecord = diaryModel.getRecord(at: indexPath.item){
                            editDiaryRecordController.diaryRecord = diaryRecord
                        }
                    }
                    
                }
            }
        }
        else if segue.identifier == "AddDiaryRecordSegue"{
            if let editDiaryRecordController = segue.destination as? EditDiaryRecordViewController{
                let newRecord = diaryModel.newRecord()
                editDiaryRecordController.diaryRecord = newRecord
            }
        }
        else if segue.identifier == "SettingsSegue"{
            print("SettingsSegue")
        }
    }
    
}

extension DiaryRecordsViewController: UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "diaryRecordCell", for: indexPath)
        
        if let cell = cell as? RecordCell{
            if let diaryRecord = diaryModel.getRecord(at: indexPath.item){
                cell.setTitle(text: diaryRecord.getTitle())
                cell.setDate(text: diaryRecord.getDateCreated())
            }
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return diaryModel.recordsCount
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
        print("Remove \(indexPath.item)")
        if diaryModel.removeRecord(at: indexPath.item) != nil{
            diaryRecordsTable.deleteRows(at: [indexPath], with: UITableViewRowAnimation.left)
        }
    }
}

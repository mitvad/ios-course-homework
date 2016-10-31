//
//  Settings2ViewController.swift
//  02-Storyboards
//
//  Created by Vadym on 2410//16.
//  Copyright © 2016 Vadym Mitin. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let cell = tableView.cellForRow(at: IndexPath(item: 0, section: 1)) as? SwitchCell{
            Settings.instance.naturalLanguageSupport = cell.switch.isOn
            
            Settings.instance.saveInUserDefaults()
        }
    }

}

extension SettingsViewController: UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0{
            let selectedCell = tableView.cellForRow(at: indexPath)
            selectedCell?.accessoryType = .checkmark
            selectedCell?.setSelected(false, animated: true)
            
            let deselectedCell = tableView.cellForRow(at: IndexPath(item: (indexPath.item == 0 ? 1 : 0), section: indexPath.section))
            deselectedCell?.accessoryType = .none
            
            if let selectedCell = selectedCell as? DateCell{
                if selectedCell.title.text == "Date and Time"{
                    Settings.instance.dateFormat = .dateAndTime
                }
                else{
                    Settings.instance.dateFormat = .dateOnly
                }
            }
        }
    }
    
    func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        if indexPath.section == 1{
            return nil
        }
        
        return indexPath
    }
}

extension SettingsViewController: UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "DateCell", for: indexPath)
            if let cell = cell as? DateCell{
                switch indexPath.item {
                case 0:
                    cell.title.text = "Date and Time"
                    cell.accessoryType = (Settings.instance.dateFormat == .dateAndTime) ? .checkmark : .none
                case 1:
                    cell.title.text = "Date Only"
                    cell.accessoryType = (Settings.instance.dateFormat == .dateOnly) ? .checkmark : .none
                default:
                    break
                }
            }
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: "SwitchCell", for: indexPath)
            if let cell = cell as? SwitchCell{
                cell.title.text = "Natural Language Support"
                cell.switch.isOn = Settings.instance.naturalLanguageSupport
            }
            return cell
        default:
            return tableView.dequeueReusableCell(withIdentifier: "DateCell", for: indexPath)
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 2
        case 1:
            return 1
        default:
            return 0
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0:
            return "DATE FORMAT"
        default:
            return nil
        }
    }
}


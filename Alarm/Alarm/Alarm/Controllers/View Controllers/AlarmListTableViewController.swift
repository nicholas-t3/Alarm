//
//  AlarmListTableViewController.swift
//  Alarm
//
//  Created by Nicholas Towery on 11/9/20.
//

import UIKit

class AlarmListTableViewController: UITableViewController {
    
    // MARK: - Lifecycle Methods
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        tableView.reloadData()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        AlarmController.shared.loadFromPersistence()
        
    }
    
    // MARK: - Actions
    @IBAction func switchValueChanged(_ sender: Any) {
    }
    
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return AlarmController.shared.alarms.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "alarmCell", for: indexPath) as? SwitchTableViewCell else {
            return UITableViewCell()}
        
        cell.delegate = self
        cell.alarm = AlarmController.shared.alarms[indexPath.row]
        //cell.alarm = AlarmController.shared.mockAlarms[indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return view.frame.height / 7
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let alarm = AlarmController.shared.alarms[indexPath.row]
            //let alarm = AlarmController.shared.mockAlarms[indexPath.row]
            guard let index = AlarmController.shared.alarms.firstIndex(of: alarm) else {return}
            //guard let index = AlarmController.shared.mockAlarms.firstIndex(of: alarm) else {return}
            //AlarmController.shared.mockAlarms.remove(at: index)
            AlarmController.shared.alarms.remove(at: index)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "detailVC" {
            guard let indexPath = tableView.indexPathForSelectedRow,
                  let destinationVC = segue.destination as? AlarmDetailTableViewController else {return}
            let alarm = AlarmController.shared.alarms[indexPath.row]
            destinationVC.alarm = alarm
        }
    }
} // End of class

extension AlarmListTableViewController: SwitchCellDelegate {
    func enabledSwitchTapped(for cell: SwitchTableViewCell) {
        guard let indexPath = tableView.indexPath(for: cell) else {return}
        let alarm = AlarmController.shared.alarms[indexPath.row]
        
        AlarmController.shared.toggleEnabled(for: alarm)
        
        cell.updateViews(with: alarm)
        
    }
} //End of class

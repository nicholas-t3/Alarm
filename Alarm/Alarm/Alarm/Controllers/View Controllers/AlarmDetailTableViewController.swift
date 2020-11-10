//
//  AlarmDetailTableViewController.swift
//  Alarm
//
//  Created by Nicholas Towery on 11/9/20.
//

import UIKit

class AlarmDetailTableViewController: UITableViewController {

    // MARK: - Properties
    var alarm: Alarm? {
        didSet {
            
        }
    }
    
    var alarmIsOn: Bool = true
    
    // MARK: - Outlets
    @IBOutlet weak var alarmDatePicker: UIDatePicker!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var button: UIButton!
    
    // MARK: - Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateViews()
        
    }
  
    // MARK: - Actions
    @IBAction func saveButtonTapped(_ sender: Any) {
        guard let name = nameTextField.text else {return}
        let date = alarmDatePicker.date
        let isOn = alarmIsOn
        
        if let alarm = alarm {
            AlarmController.shared.updateAlarm(alarm: alarm, fireDate: date, name: name, enabled: isOn)
        } else {
            AlarmController.shared.addAlarm(fireDate: date, name: name, enabled: isOn)
        }
        navigationController?.popViewController(animated: true)
        
    }
    
    @IBAction func enableButtonTapped(_ sender: Any) {
        if alarmIsOn == true {
            button.setTitle("Off", for: [])
            alarmIsOn = false
            print("Alarm is off")
        } else if alarmIsOn == false {
            button.setTitle("On", for: [])
            alarmIsOn = true
            print("Alarm is on")
        }
    }
    
    
    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 3
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 1
    }
    
    func updateViews(){
        button.setTitle("On", for: [])
        guard let alarm = alarm, isViewLoaded else {return}
        nameTextField.text = alarm.name
        alarmDatePicker.date = alarm.fireDate
        alarmIsOn = alarm.enabled
        if alarmIsOn == false {
            button.setTitle("Off", for: [])
        } else {
            button.setTitle("On", for: [])
        }
    }

} // End of class

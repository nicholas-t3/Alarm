//
//  SwitchTableViewCell.swift
//  Alarm v2
//
//  Created by Nicholas Towery on 11/9/20.
//

import UIKit

class SwitchTableViewCell: UITableViewCell {

    // MARK: - Properties
    var alarm: Alarm? {
        didSet {
            updateViews(with: self.alarm!)
        }
    }
    
    // MARK: - Outlets
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var alarmSwitch: UISwitch!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    // MARK: - Actions
    @IBAction func switchValueChanged(_ sender: Any) {
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    //MARK: - Functions
    func updateViews(with alarm: Alarm){
        timeLabel.text = alarm.fireTimeAsString
        nameLabel.text = alarm.name
        alarmSwitch.isOn = alarm.enabled
        
    }
}

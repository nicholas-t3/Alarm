//
//  SwitchTableViewCell.swift
//  Alarm
//
//  Created by Nicholas Towery on 11/9/20.
//

import UIKit

protocol SwitchCellDelegate: class {
    func enabledSwitchTapped(for cell: SwitchTableViewCell)
}

class SwitchTableViewCell: UITableViewCell {

    // MARK: - Properties
    var alarm: Alarm? {
        didSet {
            updateViews(with: self.alarm!)
        }
    }
    
    weak var delegate: SwitchCellDelegate?
    
    // MARK: - Outlets
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var alarmSwitch: UISwitch!
    @IBOutlet weak var nameLabel: UILabel!
    
    // MARK: - Actions
    @IBOutlet weak var switchValueChanged: UISwitch!
    
    @IBAction func switchValueChanged(_ sender: Any) {
        delegate?.enabledSwitchTapped(for: self)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    


    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func updateViews(with alarm: Alarm){
        timeLabel.text = alarm.fireTimeAsString
        nameLabel.text = alarm.name
        alarmSwitch.isOn = alarm.enabled
    }
}

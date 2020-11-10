//
//  Alarm.swift
//  Alarm
//
//  Created by Nicholas Towery on 11/9/20.
//

import Foundation

class Alarm: Codable {
    var fireDate: Date
    var name: String
    var enabled: Bool
    let uuid: String
    var fireTimeAsString: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .none
        dateFormatter.timeStyle = .short
        let dateString = (dateFormatter.string(from: self.fireDate))
        return dateString
    }
    
    init(fireDate: Date, name: String, enabled: Bool, uuid: String = UUID().uuidString){
        self.fireDate = fireDate
        self.name = name
        self.enabled = enabled
        self.uuid = uuid
    }
} // End of class

extension Alarm: Equatable {
    static func == (lhs: Alarm, rhs: Alarm) -> Bool {
        lhs.fireDate == rhs.fireDate &&
        lhs.name == rhs.name &&
        lhs.enabled == rhs.enabled &&
        lhs.uuid == rhs.uuid
    }
}
    

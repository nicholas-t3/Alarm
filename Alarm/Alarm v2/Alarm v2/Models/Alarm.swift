//
//  Alarm.swift
//  Alarm v2
//
//  Created by Nicholas Towery on 11/9/20.
//

import Foundation

class Alarm: Codable {
    var name: String
    var date: Date
    var enabled: Bool
    var uuid: String
    var fireTimeAsString: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .none
        dateFormatter.timeStyle = .short
        return dateFormatter.string(from: date)
    }
    
    init(name: String, date: Date, enabled: Bool = true, uuid: String = UUID().uuidString){
        self.name = name
        self.date = date
        self.enabled = enabled
        self.uuid = uuid
    }
    
} // End of class

extension Alarm: Equatable {
    static func == (lhs:Alarm, rhs:Alarm) -> Bool {
        lhs.name == rhs.name &&
            lhs.date == rhs.date &&
            lhs.uuid == rhs.uuid
    }
}

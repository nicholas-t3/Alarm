//
//  AlarmController.swift
//  Alarm v2
//
//  Created by Nicholas Towery on 11/9/20.
//

import Foundation

class AlarmController: Codable {

    // MARK: - Properties
    static let shared = AlarmController()
    
    var alarms: [Alarm] = []
    var stagedAlarms: [Alarm] {
        let alarm1 = Alarm(name: "First Alarm", date: Date())
        return [alarm1]
    }
    
    func addAlarm(name: String, date: Date, enabled: Bool) {
        alarms.append(Alarm(name: name, date: date, enabled: enabled))
    }
    
    func update(alarm: Alarm, name: String, date: Date, enabled: Bool){
        alarm.name = name
        alarm.date = date
        alarm.enabled = enabled
    }
    
    func delete(alarm: Alarm){
        guard let index = alarms.firstIndex(of: alarm) else {return}
        alarms.remove(at: index)
    }


// MARK: - Persistence
func fileURL() -> URL {
    let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
    let documentsDirectory = paths[0]
    let filename = "alarms.json"
    let fullURL = documentsDirectory.appendingPathComponent(filename)
    return fullURL
}

func saveToPersistence() {
    do {
        let data =  try JSONEncoder().encode(alarms)
        print(data)
        print(String(data: data, encoding: .utf8)!)
        try data.write(to: fileURL())
    } catch let error {
        print("Error saving alarms \(error)")
    }
}

func loadFromPersistence() {
    do {
        let data = try Data(contentsOf: fileURL())
        let decodedAlarms = try JSONDecoder().decode([Alarm].self, from: data)
        self.alarms = decodedAlarms
    } catch let error {
        print("Error loading data from disk \(error)")
    }
}

}

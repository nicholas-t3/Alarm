//
//  AlarmController.swift
//  Alarm
//
//  Created by Nicholas Towery on 11/9/20.
//

import UIKit

protocol AlarmScheduler: AnyObject {
}

extension AlarmScheduler {
    func scheduleUserNotification(for alarm: Alarm){
        let content = UNMutableNotificationContent()
        content.title = "ALARM TIIIIME"
        content.subtitle = "You alarm is going off"
        content.badge = 1
        content.sound = UNNotificationSound.default
        let date = Calendar.current.dateComponents([.day, .hour, .minute], from: alarm.fireDate)
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: date, repeats: true)
        
        let request = UNNotificationRequest(identifier: alarm.uuid, content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request) { (error) in
            if let error = error {
                print (error)
                print (error.localizedDescription)
            } else {
                print ("User asked to receive notification at \(alarm.fireDate)")
            }
        }
    }
    
    func cancelUserNotification(for alarm: Alarm) {
        let identifiers: [String] = {
            let identifier = alarm.uuid
            return [identifier]
        }()
 
        UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: identifiers)
    }
}

class AlarmController: Codable, AlarmScheduler {

    static let shared = AlarmController()

    
    // MARK: - Properties
    var alarms: [Alarm] = []
    var mockAlarms: [Alarm] = {
        var alarm1 = Alarm(fireDate: Date(), name: "Morning Alarm", enabled: true)
        
        return [alarm1]
    }()
    
    //MARK: CRUD Methods
    func addAlarm(fireDate: Date, name: String, enabled: Bool) {
        let alarm = Alarm(fireDate: fireDate, name: name, enabled: enabled)
        alarms.append(alarm)
        if enabled {
            scheduleUserNotification(for: alarm)
        }
        saveToPersistence()
    }
    
    func deleteAlarm(alarm: Alarm) {
        guard let index = alarms.firstIndex(of: alarm) else {return}
        cancelUserNotification(for: alarm)
        alarms.remove(at: index)
        saveToPersistence()
    }
    
    func updateAlarm(alarm: Alarm, fireDate: Date, name: String, enabled: Bool){
        alarm.fireDate = fireDate
        alarm.name = name
        alarm.enabled = enabled
        if enabled {
            scheduleUserNotification(for: alarm)
        }
        saveToPersistence()
    }
    
    func toggleEnabled(for alarm: Alarm){
        alarm.enabled.toggle()
        if alarm.enabled {
            scheduleUserNotification(for: alarm)
        } else {
            cancelUserNotification(for: alarm)
        }
        
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

    /*init(){
        self.alarms = self.alarms
    }*/
    
    
    
} //End of class

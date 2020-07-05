//
//  Work_JournalApp.swift
//  Shared
//
//  Created by Rafael Rincon on 7/3/20.
//

import SwiftUI
import CoreData

@main
struct Work_JournalApp: App {
    
    @Environment(\.scenePhase) private var scenePhase
    
    var body: some Scene {
        WindowGroup {
            ContentView(journalEntryStore: TestData.journalEntries)
        }.onChange(of: scenePhase) { newPhase in
            if newPhase == .background {
                
            }
        }
    }
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "Model")	
        container.loadPersistentStores { _, error in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        }
        return container
    }()
}



class JournalEntryStore: Identifiable, ObservableObject {
    let id = UUID()
    @State var journalEntries: [JournalEntry]
    
    init(journalEntries: [JournalEntry] = []) {
        self.journalEntries = journalEntries
    }
}

class JournalEntry: Identifiable, ObservableObject {
    let id = UUID()
    var time: JournalEntryTime
    var taskID: [TaskIDComponent]
    
    init(time: JournalEntryTime, taskID: [TaskIDComponent]) {
        self.time = time
        self.taskID = taskID
    }
}

class TaskIDComponent: Identifiable, ObservableObject {
    let id = UUID()
    @State var value: String
    
    init(value: String) {
        self.value = value
    }
}

class JournalEntryTime: Identifiable, ObservableObject {
    let id = UUID()
    @State var hoursMinutes: String
    @State var amPM: String
    
    init(hoursMinutes: String, amPM: String) {
        self.hoursMinutes = hoursMinutes
        self.amPM = amPM
    }
}


struct TestData {
    static var journalEntries = JournalEntryStore(journalEntries: {
        var entries = [JournalEntry]()
        entries.append(JournalEntry(time: .init(hoursMinutes: "00:00", amPM: "AM"), taskID: [.init(value: "0"), .init(value: "0")]))
        let hourFormatter = DateFormatter()
        hourFormatter.dateFormat = "h:mm"
        let amPMFormatter = DateFormatter()
        amPMFormatter.dateFormat = "a"
        var time = Date()
        
        for i in 1 ... 5 {
            for j in 1 ... Int.random(in: 2 ... 4) {
                entries.append(JournalEntry(time: .init(hoursMinutes: hourFormatter.string(from: time), amPM: amPMFormatter.string(from: time)), taskID: [.init(value: "\(i)"), .init(value: "\(j)")]))
                time = time.advanced(by: 60 * TimeInterval.random(in: 10...60))
            }
        }
        
        return entries
    }())
}


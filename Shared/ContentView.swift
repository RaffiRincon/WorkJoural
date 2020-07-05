//
//  ContentView.swift
//  Shared
//
//  Created by Rafael Rincon on 7/3/20.
//

import SwiftUI

struct ContentView: View {
    @State var journalEntryStore: JournalEntryStore
    
    var body: some View {
        NavigationView {
            List {
                ForEach(journalEntryStore.journalEntries) { journalEntry in
                    JournalEntryCell(journalEntry: journalEntry)
                }
                AddTaskStartCell()
            }.navigationTitle("Tasks")
        }
    }
    
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ContentView(journalEntryStore: TestData.journalEntries)
        }
    }
}

struct AddTaskStartCell: View {
    var body: some View {
        HStack {
            Spacer()
            Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                HStack() {
                    Spacer()
                    Image(systemName: "plus")
                        .resizable(capInsets: EdgeInsets(), resizingMode: .stretch)
                        .frame(width: 36, height: 36, alignment: .center)
                        .colorScheme(.dark)
                        .padding(.vertical, 8)
                    Spacer()
                }.background(Color(.systemBlue))
            })
            .cornerRadius(8)
            .frame(width: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, height: nil, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
            Spacer()
        }
    }
}

struct JournalEntryCell: View {
    @ObservedObject var journalEntry: JournalEntry
    
    var body: some View {
        HStack(alignment: .center, spacing: 0) {
            ZStack(alignment: .leading) {
                Color(.darkGray)
                Color(.white)
                    .padding(EdgeInsets(top: 0, leading: 0, bottom: 2, trailing: 2))
                
                HStack(alignment: .center, spacing: 0) {
                    TextField("", text: $journalEntry.time.hoursMinutes)
                        .padding(EdgeInsets(top: 0, leading: 0, bottom: 2, trailing: 0))
                        .frame(width: 50, alignment: .leading)
                    TextField("", text: $journalEntry.time.amPM)
                        .padding(EdgeInsets(top: 0, leading: 0, bottom: 2, trailing: 0))
                        .frame(width: 30, alignment: .leading)
                }
            }
            ForEach(journalEntry.taskID, id: \.id) { component in
                ZStack {
                    Color(.darkGray)
                    Color(.white)
                        .padding(EdgeInsets(top: 0, leading: 0, bottom: 2, trailing: 2))
                    TextField("", text: component.$value)
                        .padding(EdgeInsets(top: 0, leading: 0, bottom: 2, trailing: 2))
                        .frame(width: 25, height: 25, alignment: .center)
                }
            }
        }
        .fixedSize()
    }
}

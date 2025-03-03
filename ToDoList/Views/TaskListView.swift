//
//  TaskListView.swift
//  ToDoList
//
//  Created by Sonali Kalange on 20/02/25.
//
import SwiftData
import SwiftUI

struct TaskListView: View {
    @Environment(\.modelContext) var modelContext
    @Query(sort: \Tasks.taskDate) var taskData: [Tasks]
    
    var body: some View {
        List {
            let dict = getTaskDictionary()
            ForEach(dict.sortPerDates(), id: \.key) { key, events in
                Section {
                    ForEach(events) { task in
                        TaskRow(task: task)
                    }
                } header: {
                    Text(getSectionHeader(dateKey: key))
                        .font(.system(size: 13, weight: .heavy))
                        .foregroundStyle(getSectionHeaderColor(dateKey: key))
                }
            }
        }
        .scrollContentBackground(.hidden)
        .background(Color.taskRowColor)
    }
    
    func getTaskDictionary() -> [String: [Tasks]] {
        return Dictionary(grouping: taskData, by: {$0.taskDate})
    }
    
    func getSectionHeader(dateKey: String) -> String {
        return dateKey == DateUtility().getCurrentDateString() ? dateKey : "Pending - \(dateKey)"
    }
    
    func getSectionHeaderColor(dateKey: String) -> Color {
        return dateKey == DateUtility().getCurrentDateString() ? Color.textLightColor : Color.red
    }

}

struct TaskRow: View {
    var task: Tasks
    @Environment(\.modelContext) var modelContext
    @State private var taskComplete = false
    
    var body: some View {
        Toggle(task.taskTitle, isOn: $taskComplete)
            .toggleStyle(CircleToggleStyle())
            .listRowBackground(Color.white)
            .swipeActions(edge: .trailing, allowsFullSwipe: false) {
                Button {
                    deleteTask(task: task)
                } label: {
                    Text("Delete Task")
                }
                .tint(.red)
                .foregroundStyle(Color.black)
            }
    }
    
    func deleteTask(task: Tasks) {
        modelContext.delete(task)
        try! modelContext.save()
    }
}

struct CircleToggleStyle: ToggleStyle {
    func makeBody(configuration: Configuration) -> some View {
        Button {
            configuration.isOn.toggle()
        } label: {
            Label {
                configuration.label
                    .italic()
                    .font(.system(size: 13, weight: .bold))
                    .foregroundStyle(Color.darkTextColor)
                    .strikethrough(configuration.isOn)
            } icon: {
                Image(systemName: configuration.isOn ? "checkmark.circle.fill" : "circle")
                    .foregroundStyle(Color.lightGrayColor)
            }

        }
        .buttonStyle(.plain)
    }
}

//Sort dictionary that contains tasks grouped by dates with the task for recent date at the top
extension Dictionary {
    func sortPerDates() -> [Self.Element] {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE, MMM d, yyyy"
        
        let sortedDict = self
            .sorted(by: {
                if let date1 = dateFormatter.date(from: $0.key as! String), let date2 = dateFormatter.date(from: $1.key as! String) {
                    return date1 > date2 // Compare by Date object
                }
                return false
            })
        return sortedDict
    }
}

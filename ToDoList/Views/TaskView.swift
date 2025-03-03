//
//  TaskView.swift
//  ToDoList
//
//  Created by Sonali Kalange on 19/02/25.
//

import SwiftUI

struct TaskView: View {
    
    @Binding var navigationPath: [String]
    @Environment(\.modelContext) var modelContext
    @State var taskTitle = ""
    @State var taskDescriptionPlaceholder = ""
    @State var startDate = Date.now
    @State var endDate = Calendar.current.date(byAdding: .day, value: 1, to: Date.now)!
    @State var setAlarm = false
    var taskNotification = TaskReminderNotifications().shared
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Title")
                .font(.system(size: 13, weight: .heavy))
                .foregroundStyle(Color.darkTextColor)
            
            TextField("E.g Grocery List",
                      text: $taskTitle)
            .tint(.black)
            .textFieldStyle(.roundedBorder)
            .autocorrectionDisabled(true)
            .textInputAutocapitalization(.sentences)
            .font(.system(size: 13))
            .padding(EdgeInsets(top:10, leading: 0, bottom: 30, trailing: 0))
            
            Text("Notes")
                .font(.system(size: 13, weight: .heavy))
                .foregroundStyle(Color.darkTextColor)
            
            TextEditor(text: $taskDescriptionPlaceholder)
                .font(.system(size: 13))
                .border(Color.clear)
                .frame(height: 100)
                .overlay {
                    RoundedRectangle(cornerRadius: 5)
                        .stroke(Color.lightGrayColor.opacity(0.3))
                }
                .padding(EdgeInsets(top:10, leading: 0, bottom: 30, trailing: 0))
            
            
            HStack {
                Text("Starts")
                    .font(.system(size: 13, weight: .heavy))
                    .foregroundStyle(Color.darkTextColor)
                Spacer()
                    .frame(width: 210)
                Text("Ends")
                    .font(.system(size: 13, weight: .heavy))
                    .foregroundStyle(Color.darkTextColor)
            }
            
            HStack {
                StartDateView(date: $startDate)
                Spacer()
                EndDateView(date: $endDate)
            }
            
            HStack {
                Text("Get alert for this task")
                    .font(.system(size: 13, weight: .heavy))
                    .foregroundStyle(Color.darkTextColor)
                Spacer()
                
                Toggle(isOn: $setAlarm) {
                }
                .tint(Color.tintColor)
                .onChange(of: setAlarm) {
                    if setAlarm {
                        self.taskNotification.scheduleReminderNotification(at: startDate, taskDescription: taskTitle)
                    }
                }
            }
            .padding(EdgeInsets(top:30, leading: 0, bottom: 30, trailing: 0))
            
            Spacer()
            
            Button {
                saveNote()
                navigationPath.removeAll()
            } label: {
                Text("Create Task")
                    .frame(maxWidth: .infinity)
            }
            .background(Color.navigationBarColor)
            .font(.system(size: 15, weight: .heavy))
            .buttonStyle(.bordered)
        }
        .padding(EdgeInsets(top: 30, leading: 20, bottom: 10, trailing: 20))
        .onTapGesture {
            self.endTextEditing()
        }
    }
    
    func saveNote() {
        let task = Tasks(taskTitle: taskTitle, taskDate: DateUtility().getDateString(date: startDate), taskDescription: taskDescriptionPlaceholder)
        modelContext.insert(task)
        try! modelContext.save()
    }
}

struct StartDateView: View {
    
    @Binding var date: Date
    
    var body: some View {
        VStack(alignment: .leading) {
            DatePicker("", selection: $date, in: Date.now..., displayedComponents: .date)
                .datePickerStyle(.compact)
                .frame(height: 30)
                .labelsHidden()
                .tint(Color.tintColor)
            Spacer()
                .frame(height: 30)
            DatePicker("", selection: $date, in: Date.now..., displayedComponents: .hourAndMinute)
                .datePickerStyle(.compact)
                .frame(height: 30)
                .labelsHidden()
        }
    }
}

struct EndDateView: View {
    
    @Binding var date: Date
    
    var body: some View {
        VStack(alignment: .leading) {
            DatePicker("", selection: $date, in: Date.now..., displayedComponents: .date)
                .datePickerStyle(.compact)
                .frame(height: 30)
                .labelsHidden()
                .tint(Color.tintColor)
            Spacer()
                .frame(height: 30)
            DatePicker("", selection: $date, in: Date.now..., displayedComponents: .hourAndMinute)
                .datePickerStyle(.compact)
                .frame(height: 30)
                .labelsHidden()
        }
    }
}

extension View {
    func endTextEditing() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder),
                                        to: nil, from: nil, for: nil)
    }
}

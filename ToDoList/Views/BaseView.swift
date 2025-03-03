//
//  BaseView.swift
//  ToDoList
//
//  Created by Sonali Kalange on 18/02/25.
//

import SwiftUI

struct BaseView: View {
    
    @Binding var navigationPath: [String]
    @State var taskCount: Int
    
    var body: some View {
        HStack(alignment: .top, spacing: 5) {
            VStack(alignment: .leading, spacing: 10) {
                Text("Hey, user! Welcome Back")
                    .italic()
                    .font(.system(size: 13, weight: .regular))
                    .foregroundStyle(Color.darkTextColor)
                    .padding(EdgeInsets(top: 10, leading: -10, bottom: 10, trailing: 0))
                Text(getTaskCountString())
                    .font(.system(size: 13, weight: .regular))
                    .foregroundStyle(Color.textLightColor)
                    .padding(EdgeInsets(top: 10, leading: -10, bottom: 10, trailing: 10))
            }
            .frame(maxWidth: .infinity)
            
            NavigationLink(value: "TaskView") {
                HStack {
                    Image(systemName: "plus")
                        .foregroundStyle(Color.darkTextColor)
                    Text("New task")
                        .foregroundStyle(Color.darkTextColor)
                        .font(.system(size: 15, weight: .bold))
                }
                .padding(EdgeInsets(top: 10, leading: 0, bottom: 10, trailing: 10))
            }
        }
        .background(Color.headerColor)
        .navigationDestination(for: String.self) { value in
            if value == "TaskView" {
                TaskView(navigationPath: $navigationPath)
            }
        }
    }
    
    func getTaskCountString() -> String {
        return taskCount > 0 ? "You have \(taskCount) tasks planned for today" : "You have no tasks planned for today.\n Tap '+ New Task' to get started"
    }
}

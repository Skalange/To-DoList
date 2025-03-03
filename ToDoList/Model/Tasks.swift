//
//  Tasks.swift
//  ToDoList
//
//  Created by Sonali Kalange on 19/02/25.
//

import Foundation
import SwiftData

@Model
class Tasks {
    var taskTitle: String
    var taskDate: String
    var taskDescription: String
    
    init(taskTitle: String, taskDate: String, taskDescription: String) {
        self.taskTitle = taskTitle
        self.taskDate = taskDate
        self.taskDescription = taskDescription
    }
}

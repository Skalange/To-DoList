//
//  ToDoListApp.swift
//  ToDoList
//
//  Created by Sonali Kalange on 18/02/25.
//
import SwiftData
import SwiftUI

@main
struct ToDoListApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: Tasks.self)
    }
}

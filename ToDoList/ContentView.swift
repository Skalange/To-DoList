//
//  ContentView.swift
//  ToDoList
//
//  Created by Sonali Kalange on 18/02/25.
//
import SwiftData
import SwiftUI

struct ContentView: View {
    @State private var navigationPath = [String]()
    @Environment(\.modelContext) var modelContext
    @State var createNewTask: Bool = false
    @Query var tasks: [Tasks]
    
    init() {
        
        let coloredAppearance = UINavigationBarAppearance()
        coloredAppearance.configureWithOpaqueBackground()
        coloredAppearance.backgroundColor = UIColor(Color.navigationBarColor)
        // Large Navigation Title
        coloredAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        // Inline Navigation Title
        coloredAppearance.titleTextAttributes = [.foregroundColor: UIColor.white]
        
        UINavigationBar.appearance().standardAppearance = coloredAppearance
        UINavigationBar.appearance().compactAppearance = coloredAppearance
        UINavigationBar.appearance().scrollEdgeAppearance = coloredAppearance
        
        UINavigationBar.appearance().tintColor = .white
   }
    
    var body: some View {
        NavigationStack(path: $navigationPath) {
            
            VStack(alignment: .center, spacing: 5) {
                BaseView(navigationPath: $navigationPath, taskCount: getTaskCountForCurrentDay())
                Spacer()
                if tasks.isEmpty {
                    EmptyTasksView()
                } else {
                    TaskListView()
                }
                Spacer()
                
            }
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Image("navigationIcon")
                }
            }
            .navigationTitle("To-Do List")
            .navigationBarBackButtonHidden(true)
        }
        .tint(.white)
    }
    
    func groupData() -> [String: [Tasks]] {
        return Dictionary(grouping: tasks, by: {$0.taskDate})
    }
    
    func getTaskCountForCurrentDay() -> Int {
        return tasks.filter { task in
            return task.taskDate == DateUtility().getCurrentDateString()
        }.count
    }
}

#Preview {
    ContentView()
}

//Fetch tasks from DB, if none then show empty list else show tasks

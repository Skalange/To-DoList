//
//  EmptyTasksView.swift
//  ToDoList
//
//  Created by Sonali Kalange on 18/02/25.
//

import SwiftUI

struct EmptyTasksView: View {
    var body: some View {
        Text("You don't have any tasks planned for the day.\n Tap '+ New Task' to get started")
            .font(.system(size: 14, weight: .semibold))
            .multilineTextAlignment(.center)
            .foregroundStyle(Color.darkTextColor)
    }
}

#Preview {
    EmptyTasksView()
}

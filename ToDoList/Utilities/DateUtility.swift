//
//  DateUtility.swift
//  ToDoList
//
//  Created by Sonali Kalange on 18/02/25.
//

import Foundation

struct DateUtility {
    
    func getCurrentDateString() -> String {
        let currentDate = Date.now
        let dateFormat = DateFormatter()
        dateFormat.dateFormat = "EEEE, MMM d, yyyy"
        
        return dateFormat.string(from: currentDate)
    }
    
    func getDateString(date: Date) -> String {
        let dateFormat = DateFormatter()
        dateFormat.dateFormat = "EEEE, MMM d, yyyy"
        
        return dateFormat.string(from: date)
    }
}

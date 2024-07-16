//
//  DayCounter.swift
//  EwaTestTask
//
//  Created by Alexander Sivko on 16.07.24.
//

import Foundation

// MARK: - DayCounter
final class DayCounter: ObservableObject {
    
    // MARK: Properties
    @Published var dayCount: Int = 0
    @Published var isExceedsDayCount = false
    
    // MARK: Methods
    func incrementDayCount() {
        if dayCount < 3 {
            dayCount += 1
            if dayCount == 3 { isExceedsDayCount = true }
        }
    }

    func reset() {
        dayCount = 0
        isExceedsDayCount = false
    }
}

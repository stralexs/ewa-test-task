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
    @Published private(set) var dayCount: Int = 0
    @Published private(set) var isExceedsDayCount = false
    
    // MARK: Methods
    func incrementDayCount() {
        guard dayCount < 3 else { return }
        dayCount += 1
        isExceedsDayCount = dayCount == 3
    }

    func reset() {
        dayCount = 0
        isExceedsDayCount = false
    }
}

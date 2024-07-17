//
//  DataBaseManager.swift
//  EwaTestTask
//
//  Created by Alexander Sivko on 17.07.24.
//

import Foundation

/// Added only for testing purposes

// MARK: - DataBaseManagerLogic
protocol DataBaseManagerLogic {
    func savePrizeToUserStatistics(_ prize: Prize)
    func discardPrizeFromUserStatistics(_ prize: Prize)
}

// MARK: - DataBaseManager
final class DataBaseManager: DataBaseManagerLogic {
    func savePrizeToUserStatistics(_ prize: Prize) {
        // Logic of saving prize to user's statistics
    }
    
    func discardPrizeFromUserStatistics(_ prize: Prize) {
        // Logic of discarding the prize
    }
}

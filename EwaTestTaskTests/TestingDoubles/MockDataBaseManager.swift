//
//  MockDataBaseManager.swift
//  EwaTestTaskTests
//
//  Created by Alexander Sivko on 17.07.24.
//

@testable import EwaTestTask

// MARK: - MockDataBaseManager
final class MockDataBaseManager: DataBaseManagerLogic {
    
    // MARK: Properties
    var isCalledSavePrize = false
    var isCalledDiscardPrize = false
    var testedPrize: Prize = .init(name: "foo", isRare: false)
    
    // MARK: Methods
    func savePrizeToUserStatistics(_ prize: Prize) {
        isCalledSavePrize = true
        testedPrize = prize
    }
    
    func discardPrizeFromUserStatistics(_ prize: Prize) {
        isCalledDiscardPrize = true
        testedPrize = prize
    }
}

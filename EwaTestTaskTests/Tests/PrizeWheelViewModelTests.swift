//
//  PrizeWheelViewModelTests.swift
//  EwaTestTaskTests
//
//  Created by Alexander Sivko on 17.07.24.
//

import XCTest

@testable import EwaTestTask

// MARK: - PrizeWheelViewModelTests
final class PrizeWheelViewModelTests: XCTestCase {

    // MARK: Properties
    private var mockDataBaseManager: MockDataBaseManager!
    private var sut: PrizeWheelViewModel!
    
    // MARK: Override
    override func setUpWithError() throws {
        try super.setUpWithError()
        
        mockDataBaseManager = MockDataBaseManager()
        sut = PrizeWheelViewModel(dataBaseManager: mockDataBaseManager)
    }

    override func tearDownWithError() throws {
        mockDataBaseManager = nil
        sut = nil
        
        try super.tearDownWithError()
    }
    
    // MARK: Tests
    func testProvideSectorIndex_providesCorrectIndex() {
        let expectedIndex = 0
        let index = sut.provideSectorIndex(for: 1)
        XCTAssertEqual(expectedIndex, index, "Expected 0 index for Day 1 prize")
    }
    
    func testReclaimPrize_savesPrizeToDataBase() {
        sut.reclaimPrize()
        XCTAssertTrue(mockDataBaseManager.isCalledSavePrize, "Expected method to be called")
        XCTAssertEqual(sut.currentPrize.name, mockDataBaseManager.testedPrize.name, "Expected saved and current prizes to be equal")
    }
    
    func testDiscardPrize_discardsPrizeFromDataBase() {
        sut.discardPrize()
        XCTAssertTrue(mockDataBaseManager.isCalledDiscardPrize, "Expected method to be called")
        XCTAssertEqual(sut.currentPrize.name, mockDataBaseManager.testedPrize.name, "Expected discarded and current prizes to be equal")
    }
}

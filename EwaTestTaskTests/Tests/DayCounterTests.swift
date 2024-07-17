//
//  DayCounterTests.swift
//  EwaTestTaskTests
//
//  Created by Alexander Sivko on 17.07.24.
//

import XCTest

@testable import EwaTestTask

// MARK: - DayCounterTests
final class DayCounterTests: XCTestCase {

    // MARK: Properties
    private var sut: DayCounter!
    
    // MARK: Override
    override func setUpWithError() throws {
        try super.setUpWithError()
        
        sut = DayCounter()
    }

    override func tearDownWithError() throws {
        sut = nil
        
        try super.tearDownWithError()
    }
    
    // MARK: Tests
    func testIncrementDayCount_incrementsDayCorrectly() {
        sut.incrementDayCount()
        XCTAssertTrue(sut.dayCount == 1, "Expected day to be incremented only by 1 day")
    }
    
    func testIncrementDayCount_whenReachesThirdDay_setExceedsDayCountToTrue() {
        XCTAssertFalse(sut.isExceedsDayCount, "Expected isExceedsDayCount to be false")
        sut.incrementDayCount()
        sut.incrementDayCount()
        sut.incrementDayCount()
        XCTAssertTrue(sut.isExceedsDayCount, "Expected isExceedsDayCount to be true")
    }
    
    func testReset_resetsDataCorrectly() {
        sut.reset()
        XCTAssertFalse(sut.isExceedsDayCount, "Expected isExceedsDayCount to be false")
        XCTAssertTrue(sut.dayCount == 0, "Expected dayCount to be 0")
    }
}

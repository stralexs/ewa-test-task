//
//  PrizeWheelViewModel.swift
//  EwaTestTask
//
//  Created by Alexander Sivko on 16.07.24.
//

import Foundation

// MARK: - PrizeWheelViewModel
final class PrizeWheelViewModel: ObservableObject {
    
    // MARK: Properties
    private let dataBaseManager: DataBaseManagerLogic
    @Published private(set) var currentPrize: Prize = .init(name: "\u{2764}\u{FE0F}", isRare: false)
    let prizes: [Prize] = [
        .init(name: "\u{2764}\u{FE0F}", isRare: false),
        .init(name: "\u{1F525}", isRare: false),
        .init(name: "\u{2B50}\u{FE0F}", isRare: false),
        .init(name: "\u{1F44D}", isRare: false),
        .init(name: "\u{1F60E}", isRare: true)
    ]
    
    // MARK: Initializer
    init(dataBaseManager: DataBaseManagerLogic) {
        self.dataBaseManager = dataBaseManager
    }

    // MARK: Methods
    func provideSectorIndex(for day: Int) -> Int {
        let index: Int
        switch day {
        case 1:
            index = 0
        case 2:
            index = 1
        case 3:
            index = 4
        default:
            index = 0
        }
        currentPrize = prizes[index]
        return index
    }
    
    func reclaimPrize() {
        dataBaseManager.savePrizeToUserStatistics(currentPrize)
    }
    
    func discardPrize() {
        dataBaseManager.discardPrizeFromUserStatistics(currentPrize)
    }
}

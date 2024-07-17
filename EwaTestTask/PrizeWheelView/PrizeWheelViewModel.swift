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
    @Published private(set) var currentPrize: Prize = .init(name: "\u{2764}\u{FE0F}", isRare: false)
    let prizes: [Prize] = [
        .init(name: "\u{2764}\u{FE0F}", isRare: false),
        .init(name: "\u{1F525}", isRare: false),
        .init(name: "\u{2B50}\u{FE0F}", isRare: false),
        .init(name: "\u{1F44D}", isRare: false),
        .init(name: "\u{1F60E}", isRare: true)
    ]

    // MARK: Methods
    func provideSectorIndex(for day: Int) -> Int {
        let index: Int
        switch day {
        case 1:
            index = prizes.firstIndex(where: { $0.name == "\u{2764}\u{FE0F}" }) ?? 0
        case 2:
            index = prizes.firstIndex(where: { $0.name == "\u{1F525}" }) ?? 0
        case 3:
            index = prizes.firstIndex(where: { $0.name == "\u{1F60E}" && $0.isRare }) ?? 0
        default:
            index = 0
        }
        currentPrize = prizes[index]
        return index
    }
    
    func reclaimPrize() {
        // Logic of saving prize to user's statistics
        // e.g. dataBaseManager.save(currentPrize)
    }
    
    func discardPrize() {
        // Logic of discarding the prize
    }
}

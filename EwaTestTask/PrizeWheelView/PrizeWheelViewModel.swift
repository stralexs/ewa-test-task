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
    @Published private(set) var currentPrize: String = ""
    let prizes = [
        "\u{2764}\u{FE0F}",
        "\u{1F525}",
        "\u{2B50}\u{FE0F}",
        "\u{1F44D}",
        "\u{1F60E}"
    ]

    // MARK: Methods
    func providePrizeIndex(for day: Int) -> Int {
        switch day {
        case 1:
            return prizes.firstIndex(of: "\u{2764}\u{FE0F}") ?? 0
        case 2:
            return prizes.firstIndex(of: "\u{1F525}") ?? 0
        case 3:
            return prizes.firstIndex(of: "\u{1F60E}") ?? 0
        default:
            return 0
        }
    }
    
    func updateCurrentPrize(dayCount: Int) {
        let prizeIndex = min(dayCount - 1, prizes.count - 1)
        currentPrize = prizes[prizeIndex]
    }
    
    func reclaimPrize() {
        // Logic of saving prize to user's statistics
        // e.g. dataBaseManager.save(currentPrize)
    }
    
    func discardPrize() {
        // Logic of discarding the prize
    }
}

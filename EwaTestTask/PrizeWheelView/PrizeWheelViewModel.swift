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
    @Published var currentPrize: String = ""
    let prizes = ["\u{2764}\u{FE0F}", "\u{1F536}", "\u{2B50}\u{FE0F}", "\u{1F590}", "\u{1F60E}"]

    // MARK: Methods
    func updateCurrentPrize(dayCount: Int) {
        let prizeIndex = min(dayCount - 1, prizes.count - 1)
        currentPrize = prizes[prizeIndex]
    }
}

//
//  PrizeWheel.swift
//  EwaTestTask
//
//  Created by Alexander Sivko on 16.07.24.
//

import SwiftUI

// MARK: - PrizeWheel
struct PrizeWheel: View {
    
    // MARK: Properties
    private let prizes: [String]
    
    // MARK: Initializer
    init(prizes: [String]) {
        self.prizes = prizes
    }
    
    // MARK: Body
    var body: some View {
        ZStack {
            ForEach(0..<prizes.count, id: \.self) { index in
                PrizeSector(prize: prizes[index], index: index, total: prizes.count)
            }
            .rotationEffect(Angle(degrees: Consts.additionalRotation))
        }
    }
}

// MARK: - Consts
private extension PrizeWheel {
    enum Consts {
        static let additionalRotation: Double = 90
    }
}

// MARK: - Preview
#Preview {
    PrizeWheel(prizes: ["\u{1F525}", "\u{1F525}", "\u{1F525}", "\u{1F525}", "\u{1F525}"])
}

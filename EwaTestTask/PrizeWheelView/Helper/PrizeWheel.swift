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
    private let prizes: [Prize]
    
    // MARK: Initializer
    init(prizes: [Prize]) {
        self.prizes = prizes
    }
    
    // MARK: Body
    var body: some View {
        ZStack {
            ForEach(0..<prizes.count, id: \.self) { index in
                PrizeSector(
                    prize: prizes[index],
                    startAngle: calculateStartAngle(for: index),
                    endAngle: calculateEndAngle(for: index),
                    colorOpacity: calculateColorOpacity(for: index)
                )
            }
            .rotationEffect(Angle(degrees: Consts.additionalRotation))
        }
    }
}

// MARK: - Private
private extension PrizeWheel {
    func calculateColorOpacity(for index: Int) -> Double {
        1.0 / Double(prizes.count) * Double(index + 1)
    }
    
    func calculateStartAngle(for index: Int) -> Angle {
        let start = prizes[..<index].reduce(0) { $0 + angle(for: $1) }
        return .degrees(start)
    }
    
    func calculateEndAngle(for index: Int) -> Angle {
        let end = prizes[...index].reduce(0) { $0 + angle(for: $1) }
        return .degrees(end)
    }
    
    func angle(for prize: Prize) -> Double {
        let totalDegrees = 360.0
        let rareCount = Double(prizes.filter { $0.isRare }.count)
        let commonCount = Double(prizes.filter { !$0.isRare }.count)
        let commonAngle = totalDegrees / (commonCount + rareCount / 2)
        let rareAngle = commonAngle / 2
        return prize.isRare ? rareAngle : commonAngle
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
    PrizeWheel(prizes: [
        Prize(name: "\u{2764}\u{FE0F}", isRare: false),
        Prize(name: "\u{1F525}", isRare: false),
        Prize(name: "\u{2B50}\u{FE0F}", isRare: false),
        Prize(name:  "\u{1F44D}", isRare: false),
        Prize(name: "\u{1F60E}", isRare: true)
    ])
}

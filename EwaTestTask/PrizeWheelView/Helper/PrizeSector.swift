//
//  PrizeSector.swift
//  EwaTestTask
//
//  Created by Alexander Sivko on 16.07.24.
//

import SwiftUI

// MARK: - PrizeSector
struct PrizeSector: View {
    
    // MARK: Properties
    private let prize: String
    private let index: Int
    private let total: Int
    
    // MARK: Initializer
    init(
        prize: String,
        index: Int,
        total: Int
    ) {
        self.prize = prize
        self.index = index
        self.total = total
    }
    
    // MARK: Body
    var body: some View {
        GeometryReader { proxy in
            let rect = proxy.frame(in: .local)
            let center = CGPoint(x: rect.midX, y: rect.midY)
            let radius = min(rect.width, rect.height) / 2
            let startAngle = Angle(degrees: (Double(index) / Double(total)) * Consts.fullCircleDegree)
            let endAngle = Angle(degrees: (Double(index + 1) / Double(total)) * Consts.fullCircleDegree)
            let midAngle = Angle(degrees: (Double(index) / Double(total)) * Consts.fullCircleDegree + Consts.halfCircleDegree / Double(total))
            let colorOpacity = 1.0 / Double(total) * Double(index + 1)

            ZStack {
                Path { path in
                    path.move(to: center)
                    path.addArc(center: center, radius: radius, startAngle: startAngle, endAngle: endAngle, clockwise: false)
                }
                .fill(.cyan.opacity(colorOpacity))
                .overlay(
                    Path { path in
                        path.move(to: center)
                        path.addArc(center: center, radius: radius, startAngle: startAngle, endAngle: endAngle, clockwise: false)
                        path.closeSubpath() 
                    }
                    .stroke(.black, lineWidth: 2)
                )

                Text(prize)
                    .rotationEffect(midAngle)
                    .position(
                        x: rect.midX + radius * Consts.textPosition * cos(CGFloat(midAngle.radians)),
                        y: rect.midY + radius * Consts.textPosition * sin(CGFloat(midAngle.radians))
                    )
            }
        }
    }
}

// MARK: - Consts
private extension PrizeSector {
    enum Consts {
        static let fullCircleDegree: Double = 360
        static let halfCircleDegree: Double = 180
        static let textPosition: CGFloat = 0.6
    }
}

// MARK: - Preview
#Preview {
    VStack {
        PrizeSector(prize: "\u{1F525}", index: 0, total: 3)
        PrizeSector(prize: "\u{1F525}", index: 1, total: 3)
        PrizeSector(prize: "\u{1F525}", index: 2, total: 3)
    }
}

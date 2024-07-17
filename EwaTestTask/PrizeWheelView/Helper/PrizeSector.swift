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
    private let prize: Prize
    private let startAngle: Angle
    private let endAngle: Angle
    private let colorOpacity: Double
    
    // MARK: Initializer
    init(
        prize: Prize,
        startAngle: Angle,
        endAngle: Angle,
        colorOpacity: Double
    ) {
        self.prize = prize
        self.startAngle = startAngle
        self.endAngle = endAngle
        self.colorOpacity = colorOpacity
    }
    
    // MARK: Body
    var body: some View {
        GeometryReader { proxy in
            let rect = proxy.frame(in: .local)
            let center = CGPoint(x: rect.midX, y: rect.midY)
            let radius = min(rect.width, rect.height) / 2
            let midAngle = Angle(degrees: (startAngle.degrees + endAngle.degrees) / 2)
            
            ZStack {
                Path { path in
                    path.move(to: center)
                    path.addArc(center: center, radius: radius, startAngle: startAngle, endAngle: endAngle, clockwise: false)
                }
                .fill(Color.cyan.opacity(colorOpacity))
                .overlay(
                    Path { path in
                        path.move(to: center)
                        path.addArc(center: center, radius: radius, startAngle: startAngle, endAngle: endAngle, clockwise: false)
                        path.closeSubpath()
                    }
                    .stroke(Color.black, lineWidth: 2)
                )
                
                Text(prize.name)
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
        static let textPosition: CGFloat = 0.6
    }
}

// MARK: - Preview
#Preview {
    VStack {
        PrizeSector(
            prize: Prize(name: "\u{1F525}", isRare: true),
            startAngle: .degrees(0),
            endAngle: .degrees(40),
            colorOpacity: 0.9
        )
        PrizeSector(
            prize: Prize(name: "\u{1F525}", isRare: false),
            startAngle: .degrees(40),
            endAngle: .degrees(120),
            colorOpacity: 0.1
        )
    }
}

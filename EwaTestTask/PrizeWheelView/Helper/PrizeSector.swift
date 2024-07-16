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
    let prize: String
    let index: Int
    let total: Int
    
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
            let startAngle = Angle(degrees: (Double(index) / Double(total)) * 360.0)
            let endAngle = Angle(degrees: (Double(index + 1) / Double(total)) * 360.0)
            let midAngle = Angle(degrees: (Double(index) / Double(total)) * 360.0 + 180 / Double(total))
            let colorOpacity = 1.0 / Double(total) * Double(index + 1)

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
                    }
                    .stroke(Color.black, lineWidth: 2)
                )

                Text(prize)
                    .rotationEffect(midAngle)
                    .position(
                        x: rect.midX + radius * 0.6 * cos(CGFloat(midAngle.radians)),
                        y: rect.midY + radius * 0.6 * sin(CGFloat(midAngle.radians))
                    )
            }
        }
    }
}

// MARK: - Preview
#Preview {
    PrizeSector(prize: "\u{1F525}", index: 0, total: 4)
}

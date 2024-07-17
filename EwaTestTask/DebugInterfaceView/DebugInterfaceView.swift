//
//  DebugInterfaceView.swift
//  EwaTestTask
//
//  Created by Alexander Sivko on 16.07.24.
//

import SwiftUI

// MARK: - DebugInterfaceView
struct DebugInterfaceView: View {
    
    // MARK: Properties
    @ObservedObject private var dayCounter = DayCounter()
    @State private var isWheelShown = false

    // MARK: Body
    var body: some View {
        NavigationStack {
            VStack {
                Text(Consts.installationDayText + String(dayCounter.dayCount))
                    .font(.largeTitle)
                HStack {
                    NavigationLink(value: isWheelShown) {
                        BaseButton(
                            text: Consts.nextDayButtonText,
                            isDisabled: dayCounter.isExceedsDayCount
                        ) {
                            dayCounter.incrementDayCount()
                            isWheelShown = true
                        }
                    }
                    .navigationDestination(isPresented: $isWheelShown) {
                        PrizeWheelView()
                            .navigationBarBackButtonHidden(true)
                            .environmentObject(dayCounter)
                    }
                    
                    BaseButton(text: Consts.resetButtonText) {
                        dayCounter.reset()
                    }
                }
                .padding()
            }
        }
    }
}

// MARK: - Consts
private extension DebugInterfaceView {
    enum Consts {
        static let installationDayText = String(format: "%@ ", "День установки:")
        static let nextDayButtonText = "Начать следующий день"
        static let resetButtonText = "Сброс установки"
    }
}

// MARK: - Preview
#Preview {
    DebugInterfaceView()
}

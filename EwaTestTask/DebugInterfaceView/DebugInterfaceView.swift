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
    @ObservedObject var dayCounter = DayCounter()
    @State private var showWheel: Bool = false

    // MARK: Body
    var body: some View {
        NavigationStack {
            VStack {
                Text(Consts.installationDayText + String(dayCounter.dayCount))
                    .font(.largeTitle)
                    .padding()
                HStack {
                    BaseButton(
                        text: Consts.nextDayButtonText,
                        disabled: dayCounter.isExceedsDayCount
                    ) {
                        dayCounter.incrementDayCount()
                        showWheel = true
                    }
                    
                    BaseButton(text: Consts.resetButtonText) {
                        dayCounter.reset()
                    }
                }
                .padding()
                
                NavigationLink(value: showWheel) {
                    EmptyView()
                }
                .hidden()
                .navigationDestination(isPresented: $showWheel) {
                    PrizeWheelView()
                        .navigationBarBackButtonHidden(true)
                        .environmentObject(dayCounter)
                }
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

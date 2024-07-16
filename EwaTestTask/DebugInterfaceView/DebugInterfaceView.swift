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
                Text("День установки: \(dayCounter.dayCount)")
                    .font(.largeTitle)
                    .padding()
                
                HStack {
                    BaseButton(text: "Начать следующий день") {
                        dayCounter.incrementDayCount()
                        showWheel = true
                    }
                    .disabled(!(dayCounter.dayCount < 3))
                    
                    BaseButton(text: "Сброс установки") {
                        dayCounter.reset()
                    }
                }
                .padding()
                
                NavigationLink(value: showWheel) {
                    EmptyView()
                }
                .hidden()
                .navigationDestination(isPresented: $showWheel) {
                    PrizeWheelView(dayCount: dayCounter.dayCount)
                        .navigationBarBackButtonHidden(true)
                }
            }
        }
    }
}

// MARK: - Preview
#Preview {
    DebugInterfaceView()
}

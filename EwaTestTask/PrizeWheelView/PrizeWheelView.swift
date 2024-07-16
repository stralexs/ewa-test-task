//
//  PrizeWheelView.swift
//  EwaTestTask
//
//  Created by Alexander Sivko on 16.07.24.
//

import SwiftUI

// MARK: - PrizeWheelView
struct PrizeWheelView: View {
    
    // MARK: Properties
    @ObservedObject private var viewModel = PrizeWheelViewModel()
    @Environment(\.dismiss) var dismiss
    @State private var showAlert: Bool = false
    private let dayCount: Int
    
    // MARK: Initializer
    init(dayCount: Int) {
        self.dayCount = dayCount
    }

    // MARK: Body
    var body: some View {
        VStack {
            Text("Колесо с призами")
                .font(.title)
                .padding()

            Text(viewModel.currentPrize)
                .font(.system(size: 100))
                .padding()

            Button(action: {
                dismiss()
            }) {
                Text("Забрать подарок")
            }
            .padding()

            Button(action: {
                if dayCount == 3 {
                    showAlert = true
                } else {
                    dismiss()
                }
            }) {
                Text("Отказаться")
            }
            .padding()
        }
        .onAppear {
            viewModel.updateCurrentPrize(dayCount: dayCount)
        }
        .alert(isPresented: $showAlert) {
            Alert(
                title: Text("Отказаться от подарка навсегда?"),
                primaryButton: .destructive(Text("Да")) {
                    dismiss()
                },
                secondaryButton: .cancel()
            )
        }
    }
}

// MARK: - Preview
#Preview {
    PrizeWheelView(dayCount: 1)
}

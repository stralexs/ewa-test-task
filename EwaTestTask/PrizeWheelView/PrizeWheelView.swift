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
    @State private var showAlert = false
    @State private var rotation = 0.0
    @State private var isSpinning = true
    @State private var isTappedToSpin = false
    private let dayCount: Int
    
    // MARK: Initializer
    init(dayCount: Int) {
        self.dayCount = dayCount
    }

    // MARK: Body
    var body: some View {
        VStack {
            wheel

            ZStack {
                spinTheWheelButton
                    .opacity(isTappedToSpin ? .zero : 1)
                
                VStack {
                    BaseButton(text: Consts.Texts.reclaimPrizeButtonText) {
                        dismiss()
                        viewModel.reclaimPrize()
                    }
                    .opacity(isSpinning ? .zero : 1)
                    
                    BaseButton(text: Consts.Texts.refuseButtonText) {
                        if dayCount == 3 { // TODO: OBSERVED OBJECT
                            showAlert = true
                        } else {
                            viewModel.discardPrize()
                            dismiss()
                        }
                    }
                    .opacity(isSpinning ? .zero : 1)
                }
            }
        }
        .alert(isPresented: $showAlert) {
            Alert(
                title: Text(Consts.Texts.alertTitleText),
                primaryButton: .destructive(Text(Consts.Texts.yesButtonText)) {
                    viewModel.discardPrize()
                    dismiss()
                },
                secondaryButton: .cancel(Text(Consts.Texts.cancelButtonText))
            )
        }
    }
}

// MARK: - Components
private extension PrizeWheelView {
    var wheel: some View {
        VStack {
            PrizeWheel(prizes: viewModel.prizes)
                .frame(width: Consts.Layouts.prizeWheelWidth, height: Consts.Layouts.prizeWheelWidth)
                .rotationEffect(.degrees(rotation))
                .animation(.easeOut(duration: isSpinning ? Consts.Numbers.spinningAnimationDuration : .zero),
                           value: rotation)
            
            Triangle()
                .fill(Color.black)
                .frame(width: Consts.Layouts.triangleWidth, height: Consts.Layouts.triangleHeight)
                .offset(y: Consts.Layouts.triangleOffset)
        }
    }
    
    var spinTheWheelButton: some View {
        Button(action: {
            withAnimation {
                startSpinning()
            }
        }) {
            Image(Consts.Texts.imageName)
                .resizable()
                .scaledToFill()
                .frame(width: Consts.Layouts.spinTheWheelButtonImageWidth,
                       height: Consts.Layouts.spinTheWheelButtonImageHeight)
                .clipShape(RoundedRectangle(cornerRadius: Consts.Layouts.spinTheWheelButtonImageCornerRadius))
        }
    }
}

// MARK: - Private
private extension PrizeWheelView {
    func startSpinning() {
        isTappedToSpin = true
        isSpinning = true
        let fullRotations = Consts.Numbers.fullWhellRotations
        let prizeRotation = Consts.Numbers.fullCircleDegree / Double(viewModel.prizes.count)
        let targetRotation = prizeRotation * Double(viewModel.providePrizeIndex(for: dayCount)) + prizeRotation / 2
        rotation = fullRotations * Consts.Numbers.fullCircleDegree + targetRotation
        DispatchQueue.main.asyncAfter(deadline: .now() + Consts.Numbers.spinningAnimationDuration) {
            withAnimation {
                isSpinning = false
            }
        }
    }
}

// MARK: - Consts
private extension PrizeWheelView {
    enum Consts {
        enum Texts {
            static let reclaimPrizeButtonText = "Забрать подарок"
            static let refuseButtonText = "Отказаться"
            static let alertTitleText = "Отказаться от подарка навсегда?"
            static let yesButtonText = "Да"
            static let cancelButtonText = "Отмена"
            static let imageName = "baraban"
        }
        
        enum Layouts {
            static let prizeWheelWidth: CGFloat = 300
            static let spinTheWheelButtonImageWidth: CGFloat = 200
            static let spinTheWheelButtonImageHeight: CGFloat = 100
            static let spinTheWheelButtonImageCornerRadius: CGFloat = 10
            static let triangleWidth: CGFloat = 30
            static let triangleHeight: CGFloat = 50
            static let triangleOffset: CGFloat = -20
        }
        
        enum Numbers {
            static let spinningAnimationDuration: CGFloat = 4
            static let fullWhellRotations: Double = 3
            static let fullCircleDegree: Double = 360
        }
    }
}

// MARK: - Preview
#Preview {
    PrizeWheelView(dayCount: 1)
}

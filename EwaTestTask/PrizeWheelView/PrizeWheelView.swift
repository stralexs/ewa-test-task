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
    @ObservedObject private var viewModel = PrizeWheelViewModel(dataBaseManager: DataBaseManager())
    @EnvironmentObject private var dayCounter: DayCounter
    @Environment(\.dismiss) private var dismiss
    @State private var rotation: Double = .zero
    @State private var isSpinning = true
    @State private var isTappedToSpin = false
    @State private var isDiscardedTopPrize = false

    // MARK: Body
    var body: some View {
        VStack {
            prizesWheel
            ZStack {
                spinTheWheelButton
                    .opacity(isTappedToSpin ? .zero : 1)
                VStack(spacing: Consts.Layouts.buttonsStackSpacing) {
                    reclaimPrizeButton
                        .opacity(isSpinning ? .zero : 1)
                    
                    discardPrizeButton
                        .opacity(isSpinning ? .zero : 1)
                }
            }
        }
        .alert(isPresented: $isDiscardedTopPrize) {
            Alert(
                title: Text(Consts.Texts.alertTitleText),
                primaryButton: .destructive(Text(Consts.Texts.yesButtonText)) {
                    viewModel.discardPrize()
                    dismiss()
                },
                secondaryButton: .cancel(Text(Consts.Texts.cancelButtonText)) {
                    isDiscardedTopPrize = false
                }
            )
        }
    }
}

// MARK: - Components
private extension PrizeWheelView {
    var prizesWheel: some View {
        VStack {
            PrizeWheel(prizes: viewModel.prizes)
                .frame(width: Consts.Layouts.prizeWheelWidth, height: Consts.Layouts.prizeWheelWidth)
                .rotationEffect(.degrees(rotation))
                .animation(.easeOut(duration: isSpinning ? Consts.Numbers.spinningAnimationDuration : .zero),
                           value: rotation)
            
            Triangle()
                .fill(.black)
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
    
    var reclaimPrizeButton: some View {
        Button(action: {
            dismiss()
            viewModel.reclaimPrize()
        }) {
            ZStack {
                RoundedRectangle(cornerRadius: Consts.Layouts.reclaimPrizeRectangleCornerRadius)
                    .fill(.cyan)
                    .frame(
                        width: Consts.Layouts.reclaimPrizeRectangleWidth,
                        height: Consts.Layouts.reclaimPrizeRectangleHeight)
                VStack {
                    Text(viewModel.currentPrize.name)
                        .font(.system(size: Consts.Numbers.reclaimPrizeTextFontSize))
                    Text(Consts.Texts.reclaimPrizeButtonText)
                        .foregroundStyle(.white)
                        .multilineTextAlignment(.center)
                        .frame(width: Consts.Layouts.reclaimPrizeButtonTextFrame)
                }
            }
        }
    }
    
    var discardPrizeButton: some View {
        Button(Consts.Texts.refuseButtonText) {
            if dayCounter.isExceedsDayCount {
                isDiscardedTopPrize = true
            } else {
                viewModel.discardPrize()
                dismiss()
            }
        }
        .font(.subheadline)
        .foregroundStyle(.cyan)
    }
}

// MARK: - Private
private extension PrizeWheelView {
    func startSpinning() {
        isTappedToSpin = true
        isSpinning = true
        let prizeAngles = viewModel.prizes.map { $0.isRare ? Consts.Numbers.rareAngle : Consts.Numbers.commonAngle }
        let targetIndex = viewModel.provideSectorIndex(for: dayCounter.dayCount)
        let targetRotation = prizeAngles[..<targetIndex].reduce(0, +) + prizeAngles[targetIndex] / 2
        rotation = -(Consts.Numbers.fullWheelRotations * Consts.Numbers.fullCircleDegree + targetRotation)
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
            static let buttonsStackSpacing: CGFloat = 15
            static let reclaimPrizeButtonTextFrame: CGFloat = 90
            static let reclaimPrizeRectangleCornerRadius: CGFloat = 15
            static let reclaimPrizeRectangleWidth: CGFloat = 150
            static let reclaimPrizeRectangleHeight: CGFloat = 180
        }
        
        enum Numbers {
            static let spinningAnimationDuration: CGFloat = 4
            static let fullWheelRotations: Double = 3
            static let fullCircleDegree: Double = 360
            static let reclaimPrizeTextFontSize: CGFloat = 60
            static let commonAngle: Double = 80
            static let rareAngle: Double = 40
        }
    }
}

// MARK: - Preview
#Preview {
    PrizeWheelView()
        .environmentObject(DayCounter())
}

//
//  BaseButton.swift
//  EwaTestTask
//
//  Created by Alexander Sivko on 16.07.24.
//

import SwiftUI

// MARK: - BaseButton
struct BaseButton: View {
    
    // MARK: Properties
    private let text: String
    private let disabled: Bool
    private let action: () -> Void
    
    // MARK: Initializer
    init(text: String,
         disabled: Bool = false,
         action: @escaping () -> Void
    ) {
        self.text = text
        self.disabled = disabled
        self.action = action
    }
    
    // MARK: Body
    var body: some View {
        Button(action: {
            action()
        }) {
            ZStack {
                RoundedRectangle(cornerRadius: Consts.rectangleCornerRadius)
                    .fill(.cyan)
                    .frame(width: Consts.rectangleWidth, height: Consts.rectangleHeight)
                Text(text)
                    .foregroundStyle(.black)
                    .lineLimit(nil)
                    .multilineTextAlignment(.center)
                    .padding()
            }
        }
        .disabled(disabled)
        .opacity(disabled ? Consts.halfOpacity : Consts.fullOpacity)
    }
}

// MARK: - Consts
private extension BaseButton {
    enum Consts {
        static let rectangleCornerRadius: CGFloat = 10
        static let rectangleWidth: CGFloat = 160
        static let rectangleHeight: CGFloat = 60
        static let fullOpacity: CGFloat = 1
        static let halfOpacity: CGFloat = 0.5
    }
}

// MARK: - Preview
#Preview {
    BaseButton(text: "Test button", action: {})
}

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
                RoundedRectangle(cornerRadius: 10)
                    .fill(Color.cyan)
                    .frame(width: 180, height: 60)
                Text(text)
                    .foregroundStyle(.black)
                    .lineLimit(nil)
                    .multilineTextAlignment(.center)
                    .padding()
            }
        }
        .disabled(disabled)
        .opacity(disabled ? 0.5: 1)
    }
}

// MARK: - Preview
#Preview {
    BaseButton(text: "Test button", action: {})
}

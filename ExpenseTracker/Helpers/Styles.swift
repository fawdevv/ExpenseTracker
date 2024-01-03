//
//  Styles.swift
//  ExpenseTracker
//
//  Created by Fawaz Faiz on 2023-12-21.
//

import SwiftUI

// apply reusable styles throughout the app

struct MainBigButtonStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .fontWeight(.bold)
            .foregroundStyle(.white)
            .frame(maxWidth: .infinity)
            .padding(.vertical, 14)
            .background(appTint.gradient, in: .rect(cornerRadius: 12))
            .contentShape(.rect)
    }
}

// add to extention usage
extension View {
    func mainBigButtonStyle() -> some View {
        modifier(MainBigButtonStyle())
    }
}


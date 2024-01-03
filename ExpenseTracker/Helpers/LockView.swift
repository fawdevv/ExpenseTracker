//
//  LockView.swift
//  ExpenseTracker
//
//  Created by Fawaz Faiz on 2023-12-24.
//

import SwiftUI

struct LockView<Content: View>: View {
    var lockType: LockType
    var lockPin: String
    var isEnabled: Bool
    var lockWhenAppGoesBackground: Bool = true
    
    @ViewBuilder var content: Content
    var body: some View {
        Text("I will Implement it Later")
    }
    
    // Lock Type
    enum LockType: String {
        case biometric = "Bio Metric Auth"
        case number = "Custom Number Lock"
        case both = "First preference will be biometric, and if it's not available, it will go for number lock."
        }
}

#Preview {
    ContentView()
}

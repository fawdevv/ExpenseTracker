//
//  CustomFormSection.swift
//  ExpenseTracker
//
//  Created by Fawaz Faiz on 2023-12-24.
//

import SwiftUI

@ViewBuilder
func CustomSection(_ title: String, _ hint: String, value: Binding<String>) -> some View {
    VStack(alignment: .leading, spacing: 10, content: {
        Text(title)
            .font(.caption)
            .foregroundStyle(.gray)
            .hSpacing(.leading)
        
        TextField(hint, text: value)
            .padding(.horizontal, 15)
            .padding(.vertical, 12)
            .background(.background, in: .rect(cornerRadius: 10))
    })
}

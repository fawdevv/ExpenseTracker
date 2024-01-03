//
//  TintColor.swift
//  ExpenseTracker
//
//  Created by Fawaz Faiz on 2023-12-21.
//

import SwiftUI

struct TintColor: Identifiable {
    let id: UUID = .init()
    var color: String
    var value: Color
    
    static let defaultTints: [TintColor] = [
        .init(color: "Red", value: .red),
        .init(color: "Blue", value: .blue),
        .init(color: "Pink", value: .pink),
        .init(color: "Purple", value: .purple),
        .init(color: "Brown", value: .brown),
        .init(color: "Yellow", value: .yellow),
        .init(color: "Green", value: .green),
        .init(color: "Indigo", value: .indigo),
        .init(color: "Cyan", value: .cyan),
        .init(color: "Orange", value: .orange)
    ]
    
   
}


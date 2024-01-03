//
//  Transaction.swift
//  ExpenseTracker
//
//  Created by Fawaz Faiz on 2023-12-21.
//

import SwiftUI
import SwiftData

@Model
class Transaction {
    var title: String
    var remarks: String
    var amount: Double
    var dateadded: Date
    var category: String
    var tintColor: String
    
    init(title: String, remarks: String, amount: Double, dateadded: Date, category: Category, tintColor: TintColor) {
        self.title = title
        self.remarks = remarks
        self.amount = amount
        self.dateadded = dateadded
        self.category = category.rawValue
        self.tintColor = tintColor.color
    }
    
    /// Extracting Color Value from tintColor String
   // var tints: [TintColor] = TintColor.defaultTints
    var color: Color {
        return tints.first(where: { $0.color == tintColor })?.value ?? appTint
    }
    
    var tint: TintColor? {
        return tints.first(where: { $0.color == tintColor})
    }
    
    var rawCategory: Category? {
        return Category.allCases.first(where: { category == $0.rawValue })!
    }
    
}
 var tints: [TintColor] = TintColor.defaultTints
// Sample Transaction data for UI Building
//var sampleTransactions: [Transaction] = [
//    .init(title: "Magic Keyboard", remarks: "Apple Product", amount: 129 * 3.67, dateadded: .now, category: .expense, tintColor: tints.randomElement ()!),
//    .init(title: "Apple Music", remarks: "Subscription", amount: 10.99 * 3.67, dateadded: .now, category: .expense, tintColor: tints.randomElement ()!),
//    .init(title: "iCloud", remarks: "Subscription", amount: 0.99 * 3.67, dateadded: .now, category: .expense, tintColor: tints.randomElement ()!),
//    .init(title: "Payment", remarks: "Payment Received!", amount: 2499 * 3.67, dateadded: .now, category: .income, tintColor: tints.randomElement ()!),
//    .init(title: "Sound Bar", remarks: "Sony Home Theater System", amount: 167 * 3.67, dateadded: .now, category: .expense, tintColor: tints.randomElement ()!)]




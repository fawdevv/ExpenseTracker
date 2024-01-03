//
//  FilterTransactionView.swift
//  ExpenseTracker
//
//  Created by Fawaz Faiz on 2023-12-27.
//

import SwiftUI
import SwiftData

struct FilterTransactionView<Content: View>: View {
    var content: ([Transaction]) -> Content
    @Query(animation: .snappy) private var transactions: [Transaction]
    init(category: Category?, searchText: String, @ViewBuilder content: @escaping ([Transaction]) -> Content)  {
        
        // Custom Predicate
        let rawValue = category?.rawValue ?? ""
        let predicate = #Predicate<Transaction> { transaction in
            // searching from title or remarks
            return (transaction.title.localizedStandardContains(searchText) ||
                    transaction.remarks.localizedStandardContains(searchText)) && (rawValue.isEmpty ? true : transaction.category == rawValue)
//            So what will happen here is that when a category is passed, the transactions will be filtered to match the given category, Otherwise, it will return all the transactions
//            that contain the search text.
        }
        _transactions = Query(filter: predicate, sort: [
            SortDescriptor(\Transaction.dateadded)] , animation: .snappy)
        
        self.content = content
    }
    
    init(startDate: Date, endDate: Date, category: Category?, @ViewBuilder content: @escaping ([Transaction]) -> Content)  {
        
        // Custom Predicate
        let rawValue = category?.rawValue ?? ""
        let predicate = #Predicate<Transaction> { transaction in
    
            return transaction.dateadded >= startDate && transaction.dateadded <= endDate && (rawValue.isEmpty ? true : transaction.category == rawValue)

        }
        _transactions = Query(filter: predicate, sort: [
            SortDescriptor(\Transaction.dateadded)] , animation: .snappy)
        
        self.content = content
    }
    
    
    
    var body: some View {
        content(transactions)
    }
}



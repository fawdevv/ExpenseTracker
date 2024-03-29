//
//  GraphsView.swift
//  ExpenseTracker
//
//  Created by Fawaz Faiz on 2023-12-22.
//

import SwiftUI
import Charts
import SwiftData

struct GraphsView: View {
    /// View Properties
    @Query(animation: .snappy) private var transactions: [Transaction]
    @State private var chartGroups: [ChartGroup] = []
    var body: some View {
        NavigationStack{
            ScrollView(.vertical){
                LazyVStack(spacing: 10){
                    // Chart View
                  ChartView()
                        
                        .frame(height: 200)
                        .padding(10)
                        .padding(.top, 10)
                        .background(.background, in: .rect(cornerRadius: 10))
                }
                .padding(15)
            }
            .navigationTitle("Graphs")
            .background(.gray.opacity(0.15))
            .onAppear(){
                /// Creating Chart Group
                createChartGroup()
            }
        }
    }
    
    @ViewBuilder
    func ChartView() -> some View {
        Chart{
            ForEach(chartGroups) { group in
                ForEach(group.categories) { chart in
                    BarMark(
                    x: .value("Month", format(date: group.date, format: "MMM yy")),
                    y: .value(chart.category.rawValue, format(date: group.date, format: "MMM yy")),
                    width: 20
                    )
                    .position(by: .value("Category", chart.category.rawValue), axis: .horizontal)
                    .foregroundStyle(by: .value("Category", chart.category.rawValue))
                }
            }
        }
        /// Making Chart Scrollable
        .chartScrollableAxes(.horizontal)
        .chartXVisibleDomain(length: 4) // reducing gap between 2 bars
        /// Foreground Color
        .chartForegroundStyleScale(range: [Color.green.gradient, Color.red.gradient])
        
    }
    
    func createChartGroup() {
        Task.detached(priority: .high){
            let calendar = Calendar.current
            
            let groupedByDate = Dictionary(grouping: transactions) { transaction in
                let components = calendar.dateComponents([.month, .year], from: transaction.dateadded)
                
                return components
            }
            
            let sortedGroups = groupedByDate.sorted {
                let date1 = calendar.date(from: $0.key) ?? .init()
                let date2 = calendar.date(from: $1.key) ?? .init()
                
                return calendar.compare(date1, to: date2, toGranularity: .day) == .orderedDescending
            }
            
            let chartGroups = sortedGroups.compactMap { dict -> ChartGroup? in
                let date = calendar.date(from: dict.key) ?? .init()
                let income = dict.value.filter({ $0.category == Category.income.rawValue })
                let expense = dict.value.filter({ $0.category == Category.expense.rawValue })
                
                let incomeTotalValue = total(income, category: .income)
                let expenseTotalValue = total(expense, category: .expense)
                
                return .init(date: date,
                             categories: [
                                .init(totalValue: incomeTotalValue, category: .income),
                                .init(totalValue: expenseTotalValue, category: .expense)
                                
                             ],
                             totalIncome: incomeTotalValue,
                             totalExpense: expenseTotalValue)
            }
            
            /// UI must be updated on Main Thread
            await MainActor.run {
                self.chartGroups = chartGroups
            }
        }
        
       
      
    }
}

#Preview {
    GraphsView()
}

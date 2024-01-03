//
//  RecentsView.swift
//  ExpenseTracker
//
//  Created by Fawaz Faiz on 2023-12-22.
//

import SwiftUI
import SwiftData

struct RecentsView: View {
    @AppStorage("userName") private var userName: String = ""
    // View Prperties
//    @State private var startDate: Date = .now.startOfMonth
//    @State private var endDate: Date = .now.endOfMonth
    // set to last 90 days
    @State private var startDate: Date = Calendar.current.date(byAdding: .day, value: -90, to: .now)!
    @State private var endDate: Date = .now.endOfMonth
    @State private var selectedCategory: Category = .expense
    @State private var showFilterView = false
    
    // For Animation
    @Namespace private var animation
    
    // Swift Data Query
//    @Query(sort:[SortDescriptor(\Transaction.dateadded, order: .reverse)], animation: .snappy) private var transactions: [Transaction]
    var body: some View {
        GeometryReader{
            let size = $0.size
            
            NavigationStack{
                ScrollView(.vertical){
                    LazyVStack(spacing: 10, pinnedViews: [.sectionHeaders]) {
                        Section {
                            // Date Filter Button
                            
                            
                            
                            
                           //  Recent transaction List
                            
                            FilterTransactionView(startDate: startDate, endDate: endDate, category: nil) { transactions in
                                
                                Button(action: {
                                    showFilterView = true
                                }, label: {
                                    Text("\(format(date: startDate, format: "dd MMM yy")) to \(format(date: endDate, format: "dd MMM yy"))")
                                })
                                .padding(.all, 15)
                                .hSpacing(.center)
                                .background(){
                                    RoundedRectangle(cornerRadius: 15)
                                        .fill(.background)
                                }
                                
                                // Card View
                                CardView(income: total(transactions, category: .income), expense: total(transactions, category: .expense))
                                
                                
                                // Custom Segmented Controller
                                CustomSegmentedControl()
                                    .padding(.bottom, 10)
                                
                                ForEach(transactions.filter({ $0.category == selectedCategory.rawValue })){ transaction in
                                    NavigationLink(value: transaction){
                                  
                                        TransactionCardView(transaction: transaction, showsCategory: false)
                                        
                                    }
                                    .buttonStyle(.plain)
                                }
                                
                            }

                        } header: {
                            HeaderView(size)
                        }
                    }
                    .padding(15)
                    
                }
                .background(.gray.opacity(0.15))
                .blur(radius: showFilterView ? 5 : 0)
                .disabled(showFilterView)
                .navigationDestination(for: Transaction.self) { transaction in
                    
                    TransactionView(editTransaction: transaction)
                    
                }
            }
            .overlay {
              
                    if showFilterView {
                        DateFilterView(start: startDate, end: endDate, onSubmit: {
                            start, end in
                            startDate = start
                            endDate = end
                            showFilterView = false
                            
                        }, onClose: {
                            showFilterView = false
                        })
                        .transition(.move(edge: .leading))
                    }
                
            }
            .animation(.snappy, value: showFilterView)
        }
    }
    
    @ViewBuilder
    func HeaderView(_ size: CGSize) -> some View {
        HStack(spacing: 10){
            VStack(alignment: .leading, spacing: 5, content: {
                Text("Welcome!")
                    .font(.title.bold())
                
                if !userName.isEmpty {
                    Text(userName)
                        .font(.callout)
                        .foregroundStyle(.gray)
                }
            })
            .visualEffect { content, geometryProxy in
                content
                    .scaleEffect(headerScale(size, proxy: geometryProxy), anchor: .topLeading)
            }
            
            Spacer(minLength: 0)
            NavigationLink{
                TransactionView()
            } label: {
                Image(systemName: "plus")
                    .font(.title3)
                    .fontWeight(.semibold)
                    .foregroundStyle(.white)
                    .frame(width: 30, height: 30)
                    .background(appTint.gradient, in: .circle)
                    .contentShape(.circle)
            }
        }
        
       
       
//        .hSpacing(.leading)
//        .overlay(alignment: .trailing, content: {
//
//        })
        .padding(.bottom, userName.isEmpty ? 10 : 5)
        
        .background{
            VStack(spacing: 0){
                Rectangle()
                    .fill(.ultraThinMaterial)
                
                Divider()
                   
            }
            .visualEffect { content, geometryProxy in
                content
                    .opacity(headerBGOpacity(geometryProxy))
            }
            .padding(.horizontal, -15)
            .padding(.top, -(safeArea.top + 15))
        }
    }
    
    // Custom Segmented Controller
    @ViewBuilder
    func CustomSegmentedControl() -> some View {
        HStack(spacing: 0){
            ForEach(Category.allCases, id: \.rawValue) { category in
                Text(category.rawValue)
                    .hSpacing()
                    .padding(.vertical, 10)
                    .background(){
                        if category == selectedCategory {
                            Capsule()
                                .fill(.background)
                                .matchedGeometryEffect(id: "ACTIVETAB", in: animation)
                        }
                    }
                    .contentShape(.capsule)
                    .onTapGesture {
                        withAnimation(.snappy) {
                            selectedCategory = category
                        }
                    }
            }
        }
        .background(.gray.opacity(0.15), in: .capsule)
        .padding(.top, 10)
    }
        
    // make header view transparent
    func headerBGOpacity(_ proxy: GeometryProxy) -> CGFloat{
        let minY = proxy.frame(in: .scrollView).minY + safeArea.top
        
        return minY > 0 ? 0 : (-minY / 15)
    }
    
    func headerScale(_ size: CGSize, proxy: GeometryProxy) -> CGFloat {
        let minY = proxy.frame(in: .scrollView).minY
        let screenWeight = size.height
        
        let progress = minY / screenWeight
        let scale = (min(max(progress, 0), 1)) * 0.6
        return 1 + scale
    }

}

#Preview {
    ContentView()
}

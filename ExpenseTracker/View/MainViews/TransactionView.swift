//
//  NewExpenseView.swift
//  ExpenseTracker
//
//  Created by Fawaz Faiz on 2023-12-24.
//

import SwiftUI

struct TransactionView: View {
    // Env Properties
    @Environment(\.modelContext) private var context
    @Environment(\.dismiss) private var dismiss
    var editTransaction: Transaction?
    // View Properties
    @State private var title: String = ""
    @State private var remarks: String = ""
    @State private var amount: Double = .zero
    @State private var dateAdded: Date = .now
    @State private var slctdDate: Date = .now
    @State private var category: Category = .expense
    // Random Tint
    @State var tint: TintColor = tints.randomElement()!
    
    var body: some View {
        ScrollView(.vertical){
            VStack(spacing: 15){
                Text("Preview")
                    .font(.caption)
                    .foregroundStyle(.gray)
                    .hSpacing(.leading)
                
                // Preview Transaction CardView
                TransactionCardView(transaction: .init(
                    title: title.isEmpty ? "Title" : title,
                    remarks: remarks.isEmpty ? "Remarks" : remarks,
                    amount: amount,
                    dateadded: dateAdded,
                    category: .expense,
                    tintColor: tint
                ))
                
                CustomSection("Title", "Bill Payment", value: $title)
                
                CustomSection("Remarks","Electricity bill for the month", value: $remarks)
                
                // Amount and Category check box
                VStack(alignment: .leading, spacing: 10, content: {
                    Text("Amount & Category")
                        .font(.caption)
                        .foregroundStyle(.gray)
                        .hSpacing(.leading)
                    
    
                    HStack(spacing: 15){
                        HStack(spacing: 4, content: {
                            Text(currencySymbol)
                                .font(.callout.bold())
                            
                            TextField("0.0", value: $amount, formatter: numberFormatter)
                                .keyboardType(.decimalPad)

                        })
                                                    .padding(.horizontal, 15)
                            .padding(.vertical, 12)
                            .background(.background, in: .rect(cornerRadius: 10))
                            .frame(maxWidth: 130)
                            
                          
                          
                        // Custom Category Check box
                        
                        CategoryCheckBox()
                    }
                })
                
                
                
                // Date Picker
                VStack(alignment: .leading, spacing: 10, content: {
                    Text("Date")
                        .font(.caption)
                        .foregroundStyle(.gray)
                        .hSpacing(.leading)
                    
                    DatePicker("", selection: $dateAdded, displayedComponents: [.date])
                        .datePickerStyle(.wheel)
                        .padding(.horizontal, 15)
                        .padding(.vertical, 12)
                        .background(.background, in: .rect(cornerRadius: 10))
                        

//                    DatePicker("Start Date", selection: $dateAdded, displayedComponents: [.date])
//                        .zIndex(1)
                })
                    
              
            }
            .padding(15)
            .onTapGesture {
                hideKeyboard()
            }
        }
        
        .navigationTitle("\(editTransaction == nil ? "Add" : "Edit") Transaction")
        .background(.gray.opacity(0.15))
        .toolbar(content: {
            ToolbarItem(placement: .topBarTrailing){
                Button("Save", action: { save() })
            }
            
        })
        .onAppear(perform: {
            // Load all the data if it's going to edit
            if let editTransaction {
                title = editTransaction.title
                remarks = editTransaction.remarks
                dateAdded = editTransaction.dateadded
                if let category = editTransaction.rawCategory {
                    self.category = category
                }
                amount = editTransaction.amount
                if let tint = editTransaction.tint {
                    self.tint = tint
                }
            }
        })
      //  .tint(appTint)
        
    }
    
    // Saving Data
    func save(){
        
        if editTransaction != nil {
           // Saving to Swift Data for the edited
            editTransaction?.title = title
            editTransaction?.remarks = remarks
            editTransaction?.amount = amount
            editTransaction?.category = category.rawValue
            editTransaction?.dateadded = dateAdded
        } else {
            let transaction = Transaction(title: title, remarks: remarks, amount: amount, dateadded: dateAdded, category: category, tintColor: tint)
            context.insert(transaction)
          
        }
        dismiss()
    }
    
    @ViewBuilder
    func CategoryCheckBox() -> some View {
        HStack(spacing: 10){
            ForEach(Category.allCases, id: \.rawValue) { category in
                HStack(spacing: 5){
                    ZStack{
                        Image(systemName: "circle")
                            .font(.title3)
                            .foregroundColor(appTint)
                        
                        if self.category == category {
                            Image(systemName: "circle.fill")
                                .font(.caption)
                                .foregroundColor(appTint)
                        }
                    }
                    Text(category.rawValue)
                        .font(.caption)
                    
                }
                .contentShape(.rect)
                .onTapGesture {
                    self.category = category
                }
                
            }
        }
        .padding(.horizontal, 15)
        .padding(.vertical, 12)
        .hSpacing(.leading)
        .background(.background, in: .rect(cornerRadius: 10))
    }
    
    // Number formatter using for the input of amounts in the form
    var numberFormatter: NumberFormatter{
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.maximumFractionDigits = 2
        
        return formatter
    }
    
    private func hideKeyboard() {
            UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
        }
}

#Preview {
    NavigationStack{
        TransactionView()
    }
}

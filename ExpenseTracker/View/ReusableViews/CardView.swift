//
//  CardView.swift
//  ExpenseTracker
//
//  Created by Fawaz Faiz on 2023-12-22.
//

import SwiftUI

struct CardView: View {
    var income: Double
    var expense: Double
    var body: some View {
        ZStack{
            RoundedRectangle(cornerRadius: 15)
                .fill(.background)
            
            VStack(spacing: 0){
                
                HStack(spacing: 12){
                    
                    Text("\(currencyString(income - expense))")
                        .font(.title.bold())
                    
                    Image(systemName: expense > income ? "chart.line.downtrend.xyaxis" : "chart.line.uptrend.xyaxis")
                        .font(.title3)
                        .foregroundStyle(expense > income ? Color.red.gradient : Color.green.gradient)
                }
                .padding(.bottom, 25)
                
                HStack(spacing: 0){
                    
                    ForEach(Category.allCases, id: \.rawValue) { category in
//                        let symbolImage = category == .income ? "arrow.down" : "arrow.up"
                        let symbolImage = category == .income ? "digitalcrown.arrow.counterclockwise" : "digitalcrown.arrow.clockwise"
                        //digitalcrown.arrow.clockwise
                        let tint = category == .income ? Color.green.gradient : Color.red.gradient
                        
                        HStack(spacing: 10){
                            Image(systemName: symbolImage)
                                .font(.callout.bold())
                                .foregroundStyle(tint)
                                .frame(width: 35, height: 35)
                                .background{
                                    Circle()
                                        .fill(tint.opacity(0.25))
                                }
                            VStack(alignment: .leading, spacing: 4){
                                Text(category.rawValue)
                                    .font(.caption2)
                                    .foregroundStyle(.gray)
                                
                                Text(currencyString(category == .income ? income : expense, allowedDigits: 0))
                                    .font(.callout)
                                    .fontWeight(.semibold)
                                    .foregroundStyle(.primary)
                            }
                            
                            if category == .income {
                                Spacer(minLength: 10)
                            }
                        }
                    }
                }
            }
            .padding([.horizontal, .bottom], 25)
            .padding(.top, 15)
            
        }
    }
}

#Preview {
    CardView(income: 22000, expense: 2200)
}

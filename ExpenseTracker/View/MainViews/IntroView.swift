//
//  IntroView.swift
//  ExpenseTracker
//
//  Created by Fawaz Faiz on 2023-12-21.
//

import SwiftUI

struct IntroView: View {
    // Vidibilty Status
    @AppStorage("isFirstTime") private var isFirstTime: Bool = true
    var body: some View {
        VStack(spacing: 15){
            Text("What's New in the\n Expense Tracker")
                .font(.largeTitle.bold())
                .multilineTextAlignment(.center)
                .padding(.top, 65)
                .padding(.bottom, 35)
            
            // PointsView
            VStack(alignment: .leading, spacing: 25, content: {
                PointsView(symbol: "dollarsign", title: "Transactions", subTitle: "Keep track of your earnings and expenses")
                
                PointsView(symbol: "chart.bar.fill", title: "Visual Charts", subTitle: "View your transactions using eye-catching graphic representations")
                
                PointsView(symbol: "magnifyingglass", title: "Advance Filters", subTitle: "Find the expenses you want by advance search and filtering.")
            })
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.horizontal, 25)
            
            Spacer(minLength: 10)
            
            Button(action: {
                isFirstTime = false
            }, label: {
                Text("Continue")
            })
            .mainBigButtonStyle()
        }
        .padding(15)
    }
}

#Preview {
    IntroView()
}

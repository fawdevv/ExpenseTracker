//
//  PointsView.swift
//  ExpenseTracker
//
//  Created by Fawaz Faiz on 2023-12-21.
//

import SwiftUI

@ViewBuilder
func PointsView(symbol: String, title: String, subTitle: String) -> some View {
    HStack(alignment: .center, spacing: 20){
        Image(systemName: symbol)
            .font(.title)
            .foregroundStyle(appTint.gradient)
        
        VStack(alignment: .leading, spacing: 3, content: {
            Text(title)
                .font(.title)
                .fontWeight(.semibold)
            
            Text(subTitle)
                .foregroundStyle(.gray)
        })
    }
}



//
//  ContentView.swift
//  ExpenseTracker
//
//  Created by Fawaz Faiz on 2023-12-21.
//

import SwiftUI

struct ContentView: View {
    // Intro Visibilty Status
    @AppStorage("isFirstTime") private var isFirstTime: Bool = true
    // Active tabs
    @State private var activeTab: Tab = .recents
    var body: some View {
        TabView(selection: $activeTab){
            RecentsView()
                .tag(Tab.recents)
                .tabItem { Tab.recents.tabContent }
            
            SearchView()
                .tag(Tab.search)
                .tabItem { Tab.search.tabContent }
            
            GraphsView()
                .tag(Tab.charts)
                .tabItem { Tab.charts.tabContent }
            
            SettingsView()
                .tag(Tab.settings)
                .tabItem { Tab.settings.tabContent }
        }
        .tint(appTint)
        .sheet(isPresented: $isFirstTime, content: {
            IntroView()
                .interactiveDismissDisabled()
        })
    }
}

#Preview {
    ContentView()
}

//
//  SettingsView.swift
//  ExpenseTracker
//
//  Created by Fawaz Faiz on 2023-12-22.
//

import SwiftUI

struct SettingsView: View {
    // User Properties
    @AppStorage("userName") private var userName: String = ""
    // App Lock Properties
    @AppStorage("isAppLockEnabled") private var isAppLockEnabled: Bool = false
    @AppStorage("lockWhenAppGoesBackground") private var lockWhenAppGoesBackground: Bool = false
    
    var body: some View {
        NavigationStack{
            List{
                Section("User Name"){
                    TextField("Fawaz Faiz", text: $userName)
                }
                
                Section("App Lock"){
                    Toggle("Enable App Lock", isOn: $isAppLockEnabled)
                    
                    if isAppLockEnabled{
                        Toggle("Lock When App Goes BackGround", isOn: $lockWhenAppGoesBackground)
                    }
                }
            }
            .navigationTitle("Settings")
        }
    }
}

#Preview {
    ContentView()
}

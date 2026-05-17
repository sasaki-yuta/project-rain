//
//  GearTabView.swift
//  TASTingNote
//
//  Created by 佐々木 勇太 on 2026/05/10.
//

import SwiftUI

struct SettingsTabView: View {
    @AppStorage("userName") private var userName = ""
    
    var body: some View {
        VStack {
            NavigationView {
                Form {
                    Section(header: Text("ユーザー設定")) {
                        TextField("ユーザー名", text: $userName)
                    }
                }
                .navigationTitle("Settings")
            }
        }
    }
}

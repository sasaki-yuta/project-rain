//
//  ContentView.swift
//  TASTingNote
//
//  Created by 佐々木 勇太 on 2026/05/09.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
    @State var selectTag = 1

    var body: some View {
        TabView(selection: $selectTag) {
            HomeTabView()
                .tabItem {
                    Label("HOME", systemImage: "house")
                }
            StarTabView()
                .tabItem {
                    Label("お気に入り", systemImage: "star")
                }
            MapTabView()
                .tabItem {
                    Label("地図", systemImage: "map")
                }
            AITabView()
                .tabItem {
                    Label("AI", systemImage: "brain")
                }

            GearTabView()
                .tabItem {
                    Label("設定", systemImage: "gear")
                }
        }
    }
}

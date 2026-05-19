//
//  HomeTabView.swift
//  TASTingNote
//
//  Created by 佐々木 勇太 on 2026/05/10.
//

import SwiftUI
import SwiftData

struct HomeTabView: View {
    @State private var searchText = ""
    // 保存されたユーザー名を取得
    @AppStorage("userName") private var userName = "ゲスト"
    
    var body: some View {
        VStack {
            NavigationView {
                List {
                    Section(header: Text("テイスティングリスト")) {
                        NavigationLink(destination: WhiteWineTastingListView()) {
                            Text("白")
                        }
                        NavigationLink(destination: RedWineTastingListView()) {
                            Text("赤")
                        }
                        NavigationLink(destination: SparklingWineTastingListView()) {
                            Text("スパークリング")
                        }
                    }
                    Section(header: Text("ワインデータベース")) {
                        Button("赤") {
                            
                        }
                        Button("白") {
                            /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Action@*/ /*@END_MENU_TOKEN@*/
                        }
                        Button("スパークリング") {
                            /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Action@*/ /*@END_MENU_TOKEN@*/
                        }
                    }

                }
                .searchable(text: $searchText, prompt: "ワインの検索")
                .keyboardType(.default)
                .navigationBarTitle(userName.isEmpty ? "ゲスト" : userName)
            }
        }
    }
}

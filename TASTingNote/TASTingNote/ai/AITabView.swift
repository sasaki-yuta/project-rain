//
//  AITabView.swift
//  TASTingNote
//
//  Created by 佐々木 勇太 on 2026/05/10.
//


import SwiftUI

struct AITabView: View {
    var body: some View {
        VStack {
            NavigationView {
                ScrollView {
                    Text("チャッピーをプログラムから実行するためのAPI使用するのは有料で、都度データ量に応じて登録したクレジットに課金されるので、一般公開するのには使用できませんでした...祭子さん、ごめんなさい....")
                        .padding()
                }
                .navigationTitle("AI")
            }
        }
    }
}

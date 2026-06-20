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
    
    // ワインの検索
    enum WineKind {
        case white
        case red
    }

    struct AnyWine: Identifiable {
        let id: String
        let name: String
        let date: Date
        let imageData: Data?
        let kind: WineKind
    }

    @Environment(\.modelContext) private var context
    @Query(sort: \Wine.tastingDate, order: .reverse)
    private var whiteWines: [Wine]

    @Query(sort: \redWine.tastingDate, order: .reverse)
    private var redWines: [redWine]
    
    private var allWines: [AnyWine] {
        let whites = whiteWines.map {
            AnyWine(
                id: "white-\($0.persistentModelID)",
                name: $0.name,
                date: $0.tastingDate,
                imageData: $0.imageData,
                kind: .white
            )
        }

        let reds = redWines.map {
            AnyWine(
                id: "red-\($0.persistentModelID)",
                name: $0.name,
                date: $0.tastingDate,
                imageData: $0.imageData,
                kind: .red
            )
        }

        return (whites + reds)
            .sorted { $0.date > $1.date }
    }
    
    private var filteredWines: [AnyWine] {
        if searchText.isEmpty {
            return allWines
        }

        return allWines.filter {
            $0.name.localizedCaseInsensitiveContains(searchText)
        }
    }
    
    private func fetchWhiteWine(id: String) -> Wine? {
        let descriptor = FetchDescriptor<Wine>()
        let wines = (try? context.fetch(descriptor)) ?? []

        return wines.first {
            "white-\($0.persistentModelID)" == id
        }
    }
    
    private func fetchRedWine(id: String) -> redWine? {
        let descriptor = FetchDescriptor<redWine>()
        let wines = (try? context.fetch(descriptor)) ?? []

        return wines.first {
            "red-\($0.persistentModelID)" == id
        }
    }
    
    
    var body: some View {
        NavigationView {
            VStack {

                // 🔽 検索バー
                List {
                    if searchText.isEmpty {

                        // ======================
                        // 通常UI（白・赤ボタン）
                        // ======================
                        Section(header: Text("テイスティングリスト")) {

                            NavigationLink {
                                WhiteWineTastingListView()
                            } label: {
                                Text("白ワイン")
                            }

                            NavigationLink {
                                RedWineTastingListView()
                            } label: {
                                Text("赤ワイン")
                            }
                        }

                    } else {

                        // ======================
                        // 検索UI（横断一覧）
                        // ======================
                        ForEach(filteredWines) { wine in
                            NavigationLink {
                                WineTastingSheetView(wine: wine, context: context)
                            } label: {
                                HStack {
                                    if let data = wine.imageData,
                                       let uiImage = UIImage(data: data) {
                                        Image(uiImage: uiImage)
                                            .resizable()
                                            .scaledToFill()
                                            .frame(width: 60, height: 60)
                                            .clipShape(RoundedRectangle(cornerRadius: 8))
                                    }

                                    VStack(alignment: .leading) {
                                        Text(wine.name)

                                        Text(wine.kind == .white ? "白ワイン" : "赤ワイン")
                                            .font(.caption)
                                            .foregroundColor(wine.kind == .white ? .green : .red)
                                    }
                                }
                            }
                        }
                    }
                }
                .searchable(text: $searchText, prompt: "ワインの検索")
                .navigationBarTitle(userName.isEmpty ? "ゲスト" : userName)
            }
        }
    }
}

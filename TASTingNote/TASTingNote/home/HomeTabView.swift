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
        case sparkling
        case rose
        case orange
        case fortified
        case dessert
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
    
    @Query(sort: \spWine.tastingDate, order: .reverse)
    private var spWines: [spWine]
    
    @Query(sort: \roseWine.tastingDate, order: .reverse)
    private var roseWines: [roseWine]
    
    @Query(sort: \orangeWine.tastingDate, order: .reverse)
    private var orangeWines: [orangeWine]
    
    @Query(sort: \fortifiedWine.tastingDate, order: .reverse)
    private var fortifiedWines: [fortifiedWine]
    
    @Query(sort: \dessertWine.tastingDate, order: .reverse)
    private var dessertWines: [dessertWine]
    
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
        
        let sps = spWines.map {
            AnyWine(
                id: "sparkling-\($0.persistentModelID)",
                name: $0.name,
                date: $0.tastingDate,
                imageData: $0.imageData,
                kind: .sparkling
            )
        }
        
        let roses = roseWines.map {
            AnyWine(
                id: "rose-\($0.persistentModelID)",
                name: $0.name,
                date: $0.tastingDate,
                imageData: $0.imageData,
                kind: .rose
            )
        }
        
        let oranges = orangeWines.map {
            AnyWine(
                id: "orange-\($0.persistentModelID)",
                name: $0.name,
                date: $0.tastingDate,
                imageData: $0.imageData,
                kind: .orange
            )
        }
        
        let fortifieds = fortifiedWines.map {
            AnyWine(
                id: "fortified-\($0.persistentModelID)",
                name: $0.name,
                date: $0.tastingDate,
                imageData: $0.imageData,
                kind: .fortified
            )
        }
        
        let desserts = dessertWines.map {
            AnyWine(
                id: "dessert-\($0.persistentModelID)",
                name: $0.name,
                date: $0.tastingDate,
                imageData: $0.imageData,
                kind: .dessert
            )
        }
        
        return (
            whites +
            reds +
            sps +
            roses +
            oranges +
            fortifieds +
            desserts
        )
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
    
    private func fetchSparklingWine(id: String) -> spWine? {
        let descriptor = FetchDescriptor<spWine>()
        let wines = (try? context.fetch(descriptor)) ?? []

        return wines.first {
            "sparkling-\($0.persistentModelID)" == id
        }
    }
    
    private func fetchRoseWine(id: String) -> roseWine? {
        let descriptor = FetchDescriptor<roseWine>()
        let wines = (try? context.fetch(descriptor)) ?? []

        return wines.first {
            "rose-\($0.persistentModelID)" == id
        }
    }
    
    private func fetchOrangeWine(id: String) -> orangeWine? {
        let descriptor = FetchDescriptor<orangeWine>()
        let wines = (try? context.fetch(descriptor)) ?? []

        return wines.first {
            "orange-\($0.persistentModelID)" == id
        }
    }
    
    private func fetchFortifiedWine(id: String) -> fortifiedWine? {

        let descriptor = FetchDescriptor<fortifiedWine>()

        let wines = (try? context.fetch(descriptor)) ?? []

        return wines.first {
            "fortified-\($0.persistentModelID)" == id
        }
    }
    
    private func fetchDessertWine(id: String) -> dessertWine? {

        let descriptor = FetchDescriptor<dessertWine>()

        let wines = (try? context.fetch(descriptor)) ?? []

        return wines.first {
            "dessert-\($0.persistentModelID)" == id
        }
    }
    
    private func wineKindName(_ kind: WineKind) -> String {
        switch kind {
        case .white:
            return "白ワイン"
        case .red:
            return "赤ワイン"
        case .sparkling:
            return "スパークリングワイン"
        case .rose:
            return "ロゼワイン"
        case .orange:
            return "オレンジワイン"
        case .fortified:
            return "酒精強化ワイン"
        case .dessert:
            return "デザートワイン"
        }
    }

    private func wineKindColor(_ kind: WineKind) -> Color {
        switch kind {
        case .white:
            return .green
        case .red:
            return .red
        case .sparkling:
            return .orange
        case .rose:
            return .pink
        case .orange:
            return .brown
        case .fortified:
            return .purple
        case .dessert:
            return .yellow
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
                            
                            NavigationLink {
                                SparklingWineTastingListView()
                            } label: {
                                Text("スパークリングワイン")
                            }
                            
                            NavigationLink {
                                RoseWineTastingListView()
                            } label: {
                                Text("ロゼワイン")
                            }
                            
                            NavigationLink {
                                OrangeWineTastingListView()
                            } label: {
                                Text("オレンジワイン")
                            }
                            NavigationLink {
                                FortifiedWineTastingListView()
                            } label: {
                                Text("酒精強化ワイン")
                            }
                            NavigationLink {
                                DessertWineTastingListView()
                            } label: {
                                Text("デザートワイン")
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

                                        Text(wineKindName(wine.kind))
                                            .font(.caption)
                                            .foregroundStyle(wineKindColor(wine.kind))
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

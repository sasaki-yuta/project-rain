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
    @Environment(\.openURL) private var openURL

    @State var selectTag = 1
    @State private var showUpdateAlert = false

    // TastingApp の Apple ID
    private let appID = "6784903942"

    var body: some View {
        TabView(selection: $selectTag) {
            HomeTabView()
                .tabItem {
                    Label("HOME", systemImage: "house")
                }

            FavoritesTabView()
                .tabItem {
                    Label("お気に入り", systemImage: "star")
                }

            MapTabView()
                .tabItem {
                    Label("地図", systemImage: "map")
                }

            AITabView()
                .tabItem {
                    Label("チャート", systemImage: "chart.dots.scatter")
                }

            QuizCategoryView()
                .tabItem {
                    Label(
                        "学習",
                        systemImage: "graduationcap.fill"
                    )
                }

            SettingsTabView()
                .tabItem {
                    Label("設定", systemImage: "gear")
                }
        }
        .task {
            await checkAppVersion()
        }
        .alert(
            "新しいバージョンがあります",
            isPresented: $showUpdateAlert
        ) {
            Button("アップデート") {
                openAppStore()
            }

            Button("あとで", role: .cancel) {
            }
        } message: {
            Text("App Storeで最新版のTastingAppにアップデートできます。")
        }
    }

    // MARK: - Version Check

    private func checkAppVersion() async {

        guard let url = URL(
            string: "https://itunes.apple.com/lookup?id=\(appID)&country=jp"
        ) else {
            return
        }

        do {
            let (data, _) = try await URLSession.shared.data(from: url)

            let result = try JSONDecoder().decode(
                AppStoreLookupResponse.self,
                from: data
            )

            guard let appStoreVersion = result.results.first?.version else {
                return
            }

            guard let currentVersion =
                    Bundle.main.infoDictionary?["CFBundleShortVersionString"]
                    as? String else {
                return
            }

            if appStoreVersion.compare(
                currentVersion,
                options: .numeric
            ) == .orderedDescending {

                await MainActor.run {
                    showUpdateAlert = true
                }
            }

        } catch {
            print("Version check error:", error)
        }
    }

    // MARK: - Open App Store

    private func openAppStore() {

        guard let url = URL(
            string: "https://apps.apple.com/jp/app/id\(appID)"
        ) else {
            return
        }

        openURL(url)
    }
}


// MARK: - App Store API Model

private struct AppStoreLookupResponse: Codable {
    let results: [AppStoreApp]
}

private struct AppStoreApp: Codable {
    let version: String
}

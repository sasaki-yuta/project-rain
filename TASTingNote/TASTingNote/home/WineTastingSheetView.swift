//
//  WineTastingSheetView.swift
//  TASTingNote
//
//  Created by 佐々木 勇太 on 2026/06/20.
//
import SwiftUI
import SwiftData

struct WineTastingSheetView: View {

    let wine: HomeTabView.AnyWine
    let context: ModelContext

    var body: some View {
        switch wine.kind {
        case .white:
            if let model = fetchWhiteWine(id: wine.id) {
                WhiteWineTastingSheetView(wine: model)
            }

        case .red:
            if let model = fetchRedWine(id: wine.id) {
                RedWineTastingSheetView(wine: model)
            }
        }
    }

    // MARK: - Fetch

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
}

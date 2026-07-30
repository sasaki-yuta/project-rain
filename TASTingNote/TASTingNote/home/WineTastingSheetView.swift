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
        
        case .sparkling:
            if let model = fetchSparklingWine(id: wine.id) {
                SparklingWineTastingSheetView(wine: model)
            }
            
        case .rose:
            if let model = fetchRoseWine(id: wine.id) {
                RoseWineTastingSheetView(wine: model)
            }
            
        case .orange:
            if let model = fetchOrangeWine(id: wine.id) {
                OrangeWineTastingSheetView(wine: model)
            }
            
        case .fortified:
            if let model = fetchFortifiedWine(id: wine.id) {
                FortifiedWineTastingSheetView(wine: model)
            }
            
        case .dessert:
            if let model = fetchDessertWine(id: wine.id) {
                DessertWineTastingSheetView(wine: model)
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
}

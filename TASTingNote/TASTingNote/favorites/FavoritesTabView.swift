//
//  StarTabView.swift
//  TASTingNote
//
//  Created by 佐々木 勇太 on 2026/05/10.
//
import SwiftUI
import SwiftData

struct FavoritesTabView: View {

    @Query(
        filter: #Predicate<Wine> {
            $0.isFavorite == true
        },
        sort: \Wine.tastingDate,
        order: .reverse
    )
    private var favoriteWhiteWines: [Wine]

    @Query(
        filter: #Predicate<redWine> {
            $0.isFavorite == true
        },
        sort: \redWine.tastingDate,
        order: .reverse
    )
    private var favoriteRedWines: [redWine]
    
    @Query(
        filter: #Predicate<spWine> {
            $0.isFavorite == true
        },
        sort: \spWine.tastingDate,
        order: .reverse
    )
    private var favoriteSparklingWines: [spWine]
    
    @Query(
        filter: #Predicate<roseWine> {
            $0.isFavorite == true
        },
        sort: \roseWine.tastingDate,
        order: .reverse
    )
    private var favoriteRoseWines: [roseWine]
    
    @Query(
        filter: #Predicate<orangeWine> {
            $0.isFavorite == true
        },
        sort: \orangeWine.tastingDate,
        order: .reverse
    )
    private var favoriteOrangeWines: [orangeWine]
    
    @Query(
        filter: #Predicate<fortifiedWine> {
            $0.isFavorite == true
        },
        sort: \fortifiedWine.tastingDate,
        order: .reverse
    )
    private var favoriteFortifiedWines: [fortifiedWine]
    
    @Query(
        filter: #Predicate<dessertWine> {
            $0.isFavorite == true
        },
        sort: \dessertWine.tastingDate,
        order: .reverse
    )
    private var favoriteDessertWines: [dessertWine]
    
    enum FavoriteItem: Identifiable {

        case white(Wine)
        case red(redWine)
        case sparkling(spWine)
        case rose(roseWine)
        case orange(orangeWine)
        case fortified(fortifiedWine)
        case dessert(dessertWine)

        var id: String {

            switch self {

            case .white(let wine):
                return "white-\(wine.persistentModelID)"

            case .red(let wine):
                return "red-\(wine.persistentModelID)"
                
            case .sparkling(let wine):
                return "sparkling-\(wine.persistentModelID)"
                
            case .rose(let wine):
                return "rose-\(wine.persistentModelID)"

            case .orange(let wine):
                return "orange-\(wine.persistentModelID)"
                
            case .fortified(let wine):
                return "fortified-\(wine.persistentModelID)"
                
            case .dessert(let wine):
                return "dessert-\(wine.persistentModelID)"
            }
        }

        var tastingDate: Date {

            switch self {

            case .white(let wine):
                return wine.tastingDate

            case .red(let wine):
                return wine.tastingDate
                
            case .sparkling(let wine):
                return wine.tastingDate
                
            case .rose(let wine):
                return wine.tastingDate
                
            case .orange(let wine):
                return wine.tastingDate
                
            case .fortified(let wine):
                return wine.tastingDate
                
            case .dessert(let wine):
                return wine.tastingDate
            }
        }
    }

    private var allFavorites: [FavoriteItem] {

        (
            favoriteWhiteWines.map { FavoriteItem.white($0) } +
            favoriteRedWines.map { FavoriteItem.red($0) } +
            favoriteSparklingWines.map { FavoriteItem.sparkling($0) } +
            favoriteRoseWines.map { FavoriteItem.rose($0) } +
            favoriteOrangeWines.map { FavoriteItem.orange($0) } +
            favoriteFortifiedWines.map { FavoriteItem.fortified($0) } +
            favoriteDessertWines.map { FavoriteItem.dessert($0) }
        )
        .sorted {
            $0.tastingDate > $1.tastingDate
        }
    }

    var body: some View {

        NavigationStack {

            List(allFavorites) { item in

                switch item {
                    
                case .white(let wine):
                    
                    NavigationLink {
                        
                        WhiteWineTastingSheetView(wine: wine)
                        
                    } label: {
                        
                        FavoriteRow(
                            image: wine.image,
                            name: wine.name,
                            date: wine.tastingDate,
                            type: "白ワイン"
                        )
                    }
                    
                case .red(let wine):
                    
                    NavigationLink {
                        
                        RedWineTastingSheetView(wine: wine)
                        
                    } label: {
                        
                        FavoriteRow(
                            image: wine.image,
                            name: wine.name,
                            date: wine.tastingDate,
                            type: "赤ワイン"
                        )
                    }
                    
                case .sparkling(let wine):
                    
                    NavigationLink {
                        
                        SparklingWineTastingSheetView(wine: wine)
                        
                    } label: {
                        
                        FavoriteRow(
                            image: wine.image,
                            name: wine.name,
                            date: wine.tastingDate,
                            type: "スパークリングワイン"
                        )
                    }
                    
                case .rose(let wine):
                    
                    NavigationLink {
                        
                        RoseWineTastingSheetView(wine: wine)
                        
                    } label: {
                        
                        FavoriteRow(
                            image: wine.image,
                            name: wine.name,
                            date: wine.tastingDate,
                            type: "ロゼワイン"
                        )
                    }
                    
                case .orange(let wine):

                    NavigationLink {

                        OrangeWineTastingSheetView(wine: wine)

                    } label: {

                        FavoriteRow(
                            image: wine.image,
                            name: wine.name,
                            date: wine.tastingDate,
                            type: "オレンジワイン"
                        )
                    }
                    
                case .fortified(let wine):

                    NavigationLink {

                        FortifiedWineTastingSheetView(wine: wine)

                    } label: {

                        FavoriteRow(
                            image: wine.image,
                            name: wine.name,
                            date: wine.tastingDate,
                            type: "酒精強化ワイン"
                        )
                    }
                    
                case .dessert(let wine):

                    NavigationLink {

                        DessertWineTastingSheetView(wine: wine)

                    } label: {

                        FavoriteRow(
                            image: wine.image,
                            name: wine.name,
                            date: wine.tastingDate,
                            type: "デザートワイン"
                        )
                    }
                }
            }
            .navigationTitle("Favorites")
        }
    }
}

struct FavoriteRow: View {

    let image: UIImage?
    let name: String
    let date: Date
    let type: String

    var body: some View {

        HStack(spacing: 16) {

            if let image {

                Image(uiImage: image)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 80, height: 60)
                    .clipShape(RoundedRectangle(cornerRadius: 12))

            } else {

                RoundedRectangle(cornerRadius: 12)
                    .fill(.gray.opacity(0.15))
                    .frame(width: 80, height: 60)
                    .overlay {
                        Image(systemName: "wineglass")
                    }
            }

            VStack(alignment: .leading) {

                Text(name)
                    .font(.headline)

                Text(
                    date,
                    format: .dateTime.year().month().day()
                )
                .font(.caption)
                .foregroundStyle(.secondary)

                if type == "白ワイン" {

                    Text(type)
                        .font(.caption2)
                        .foregroundStyle(.green)

                } else if type == "赤ワイン" {

                    Text(type)
                        .font(.caption2)
                        .foregroundStyle(.red)

                } else if type == "スパークリングワイン" {
                    
                    Text(type)
                        .font(.caption2)
                        .foregroundStyle(.orange)

                } else if type == "ロゼワイン" {
                    
                    Text(type)
                        .font(.caption2)
                        .foregroundStyle(.pink)
                    
                } else if type == "オレンジワイン" {
                    
                    Text(type)
                        .font(.caption2)
                        .foregroundStyle(.brown)   // または Color.orange.opacity(0.8)
                } else if type == "酒精強化ワイン" {
                    
                    Text(type)
                        .font(.caption2)
                        .foregroundStyle(.purple)
                } else if type == "デザートワイン" {
                    
                    Text(type)
                        .font(.caption2)
                        .foregroundStyle(.yellow)
                }
            }
        }
        .padding(.vertical, 6)
    }
}

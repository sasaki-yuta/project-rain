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

    enum FavoriteItem: Identifiable {

        case white(Wine)
        case red(redWine)

        var id: String {

            switch self {

            case .white(let wine):
                return "white-\(wine.persistentModelID)"

            case .red(let wine):
                return "red-\(wine.persistentModelID)"
            }
        }

        var tastingDate: Date {

            switch self {

            case .white(let wine):
                return wine.tastingDate

            case .red(let wine):
                return wine.tastingDate
            }
        }
    }

    private var allFavorites: [FavoriteItem] {

        (
            favoriteWhiteWines.map { FavoriteItem.white($0) } +
            favoriteRedWines.map { FavoriteItem.red($0) }
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

                }
            }
        }
        .padding(.vertical, 6)
    }
}

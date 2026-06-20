//
//  WineListView.swift
//  TASTingNote
//
//  Created by 佐々木 勇太 on 2026/06/20.
//

import SwiftUI

struct WineListView: View {

    let wines: [MapWine]

    var body: some View {

        NavigationStack {

            List(wines) { wine in
                if let whiteWine = wine.whiteWine {

                    NavigationLink {
                        WhiteWineTastingSheetView(wine: whiteWine)

                    } label: {

                        rowView(for: wine)
                    }
                    .buttonStyle(.plain)

                } else if let redWine = wine.redWine {

                    NavigationLink {
                        RedWineTastingSheetView(wine: redWine)

                    } label: {

                        rowView(for: wine)
                    }
                    .buttonStyle(.plain)
                }
            }
            .navigationTitle("この場所のワイン")
        }
    }
    
    private func rowView(for wine: MapWine) -> some View {
        HStack {

            if let image = wine.image {

                Image(uiImage: image)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 50, height: 50)
                    .clipShape(Circle())
            }

            VStack(alignment: .leading) {

                Text(wine.name)

                Text(
                    wine.tastingDate,
                    format: .dateTime.year().month().day()
                )
                .font(.caption)
                .foregroundStyle(.secondary)

                if wine.whiteWine != nil {

                    Text("白ワイン")
                        .font(.caption2)
                        .foregroundStyle(.green)

                } else {

                    Text("赤ワイン")
                        .font(.caption2)
                        .foregroundStyle(.red)
                }
            }
        }
    }
}


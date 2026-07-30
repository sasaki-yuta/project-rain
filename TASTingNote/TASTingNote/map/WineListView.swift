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
                    
                } else if let sparklingWine = wine.sparklingWine {
                    
                    NavigationLink {

                        SparklingWineTastingSheetView(wine: sparklingWine)

                    } label: {

                        rowView(for: wine)
                    }
                    .buttonStyle(.plain)
                    
                } else if let roseWine = wine.roseWine {
                    
                    NavigationLink {

                        RoseWineTastingSheetView(wine: roseWine)

                    } label: {

                        rowView(for: wine)
                    }
                    .buttonStyle(.plain)
                } else if let orangeWine = wine.orangeWine {
                    
                    NavigationLink {

                        OrangeWineTastingSheetView(wine: orangeWine)

                    } label: {

                        rowView(for: wine)
                    }
                    .buttonStyle(.plain)
                } else if let fortifiedWine = wine.fortifiedWine {
                    
                    NavigationLink {

                        FortifiedWineTastingSheetView(wine: fortifiedWine)

                    } label: {

                        rowView(for: wine)
                    }
                    .buttonStyle(.plain)
                } else if let dessertWine = wine.dessertWine {
                    
                    NavigationLink {

                        DessertWineTastingSheetView(wine: dessertWine)

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

                } else if wine.redWine != nil {

                    Text("赤ワイン")
                        .font(.caption2)
                        .foregroundStyle(.red)

                } else if wine.sparklingWine != nil {

                    Text("スパークリングワイン")
                        .font(.caption2)
                        .foregroundStyle(.orange)
                    
                } else if wine.roseWine != nil {
                    
                    Text("ロゼワイン")
                        .font(.caption2)
                        .foregroundStyle(.pink)
                } else if wine.orangeWine != nil {
                    
                    Text("オレンジワイン")
                        .font(.caption2)
                        .foregroundStyle(.brown)
                } else if wine.fortifiedWine != nil {
                    
                    Text("酒精強化ワイン")
                        .font(.caption2)
                        .foregroundStyle(.purple)
                } else if wine.dessertWine != nil {
                    
                    Text("デザートワイン")
                        .font(.caption2)
                        .foregroundStyle(.purple)
                }
            }
        }
    }
}


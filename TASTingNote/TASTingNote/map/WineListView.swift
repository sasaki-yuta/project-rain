//
//  WineListView.swift
//  TASTingNote
//
//  Created by 佐々木 勇太 on 2026/06/20.
//

import SwiftUI

struct WineListView: View {

    let wines: [Wine]

    var body: some View {

        NavigationStack {

            List(wines) { wine in
                NavigationLink {
                    WhiteWineTastingSheetView(wine: wine)

                } label: {
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
                        }
                    }
                }
                .buttonStyle(.plain)
            }
            .navigationTitle("この場所のワイン")
        }
    }
}


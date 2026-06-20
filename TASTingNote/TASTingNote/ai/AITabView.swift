//
//  AITabView.swift
//  TASTingNote
//
//  Created by 佐々木 勇太 on 2026/05/10.
//
import SwiftUI
import SwiftData

struct AITabView: View {

    @Query(sort: \Wine.tastingDate, order: .reverse)
    private var whiteWines: [Wine]

    @Query(sort: \redWine.tastingDate, order: .reverse)
    private var redWines: [redWine]

    struct ChartPoint: Identifiable {
        let id = UUID()
        let x: Double
        let y: Double
        let isWhite: Bool
        let name: String
    }

    private var chartPoints: [ChartPoint] {

        let whites = whiteWines.compactMap { wine -> ChartPoint? in
            guard let x = wine.chartX,
                  let y = wine.chartY else { return nil }

            return ChartPoint(
                x: x,
                y: y,
                isWhite: true,
                name: wine.name
            )
        }

        let reds = redWines.compactMap { wine -> ChartPoint? in
            guard let x = wine.chartX,
                  let y = wine.chartY else { return nil }

            return ChartPoint(
                x: x,
                y: y,
                isWhite: false,
                name: wine.name
            )
        }

        return whites + reds
    }

    @State private var selectedName: String?

    var body: some View {
        NavigationStack {
            VStack {
                ZStack {

                    WineChartPickerView(
                        xValue: .constant(nil),
                        yValue: .constant(nil),
                        isLocked: true
                    )

                    GeometryReader { geo in

                        ForEach(chartPoints) { point in
                            Circle()
                                .fill(point.isWhite ? .green : .red)
                                .frame(width: 10, height: 10)
                                .position(
                                    x: geo.size.width * (point.x + 1) / 2,
                                    y: geo.size.height * (1 - (point.y + 1) / 2)
                                )
                                .onTapGesture {
                                    selectedName = point.name
                                }
                        }
                    }
                }
                .frame(height: 300)

                if let selectedName {
                    Text("選択中: \(selectedName)")
                        .font(.caption)
                        .foregroundStyle(.secondary)
                }
            }
            .padding()
            .navigationTitle("ワインチャート")
        }
    }
}

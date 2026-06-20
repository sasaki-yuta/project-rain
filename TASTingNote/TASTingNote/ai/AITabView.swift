//
//  AITabView.swift
//  TASTingNote
//
//  Created by 佐々木 勇太 on 2026/05/10.
//
import SwiftUI
import SwiftData

struct AITabView: View {

    @Environment(\.modelContext) private var context

    @Query(sort: \Wine.tastingDate, order: .reverse)
    private var whiteWines: [Wine]

    @Query(sort: \redWine.tastingDate, order: .reverse)
    private var redWines: [redWine]

    // ======================
    // チャート用モデル
    // ======================
    struct ChartPoint: Identifiable {
        let id: String
        let x: Double
        let y: Double
        let isWhite: Bool
        let imageData: Data?
    }

    @State private var selectedPoint: ChartPoint?

    // ======================
    // データ統合
    // ======================
    private var chartPoints: [ChartPoint] {

        let whites = whiteWines.compactMap { wine -> ChartPoint? in
            guard let x = wine.chartX,
                  let y = wine.chartY else { return nil }

            return ChartPoint(
                id: "white-\(wine.persistentModelID)",
                x: x,
                y: y,
                isWhite: true,
                imageData: wine.imageData
            )
        }

        let reds = redWines.compactMap { wine -> ChartPoint? in
            guard let x = wine.chartX,
                  let y = wine.chartY else { return nil }

            return ChartPoint(
                id: "red-\(wine.persistentModelID)",
                x: x,
                y: y,
                isWhite: false,
                imageData: wine.imageData
            )
        }

        return whites + reds
    }

    var body: some View {
        NavigationStack {

            VStack {

                // ======================
                // チャート
                // ======================
                ZStack {

                    WineChartPickerView(
                        xValue: .constant(nil),
                        yValue: .constant(nil),
                        isLocked: true
                    )

                    GeometryReader { geo in

                        ForEach(chartPoints) { point in

                            VStack {
                                if let data = point.imageData,
                                   let uiImage = UIImage(data: data) {

                                    Image(uiImage: uiImage)
                                        .resizable()
                                        .scaledToFill()
                                        .frame(width: 28, height: 28)
                                        .clipShape(Circle())
                                        .overlay(
                                            Circle()
                                                .stroke(point.isWhite ? .green : .red, lineWidth: 2)
                                        )

                                } else {
                                    Circle()
                                        .fill(point.isWhite ? .green : .red)
                                        .frame(width: 12, height: 12)
                                }
                            }
                            .position(
                                x: geo.size.width * (point.x + 1) / 2,
                                y: geo.size.height * (1 - (point.y + 1) / 2)
                            )
                            .onTapGesture {
                                selectedPoint = point
                            }
                        }
                    }
                }
                .frame(height: 300)

                Spacer()
            }
            .padding()
            .navigationTitle("ワインチャート")

            // ======================
            // ★ ここが修正ポイント（完全解決）
            // ======================
            .sheet(item: $selectedPoint) { point in
                WineDetailRouterView(point: point)
                    .environment(\.modelContext, context)
            }
        }
    }
}

struct WineDetailRouterView: View {

    let point: AITabView.ChartPoint
    @Environment(\.modelContext) private var context

    var body: some View {

        Group {
            if point.isWhite {
                if let wine = fetchWhite(id: point.id) {
                    WhiteWineTastingSheetView(wine: wine)
                }
            } else {
                if let wine = fetchRed(id: point.id) {
                    RedWineTastingSheetView(wine: wine)
                }
            }
        }
    }

    // ======================
    // fetch
    // ======================
    private func fetchWhite(id: String) -> Wine? {
        let wines = (try? context.fetch(FetchDescriptor<Wine>())) ?? []
        return wines.first { "white-\($0.persistentModelID)" == id }
    }

    private func fetchRed(id: String) -> redWine? {
        let wines = (try? context.fetch(FetchDescriptor<redWine>())) ?? []
        return wines.first { "red-\($0.persistentModelID)" == id }
    }
}

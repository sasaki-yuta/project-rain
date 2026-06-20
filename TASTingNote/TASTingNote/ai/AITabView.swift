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
        let wineName: String   // ★追加
    }

    // 重なり選択
    @State private var selectedPoints: [ChartPoint] = []

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
                imageData: wine.imageData,
                wineName: wine.name   // ★追加
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
                imageData: wine.imageData,
                wineName: wine.name   // ★追加
            )
        }

        return whites + reds
    }

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

                        // タップ検出
                        Color.clear
                            .contentShape(Rectangle())
                            .onTapGesture { location in

                                let tapped = chartPoints.filter { point in
                                    let px = geo.size.width * (point.x + 1) / 2
                                    let py = geo.size.height * (1 - (point.y + 1) / 2)

                                    let dx = px - location.x
                                    let dy = py - location.y

                                    return sqrt(dx*dx + dy*dy) < 20
                                }

                                selectedPoints = tapped
                            }

                        // 描画
                        ForEach(chartPoints) { point in

                            VStack(spacing: 2) {

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

                                // ★ワイン名追加
                                Text(point.wineName)
                                    .font(.caption2)
                                    .lineLimit(1)
                                    .padding(.horizontal, 4)
                                    .padding(.vertical, 2)
                                    .background(.ultraThinMaterial)
                                    .clipShape(Capsule())
                            }
                            .position(
                                x: geo.size.width * (point.x + 1) / 2,
                                y: geo.size.height * (1 - (point.y + 1) / 2)
                            )
                        }
                    }
                }
                .frame(height: 300)

                Spacer()
            }
            .padding()
            .navigationTitle("ワインチャート")

            // ======================
            // 重なり表示シート
            // ======================
            .sheet(isPresented: Binding(
                get: { !selectedPoints.isEmpty },
                set: { if !$0 { selectedPoints = [] } }
            )) {
                WineOverlapListView(points: selectedPoints)
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

struct WineOverlapListView: View {

    let points: [AITabView.ChartPoint]
    @Environment(\.modelContext) private var context

    var body: some View {
        NavigationStack {

            List(points) { point in

                NavigationLink {

                    // ★ここで詳細へ遷移
                    WineDetailRouterView(point: point)
                        .environment(\.modelContext, context)

                } label: {

                    HStack {

                        if let data = point.imageData,
                           let uiImage = UIImage(data: data) {
                            Image(uiImage: uiImage)
                                .resizable()
                                .frame(width: 44, height: 44)
                                .clipShape(Circle())
                        }

                        VStack(alignment: .leading) {

                            Text(point.wineName)
                                .font(.headline)

                            Text(point.isWhite ? "白ワイン" : "赤ワイン")
                                .font(.subheadline)
                                .foregroundStyle(point.isWhite ? .green : .red)

                            Text("X（辛甘）: \(String(format: "%.2f", point.x))  Y（重軽）: \(String(format: "%.2f", point.y))")
                                .font(.caption)
                                .foregroundStyle(.gray)
                        }
                    }
                    .padding(.vertical, 4)
                }
            }
            .navigationTitle("重なったワイン")
        }
    }
}

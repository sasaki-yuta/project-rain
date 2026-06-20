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

    // ======================
    // ChartPoint（固定オフセット付き）
    // ======================
    struct ChartPoint: Identifiable, Equatable {
        let id = UUID()
        let x: Double
        let y: Double
        let isWhite: Bool
        let name: String
        let imageData: Data?

        // ⭐ 固定オフセット（これが重要）
        let offsetX: Double
        let offsetY: Double
    }

    // ======================
    // データ生成（ここで完全固定化）
    // ======================
    private var chartPoints: [ChartPoint] {

        let whites = whiteWines.compactMap { wine -> ChartPoint? in
            guard let x = wine.chartX,
                  let y = wine.chartY else { return nil }

            let baseHash = wine.persistentModelID.hashValue

            return ChartPoint(
                x: x,
                y: y,
                isWhite: true,
                name: wine.name,
                imageData: wine.imageData,
                offsetX: Double((abs(baseHash) % 7) - 3) * 0.003,
                offsetY: Double((abs(baseHash) % 5) - 2) * 0.003
            )
        }

        let reds = redWines.compactMap { wine -> ChartPoint? in
            guard let x = wine.chartX,
                  let y = wine.chartY else { return nil }

            let baseHash = wine.persistentModelID.hashValue

            return ChartPoint(
                x: x,
                y: y,
                isWhite: false,
                name: wine.name,
                imageData: wine.imageData,
                offsetX: Double((abs(baseHash) % 7) - 3) * 0.003,
                offsetY: Double((abs(baseHash) % 5) - 2) * 0.003
            )
        }

        return whites + reds
    }

    @State private var selectedPoints: [ChartPoint] = []

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

                            VStack(spacing: 0) {

                                // ======================
                                // ピン表示
                                // ======================
                                if let data = point.imageData,
                                   let uiImage = UIImage(data: data) {

                                    Image(uiImage: uiImage)
                                        .resizable()
                                        .scaledToFill()
                                        .frame(width: 28, height: 28)
                                        .clipShape(Circle())
                                        .overlay(
                                            Circle()
                                                .stroke(point.isWhite ? .green : .red,
                                                        lineWidth: 2)
                                        )

                                } else {

                                    Circle()
                                        .fill(point.isWhite ? .green : .red)
                                        .frame(width: 12, height: 12)
                                }
                            }
                            .position(
                                x: screenX(point.x, geo, point.offsetX),
                                y: screenY(point.y, geo, point.offsetY)
                            )

                            // ======================
                            // タップ → クラスタ表示
                            // ======================
                            .onTapGesture {

                                let threshold = 0.08

                                selectedPoints = chartPoints.filter {
                                    abs($0.x - point.x) < threshold &&
                                    abs($0.y - point.y) < threshold
                                }
                            }
                        }
                    }
                }
                .frame(height: 300)

                // ======================
                // 凡例
                // ======================
                HStack(spacing: 20) {
                    HStack {
                        Image(systemName: "circle.fill")
                            .foregroundStyle(.green)
                        Text("白ワイン")
                    }

                    HStack {
                        Image(systemName: "circle.fill")
                            .foregroundStyle(.red)
                        Text("赤ワイン")
                    }
                }
                .font(.caption)

                // ======================
                // クラスタ表示
                // ======================
                if !selectedPoints.isEmpty {

                    VStack(alignment: .leading, spacing: 6) {

                        Text("このエリアのワイン")
                            .font(.caption.bold())
                            .foregroundStyle(.secondary)

                        ForEach(selectedPoints) { point in
                            HStack {
                                Circle()
                                    .fill(point.isWhite ? .green : .red)
                                    .frame(width: 8, height: 8)

                                Text(point.name)
                                    .font(.caption)
                            }
                        }
                    }
                    .padding(.top, 8)
                }
            }
            .padding()
            .navigationTitle("ワインチャート")
        }
    }

    // ======================
    // 座標変換（安定版）
    // ======================
    private func screenX(_ x: Double, _ geo: GeometryProxy, _ offset: Double) -> CGFloat {
        let normalized = (x + offset + 1) / 2
        return geo.size.width * CGFloat(normalized)
    }

    private func screenY(_ y: Double, _ geo: GeometryProxy, _ offset: Double) -> CGFloat {
        let normalized = 1 - ((y + offset + 1) / 2)
        return geo.size.height * CGFloat(normalized)
    }
}

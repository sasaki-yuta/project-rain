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
        let imageData: Data?
    }

    private var chartPoints: [ChartPoint] {

        let whites = whiteWines.compactMap { wine -> ChartPoint? in
            guard let x = wine.chartX,
                  let y = wine.chartY else { return nil }

            return ChartPoint(
                x: x,
                y: y,
                isWhite: true,
                name: wine.name,
                imageData: wine.imageData
            )
        }

        let reds = redWines.compactMap { wine -> ChartPoint? in
            guard let x = wine.chartX,
                  let y = wine.chartY else { return nil }

            return ChartPoint(
                x: x,
                y: y,
                isWhite: false,
                name: wine.name,
                imageData: wine.imageData
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

                            VStack(spacing: 0) {

                                // ======================
                                // ワイン画像ピン
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

                                    // 画像なしの場合フォールバック
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
                                selectedName = point.name
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
                // 選択表示
                // ======================
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

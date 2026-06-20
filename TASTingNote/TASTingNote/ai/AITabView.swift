//
//  AITabView.swift
//  TASTingNote
//
//  Created by 佐々木 勇太 on 2026/05/10.
//
import SwiftUI
import SwiftData
import Charts

struct WinePoint: Identifiable {
    let id = UUID()
    let x: Double
    let y: Double
    let type: WineType
}

enum WineType {
    case red
    case white
}

struct AITabView: View {

    @Query(sort: \redWine.tastingDate, order: .reverse)
    private var redWines: [redWine]

    @Query(sort: \Wine.tastingDate, order: .reverse)
    private var whiteWines: [Wine]

    @State private var chartImage: UIImage?

    var body: some View {
        NavigationView {
            VStack(spacing: 20) {

                // 生成されたチャート画像
                if let chartImage {
                    Image(uiImage: chartImage)
                        .resizable()
                        .scaledToFit()
                        .frame(maxWidth: .infinity)
                        .padding()
                } else {
                    Text("チャート未生成")
                        .foregroundColor(.secondary)
                }

                Button("チャートを生成") {
                    chartImage = renderChartImage()
                }
                .buttonStyle(.borderedProminent)

                Spacer()
            }
            .padding()
            .navigationTitle("統合ワインチャート")
        }
    }

    // MARK: - データ統合
    private func buildPoints() -> [WinePoint] {

        let reds: [WinePoint] = redWines.compactMap {
            guard let x = $0.chartX, let y = $0.chartY else { return nil }
            return WinePoint(x: x, y: y, type: .red)
        }

        let whites: [WinePoint] = whiteWines.compactMap {
            guard let x = $0.chartX, let y = $0.chartY else { return nil }
            return WinePoint(x: x, y: y, type: .white)
        }

        return reds + whites
    }

    // MARK: - チャート描画（SwiftUI Charts）
    private func chartView() -> some View {
        let points = buildPoints()

        return Chart(points) { point in
            PointMark(
                x: .value("X", point.x),
                y: .value("Y", point.y)
            )
            .foregroundStyle(point.type == .red ? .red : .yellow)
            .symbol(point.type == .red ? .circle : .square)
            .symbolSize(80)
        }
        .chartXAxisLabel("X")
        .chartYAxisLabel("Y")
        .frame(width: 600, height: 600)
        .padding()
    }

    // MARK: - 画像化
    private func renderChartImage() -> UIImage {

        let renderer = ImageRenderer(content: chartView())

        renderer.scale = UIScreen.main.scale

        return renderer.uiImage ?? UIImage()
    }
}

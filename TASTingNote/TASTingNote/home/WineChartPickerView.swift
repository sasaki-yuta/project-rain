//
//  WineChartPickerView.swift
//  TASTingNote
//
//  Created by 佐々木 勇太 on 2026/06/13.
//

import SwiftUI

struct WineChartPickerView: View {

    @Binding var xValue: Double?
    @Binding var yValue: Double?
    
    let isLocked: Bool

    var body: some View {

        GeometryReader { geo in

            ZStack {
                // 背景
                ZStack {
                    // 左上（甘口・重め）
                    Rectangle()
                        .fill(Color.red.opacity(0.15))
                        .frame(
                            width: geo.size.width / 2,
                            height: geo.size.height / 2
                        )
                        .position(
                            x: geo.size.width * 0.25,
                            y: geo.size.height * 0.25
                        )

                    // 右上（辛口・重め）
                    Rectangle()
                        .fill(Color.orange.opacity(0.15))
                        .frame(
                            width: geo.size.width / 2,
                            height: geo.size.height / 2
                        )
                        .position(
                            x: geo.size.width * 0.75,
                            y: geo.size.height * 0.25
                        )

                    // 左下（甘口・軽め）
                    Rectangle()
                        .fill(Color.blue.opacity(0.15))
                        .frame(
                            width: geo.size.width / 2,
                            height: geo.size.height / 2
                        )
                        .position(
                            x: geo.size.width * 0.25,
                            y: geo.size.height * 0.75
                        )

                    // 右下（辛口・軽め）
                    Rectangle()
                        .fill(Color.green.opacity(0.15))
                        .frame(
                            width: geo.size.width / 2,
                            height: geo.size.height / 2
                        )
                        .position(
                            x: geo.size.width * 0.75,
                            y: geo.size.height * 0.75
                        )

                    RoundedRectangle(cornerRadius: 16)
                        .stroke(Color.gray.opacity(0.3))
                }
                .clipShape(RoundedRectangle(cornerRadius: 16))
                
                Text("甘口\n重め")
                    .font(.caption2)
                    .foregroundStyle(.red)
                    .position(
                        x: geo.size.width * 0.25,
                        y: geo.size.height * 0.25
                    )

                Text("辛口\n重め")
                    .font(.caption2)
                    .foregroundStyle(.orange)
                    .position(
                        x: geo.size.width * 0.75,
                        y: geo.size.height * 0.25
                    )

                Text("甘口\n軽め")
                    .font(.caption2)
                    .foregroundStyle(.blue)
                    .position(
                        x: geo.size.width * 0.25,
                        y: geo.size.height * 0.75
                    )

                Text("辛口\n軽め")
                    .font(.caption2)
                    .foregroundStyle(.green)
                    .position(
                        x: geo.size.width * 0.75,
                        y: geo.size.height * 0.75
                    )

                // 上下ラベル
                Text("重め")
                    .font(.caption)
                    .foregroundStyle(.secondary)
                    .position(
                        x: geo.size.width / 2,
                        y: 12
                    )

                Text("軽め")
                    .font(.caption)
                    .foregroundStyle(.secondary)
                    .position(
                        x: geo.size.width / 2,
                        y: geo.size.height - 12
                    )
                
                // 横軸
                Path { path in
                    path.move(
                        to: CGPoint(
                            x: 0,
                            y: geo.size.height / 2
                        )
                    )

                    path.addLine(
                        to: CGPoint(
                            x: geo.size.width,
                            y: geo.size.height / 2
                        )
                    )
                }
                .stroke(.gray)

                // 縦軸
                Path { path in
                    path.move(
                        to: CGPoint(
                            x: geo.size.width / 2,
                            y: 0
                        )
                    )

                    path.addLine(
                        to: CGPoint(
                            x: geo.size.width / 2,
                            y: geo.size.height
                        )
                    )
                }
                .stroke(.gray)

                if let xValue,
                   let yValue {

                    Circle()
                        .fill(.red)
                        .frame(width: 24, height: 24)
                        .position(
                            x: geo.size.width * (xValue + 1) / 2,
                            y: geo.size.height * (1 - (yValue + 1) / 2)
                        )
                }
                
                if isLocked {
                    Image(systemName: "lock.fill")
                        .font(.title)
                        .foregroundStyle(.secondary)
                }
            }
            .contentShape(Rectangle())
            .allowsHitTesting(!isLocked)
            .gesture(
                isLocked
                ? nil
                : DragGesture(minimumDistance: 0)
                    .onChanged { value in

                        let x =
                        min(max(value.location.x, 0), geo.size.width)

                        let y =
                        min(max(value.location.y, 0), geo.size.height)

                        xValue =
                        (x / geo.size.width) * 2 - 1

                        yValue =
                        ((geo.size.height - y)
                         / geo.size.height) * 2 - 1
                    }
            )
        }
        .frame(height: 250)
    }
}


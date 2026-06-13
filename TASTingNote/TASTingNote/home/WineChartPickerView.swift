//
//  WineChartPickerView.swift
//  TASTingNote
//
//  Created by 佐々木 勇太 on 2026/06/13.
//

import SwiftUI

struct WineChartPickerView: View {

    @Binding var xValue: Double
    @Binding var yValue: Double
    
    let isLocked: Bool

    var body: some View {

        GeometryReader { geo in

            ZStack {

                // 背景
                RoundedRectangle(cornerRadius: 16)
                    .fill(Color.gray.opacity(0.05))

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

                Circle()
                    .fill(.red)
                    .frame(width: 24, height: 24)
                    .position(
                        x: geo.size.width * (xValue + 1) / 2,
                        y: geo.size.height * (1 - (yValue + 1) / 2)
                    )
                
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


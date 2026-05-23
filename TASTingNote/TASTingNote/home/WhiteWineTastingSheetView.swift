//
//  WhiteWineTastingSheetView.swift
//  TASTingNote
//
//  Created by 佐々木 勇太 on 2026/05/15.
//
import SwiftUI
import PhotosUI

struct WhiteWineTastingSheetView: View {

    @Bindable var wine: Wine
    @State private var selectedItem: PhotosPickerItem?

    private let accent = Color(
        red: 0.52,
        green: 0.15,
        blue: 0.26
    )

    var body: some View {

        ScrollView {
            VStack(spacing: 28) {

                headerView

                sectionCard(
                    number: "1",
                    title: "外観",
                    english: "APPEARANCE"
                ) {

                    tastingScaleRow(
                        title: "清澄度",
                        selection: $wine.clarity,
                        options: [
                            "澄んだ",
                            "やや濁った",
                            "濁った",
                        ]
                    )

                    simpleField(
                        title: "その他",
                        text: $wine.appearance
                    )

                    Divider()
                        .padding(.vertical, 4)

                    tastingScaleRow(
                        title: "輝き",
                        selection: $wine.brightness,
                        options: [
                            "輝きのある",
                            "ややくすんだ",
                            "モヤがかった",
                        ]
                    )

                    Divider()
                        .padding(.vertical, 4)

                    tastingScaleRow(
                        title: "色調（補助用語）",
                        selection: $wine.colorTone,
                        options: [
                            "シルバーがかった ",
                            "グリーンがかった",
                            "黄金色がかった",
                        ]
                    )

                    Divider()
                        .padding(.vertical, 4)

                    tastingScaleRow(
                        title: "色調（メイン用語）",
                        selection: $wine.color,
                        options: [
                            "レモンイエロー",
                            "イエロー",
                            "黄金色",
                            "トパーズ",
                            "オレンジ",
                            "アンバー",
                        ]
                    )

                    Divider()
                        .padding(.vertical, 4)

                    tastingScaleRow(
                        title: "濃淡",
                        selection: $wine.density,
                        options: [
                            "無色に近い",
                            "淡い",
                            "やや濃い",
                            "濃い",
                            "非常に濃い",
                        ]
                    )

                    Divider()
                        .padding(.vertical, 4)

                    tastingScaleRow(
                        title: "粘性",
                        selection: $wine.viscosity,
                        options: [
                            "さらっとした",
                            "適度な",
                            "やや強い",
                            "ねっとりとした",
                        ]
                    )

                    Divider()
                        .padding(.vertical, 4)

                    tastingScaleRow(
                        title: "外観の印象（若さ）",
                        selection: $wine.youthfulness,
                        options: [
                            "若々しい",
                            "やや発展した",
                            "熟成のニュアンスが見える",
                            "熟成した",
                            "酸化が進んだ",
                        ]
                    )

                    Divider()
                        .padding(.vertical, 4)

                    tastingScaleRow(
                        title: "外観の印象（成熟度）",
                        selection: $wine.maturity,
                        options: [
                            "軽快な",
                            "成熟度が高い",
                            "濃縮感がある",
                        ]
                    )

                    Divider()
                        .padding(.vertical, 4)

                    tastingScaleRow(
                        title: "外観の印象（発泡性）",
                        selection: $wine.effervescence,
                        options: [
                            "気泡が見える",
                            "発泡性",
                        ]
                    )
                }

                sectionCard(
                    number: "2",
                    title: "香り",
                    english: "AROMA"
                ) {

                    tastingScaleRow(
                        title: "第一印象",
                        selection: $wine.firstImpression,
                        options: [
                            "弱い",
                            "やや弱い",
                            "中程度",
                            "やや強い",
                            "強い"
                        ]
                    )

                    Divider()
                        .padding(.vertical, 4)

                    tastingScaleRow(
                        title: "果実香",
                        selection: $wine.fruit,
                        options: [
                            "柑橘",
                            "青リンゴ",
                            "洋梨",
                            "白桃",
                            "南国果実"
                        ]
                    )

                    Divider()
                        .padding(.vertical, 4)

                    tastingScaleRow(
                        title: "花の香り",
                        selection: $wine.flower,
                        options: [
                            "弱い",
                            "やや弱い",
                            "中程度",
                            "やや強い",
                            "強い"
                        ]
                    )

                    Divider()
                        .padding(.vertical, 4)

                    tastingScaleRow(
                        title: "樽香",
                        selection: $wine.spice,
                        options: [
                            "なし",
                            "弱い",
                            "中程度",
                            "強い"
                        ]
                    )
                }

                sectionCard(
                    number: "3",
                    title: "味わい",
                    english: "TASTE"
                ) {

                    numberScaleRow(
                        title: "甘味",
                        selection: $wine.sweetness,
                        values: ["1", "2", "3", "4", "5"]
                    )

                    Divider()
                        .padding(.vertical, 4)

                    numberScaleRow(
                        title: "酸味",
                        selection: $wine.acidity,
                        values: ["1", "2", "3", "4", "5"]
                    )

                    Divider()
                        .padding(.vertical, 4)

                    numberScaleRow(
                        title: "ボディ",
                        selection: $wine.balance,
                        values: ["1", "2", "3", "4", "5"]
                    )

                    Divider()
                        .padding(.vertical, 4)

                    numberScaleRow(
                        title: "アルコール",
                        selection: $wine.alcohol,
                        values: ["1", "2", "3", "4", "5"]
                    )

                    Divider()
                        .padding(.vertical, 4)

                    tastingScaleRow(
                        title: "余韻",
                        selection: $wine.finish,
                        options: [
                            "短い",
                            "やや短い",
                            "中程度",
                            "やや長い",
                            "長い"
                        ]
                    )
                }

                sectionCard(
                    number: "4",
                    title: "結論",
                    english: "CONCLUSION"
                ) {

                    simpleField(
                        title: "ブドウ品種",
                        text: $wine.grape
                    )

                    simpleField(
                        title: "生産地",
                        text: $wine.country
                    )

                    simpleField(
                        title: "ヴィンテージ",
                        text: $wine.vintage
                    )
                }
            }
            .padding()
        }
        .background(
            Color(
                red: 0.98,
                green: 0.97,
                blue: 0.97
            )
        )
        .navigationTitle("テイスティングシート")
        .navigationBarTitleDisplayMode(.inline)

        .onChange(of: selectedItem) {

            Task {

                if let data = try? await selectedItem?
                    .loadTransferable(type: Data.self) {

                    wine.imageData = data
                }
            }
        }
    }
}

// MARK: - Header

extension WhiteWineTastingSheetView {

    var headerView: some View {

        VStack(alignment: .leading, spacing: 18) {

            if let image = wine.image {

                Image(uiImage: image)
                    .resizable()
                    .scaledToFill()
                    .frame(height: 220)
                    .frame(maxWidth: .infinity)
                    .clipShape(
                        RoundedRectangle(cornerRadius: 20)
                    )

            } else {

                RoundedRectangle(cornerRadius: 20)
                    .fill(Color.gray.opacity(0.12))
                    .frame(height: 220)
                    .overlay {

                        Image(systemName: "wineglass.fill")
                            .font(.system(size: 60))
                            .foregroundStyle(accent.opacity(0.7))
                    }
            }

            PhotosPicker(
                selection: $selectedItem,
                matching: .images
            ) {

                Label(
                    "ワイン画像を変更",
                    systemImage: "photo"
                )
                .font(.subheadline)
                .foregroundStyle(accent)
            }

            VStack(alignment: .leading, spacing: 8) {

                Text("ワイン名")
                    .font(.subheadline)
                    .fontWeight(.semibold)

                HStack(spacing: 12) {

                    TextField(
                        "ワイン名を入力",
                        text: $wine.name
                    )

                    Button {

                        wine.isFavorite.toggle()

                    } label: {

                        Image(
                            systemName:
                                wine.isFavorite
                                ? "star.fill"
                                : "star"
                        )
                        .font(.title2)
                        .foregroundStyle(.yellow)
                    }
                }
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 14)
                        .fill(.white)
                )
                .overlay {

                    RoundedRectangle(cornerRadius: 14)
                        .stroke(
                            Color.gray.opacity(0.2)
                        )
                }
            }

            // 日付
            VStack(alignment: .leading, spacing: 8) {

                Text("試飲日")
                    .font(.subheadline)
                    .fontWeight(.semibold)

                DatePicker(
                    "",
                    selection: $wine.tastingDate,
                    displayedComponents: .date
                )
                .datePickerStyle(.compact)
                .labelsHidden()
                .padding()
                .frame(maxWidth: .infinity, alignment: .leading)
                .background(
                    RoundedRectangle(cornerRadius: 12)
                        .fill(Color.gray.opacity(0.06))
                )
            }
            
            VStack(alignment: .leading, spacing: 8) {
                Text("評価")
                    .font(.subheadline)
                    .fontWeight(.semibold)

                HStack(spacing: 10) {
                    ForEach(1...5, id: \.self) { star in
                        Button {
                            wine.rating = star

                        } label: {

                            Image(
                                systemName:
                                    star <= wine.rating
                                    ? "star.fill"
                                    : "star"
                            )
                            .font(.title2)
                            .foregroundStyle(.yellow)
                        }
                    }
                }
            }
 
            VStack(alignment: .leading, spacing: 8) {
                Text("コメント")
                    .font(.subheadline)
                    .fontWeight(.semibold)

                TextEditor(text: $wine.comment)
                    .frame(height: 120)
                    .padding(8)
                    .background(
                        RoundedRectangle(
                            cornerRadius: 12
                        )
                        .stroke(
                            Color.gray.opacity(0.25)
                        )
                    )
            }
        }
    }

    func infoRow(
        left: String,
        right: String
    ) -> some View {

        HStack {

            Text(left)
                .font(.caption)
                .foregroundStyle(.secondary)

            Spacer()

            Text(right)
                .font(.caption)
                .foregroundStyle(.secondary)
        }
    }
}

// MARK: - Section

extension WhiteWineTastingSheetView {

    func sectionCard<Content: View>(
        number: String,
        title: String,
        english: String,
        @ViewBuilder content: () -> Content
    ) -> some View {

        VStack(alignment: .leading, spacing: 20) {

            HStack(spacing: 10) {

                Text(number)
                    .font(.caption.bold())
                    .foregroundStyle(.white)
                    .frame(width: 24, height: 24)
                    .background(accent)
                    .clipShape(Circle())

                Text(title)
                    .font(.title3.bold())

                Text("(\(english))")
                    .font(.caption)
                    .foregroundStyle(accent)
            }

            content()
        }
        .padding(20)
        .background(.white)
        .clipShape(
            RoundedRectangle(cornerRadius: 24)
        )
        .overlay {

            RoundedRectangle(cornerRadius: 24)
                .stroke(
                    accent.opacity(0.12),
                    lineWidth: 1
                )
        }
    }
}

// MARK: - Rows

extension WhiteWineTastingSheetView {

    func tastingScaleRow(
        title: String,
        selection: Binding<String?>,
        options: [String]
    ) -> some View {

        VStack(alignment: .leading, spacing: 12) {

            Text(title)
                .font(.subheadline)
                .fontWeight(.semibold)

            LazyVGrid(
                columns: [
                    GridItem(.adaptive(minimum: 88))
                ],
                spacing: 10
            ) {

                ForEach(options, id: \.self) { option in

                    Button {

                        selection.wrappedValue = option

                    } label: {

                        HStack(spacing: 6) {

                            Image(
                                systemName:
                                    selection.wrappedValue == option
                                    ? "record.circle.fill"
                                    : "circle"
                            )

                            Text(option)
                                .font(.caption)
                                .lineLimit(1)
                        }
                        .foregroundStyle(
                            selection.wrappedValue == option
                            ? .white
                            : .primary
                        )
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 10)
                        .background {

                            RoundedRectangle(cornerRadius: 12)
                                .fill(
                                    selection.wrappedValue == option
                                    ? accent
                                    : Color.gray.opacity(0.08)
                                )
                        }
                    }
                }
            }
        }
    }

    func numberScaleRow(
        title: String,
        selection: Binding<String?>,
        values: [String]
    ) -> some View {

        VStack(alignment: .leading, spacing: 12) {

            Text(title)
                .font(.subheadline)
                .fontWeight(.semibold)

            HStack {

                ForEach(values, id: \.self) { value in

                    Button {

                        selection.wrappedValue = value

                    } label: {

                        Text(value)
                            .font(.subheadline.bold())
                            .foregroundStyle(
                                selection.wrappedValue == value
                                ? .white
                                : .primary
                            )
                            .frame(maxWidth: .infinity)
                            .frame(height: 38)
                            .background {

                                RoundedRectangle(
                                    cornerRadius: 10
                                )
                                .fill(
                                    selection.wrappedValue == value
                                    ? accent
                                    : Color.gray.opacity(0.08)
                                )
                            }
                    }
                }
            }
        }
    }

    func simpleField(
        title: String,
        text: Binding<String>
    ) -> some View {

        VStack(alignment: .leading, spacing: 8) {

            Text(title)
                .font(.subheadline)
                .fontWeight(.semibold)

            TextField(title, text: text)
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 12)
                        .fill(Color.gray.opacity(0.06))
                )
        }
    }
}

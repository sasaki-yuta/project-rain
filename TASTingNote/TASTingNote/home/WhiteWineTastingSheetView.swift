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

    // MARK: 外観

    @State private var clarity = "澄んだ"
    @State private var brightness = "輝きのある"
    @State private var color = "レモンイエロー"
    @State private var density = "淡い"
    @State private var viscosity = "適度な"
    @State private var appearanceImpression = "若々しい"

    // MARK: 香り

    @State private var firstImpression = "開いている"

    @State private var fruit = "柑橘類"
    @State private var flower = "アカシア"
    @State private var spice = "石灰"

    @State private var aromaImpression = "若々しい"

    // MARK: 味わい

    @State private var attack = "やや軽い"
    @State private var sweetness = "ドライ"
    @State private var acidity = "爽やかな"
    @State private var bitterness = "穏やかな"
    @State private var balance = "スムーズな"
    @State private var alcohol = "12%～13%未満"
    @State private var finish = "やや長い"
    @State private var evaluation = "エレガントでミネラリー"

    // MARK: その他

    @State private var temperature = "8～10度"
    @State private var glass = "中庸"

    // MARK: 結論

    @State private var grape = ""
    @State private var country = ""
    @State private var vintage = ""
    @State private var comment = ""

    var body: some View {

        ScrollView {

            VStack(alignment: .leading, spacing: 24) {

                // MARK: ワイン情報

                VStack(alignment: .leading, spacing: 16) {

                    if let image = wine.image {

                        Image(uiImage: image)
                            .resizable()
                            .scaledToFit()
                            .frame(maxHeight: 240)
                            .clipShape(
                                RoundedRectangle(cornerRadius: 16)
                            )

                    } else {

                        RoundedRectangle(cornerRadius: 16)
                            .fill(Color.gray.opacity(0.15))
                            .frame(height: 240)
                            .overlay {

                                Image(systemName: "wineglass")
                                    .font(.system(size: 60))
                                    .foregroundColor(.gray)
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
                    }

                    VStack(alignment: .leading) {

                        Text("ワイン名")
                            .font(.headline)

                        TextField(
                            "ワイン名を入力",
                            text: $wine.name
                        )
                        .textFieldStyle(.roundedBorder)
                    }
                }

                Divider()

                // MARK: 外観

                tastingSection(title: "外観") {

                    tastingRow(
                        title: "清澄度",
                        selection: $clarity,
                        options: [
                            "澄んだ",
                            "やや濁った",
                            "濁った"
                        ]
                    )

                    tastingRow(
                        title: "輝き",
                        selection: $brightness,
                        options: [
                            "輝きのある",
                            "ややくすんだ",
                            "モヤがかった"
                        ]
                    )

                    tastingRow(
                        title: "色調",
                        selection: $color,
                        options: [
                            "レモンイエロー",
                            "イエロー",
                            "黄金色",
                            "トパーズ",
                            "アンバー"
                        ]
                    )

                    tastingRow(
                        title: "濃淡",
                        selection: $density,
                        options: [
                            "淡い",
                            "やや濃い",
                            "濃い",
                            "非常に濃い"
                        ]
                    )

                    tastingRow(
                        title: "粘性",
                        selection: $viscosity,
                        options: [
                            "さらっとした",
                            "適度な",
                            "やや強い",
                            "ねっとりとした"
                        ]
                    )

                    tastingRow(
                        title: "外観の印象",
                        selection: $appearanceImpression,
                        options: [
                            "若々しい",
                            "やや発展した",
                            "熟成した",
                            "軽快な",
                            "濃縮感がある"
                        ]
                    )
                }

                Divider()

                // MARK: 香り

                tastingSection(title: "香り") {

                    tastingRow(
                        title: "第一印象",
                        selection: $firstImpression,
                        options: [
                            "閉じている",
                            "控えめ",
                            "開いている",
                            "力強い"
                        ]
                    )

                    tastingRow(
                        title: "果実",
                        selection: $fruit,
                        options: [
                            "柑橘類",
                            "青リンゴ",
                            "洋梨",
                            "白桃",
                            "アプリコット",
                            "パイナップル"
                        ]
                    )

                    tastingRow(
                        title: "花・植物",
                        selection: $flower,
                        options: [
                            "スイカズラ",
                            "アカシア",
                            "白バラ",
                            "ハーブ",
                            "タイム"
                        ]
                    )

                    tastingRow(
                        title: "香辛料・芳香",
                        selection: $spice,
                        options: [
                            "石灰",
                            "火打石",
                            "貝殻",
                            "トースト",
                            "ヴァニラ",
                            "蜂蜜"
                        ]
                    )

                    tastingRow(
                        title: "香りの印象",
                        selection: $aromaImpression,
                        options: [
                            "若々しい",
                            "熟成感が現れている",
                            "ニュートラル",
                            "木樽からのニュアンス"
                        ]
                    )
                }

                Divider()

                // MARK: 味わい

                tastingSection(title: "味わい") {

                    tastingRow(
                        title: "アタック",
                        selection: $attack,
                        options: [
                            "軽い",
                            "やや軽い",
                            "やや強い",
                            "強い"
                        ]
                    )

                    tastingRow(
                        title: "甘み",
                        selection: $sweetness,
                        options: [
                            "ドライ",
                            "ソフトな",
                            "まろやか",
                            "豊かな",
                            "残糖がある"
                        ]
                    )

                    tastingRow(
                        title: "酸味",
                        selection: $acidity,
                        options: [
                            "なめらかな",
                            "爽やかな",
                            "はつらつとした",
                            "力強い"
                        ]
                    )

                    tastingRow(
                        title: "苦味",
                        selection: $bitterness,
                        options: [
                            "控えめ",
                            "穏やかな",
                            "コクを与える",
                            "強い"
                        ]
                    )

                    tastingRow(
                        title: "バランス",
                        selection: $balance,
                        options: [
                            "スムーズな",
                            "スリムな",
                            "ドライな",
                            "ジューシーな",
                            "豊潤な"
                        ]
                    )

                    tastingRow(
                        title: "アルコール",
                        selection: $alcohol,
                        options: [
                            "11%未満",
                            "11%～12%未満",
                            "12%～13%未満",
                            "13%～14%未満",
                            "14%以上"
                        ]
                    )

                    tastingRow(
                        title: "余韻",
                        selection: $finish,
                        options: [
                            "短い",
                            "やや短い",
                            "やや長い",
                            "長い"
                        ]
                    )

                    tastingRow(
                        title: "評価",
                        selection: $evaluation,
                        options: [
                            "シンプル、フレッシュ感を楽しむ",
                            "エレガントでミネラリー",
                            "成熟度が高く豊か",
                            "濃縮し力強い"
                        ]
                    )
                }

                Divider()

                // MARK: サービス

                tastingSection(title: "サービス") {

                    tastingRow(
                        title: "適正温度",
                        selection: $temperature,
                        options: [
                            "8度未満",
                            "8～10度",
                            "11～14度",
                            "15～18度"
                        ]
                    )

                    tastingRow(
                        title: "グラス",
                        selection: $glass,
                        options: [
                            "小ぶり",
                            "中庸",
                            "大ぶり",
                            "バルーン型",
                            "チューリップ型"
                        ]
                    )
                }

                Divider()

                // MARK: 結論

                tastingSection(title: "結論") {

                    TextField(
                        "主なブドウ品種",
                        text: $grape
                    )
                    .textFieldStyle(.roundedBorder)

                    TextField(
                        "生産地",
                        text: $country
                    )
                    .textFieldStyle(.roundedBorder)

                    TextField(
                        "収穫年",
                        text: $vintage
                    )
                    .textFieldStyle(.roundedBorder)

                    VStack(alignment: .leading) {

                        Text("コメント")
                            .font(.headline)

                        TextEditor(text: $comment)
                            .frame(height: 140)
                            .overlay(
                                RoundedRectangle(cornerRadius: 8)
                                    .stroke(
                                        Color.gray.opacity(0.3)
                                    )
                            )
                    }
                }
            }
            .padding()
        }
        .background(Color.white)
        .navigationTitle("白ワイン")
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

// MARK: - UI Helper

extension WhiteWineTastingSheetView {

    func tastingSection<Content: View>(
        title: String,
        @ViewBuilder content: () -> Content
    ) -> some View {

        VStack(alignment: .leading, spacing: 18) {

            Text(title)
                .font(.title3)
                .bold()

            content()
        }
    }

    func tastingRow(
        title: String,
        selection: Binding<String>,
        options: [String]
    ) -> some View {

        VStack(alignment: .leading, spacing: 10) {

            Text(title)
                .font(.headline)

            ScrollView(.horizontal, showsIndicators: false) {

                HStack {

                    ForEach(options, id: \.self) { option in

                        Button {

                            selection.wrappedValue = option

                        } label: {

                            HStack {

                                Image(
                                    systemName:
                                        selection.wrappedValue == option
                                        ? "largecircle.fill.circle"
                                        : "circle"
                                )

                                Text(option)
                            }
                            .padding(.horizontal, 14)
                            .padding(.vertical, 10)
                            .background(
                                RoundedRectangle(
                                    cornerRadius: 12
                                )
                                .stroke(
                                    Color.gray.opacity(0.3)
                                )
                            )
                        }
                        .foregroundColor(.primary)
                    }
                }
            }
        }
    }
}

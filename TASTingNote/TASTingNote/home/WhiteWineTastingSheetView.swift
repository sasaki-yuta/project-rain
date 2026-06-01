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
                        text: $wine.clarityOther
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
                    
                    simpleField(
                        title: "その他",
                        text: $wine.brightnessOther
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

                    simpleField(
                        title: "その他",
                        text: $wine.colorToneOther
                    )

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
                    
                    simpleField(
                        title: "その他",
                        text: $wine.colorOther
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

                    simpleField(
                        title: "その他",
                        text: $wine.densityOther
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

                    simpleField(
                        title: "その他",
                        text: $wine.viscosityOther
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

                    simpleField(
                        title: "その他",
                        text: $wine.youthfulnessOther
                    )

                    tastingScaleRow(
                        title: "外観の印象（成熟度）",
                        selection: $wine.maturity,
                        options: [
                            "軽快な",
                            "成熟度が高い",
                            "濃縮感がある",
                        ]
                    )

                    simpleField(
                        title: "その他",
                        text: $wine.maturityOther
                    )

                    tastingScaleRow(
                        title: "外観の印象（発泡性）",
                        selection: $wine.effervescence,
                        options: [
                            "気泡が見える",
                            "発泡性",
                        ]
                    )

                    simpleField(
                        title: "その他",
                        text: $wine.effervescenceOther
                    )

                }

                sectionCard(
                    number: "2",
                    title: "香り",
                    english: "AROMA"
                ) {

                    tastingScaleRow(
                        title: "第一印象(強さ)",
                        selection: $wine.firstImpIntensity,
                        options: [
                            "閉じている",
                            "控えめ",
                            "開いている",
                            "力強い"
                        ]
                    )
                    
                    simpleField(
                        title: "その他",
                        text: $wine.firstImpIntensityOther
                    )

                    tastingScaleRow(
                        title: "第一印象（性質）",
                        selection: $wine.firstImpCharacter,
                        options: [
                            "フレッシュな",
                            "ミネラリー",
                            "華やかな",
                            "熟度の高い",
                            "豊かな",
                            "濃縮感がある",
                            "セイボリーな ",
                            "複雑な"
                        ]
                    )
                    
                    simpleField(
                        title: "その他",
                        text: $wine.firstImpCharacterOther
                    )

                    Divider()
                        .padding(.vertical, 4)

                    tastingScaleRow(
                        title: "果実",
                        selection: $wine.fruit,
                        options: [
                            "柑橘類",
                            "青リンゴ",
                            "リンゴ",
                            "洋梨",
                            "マスカット",
                            "花梨",
                            "パッションフルーツ",
                            "白桃",
                            "アプリコット",
                            "パイナップル",
                            "ライチ",
                            "バナナ",
                            "マンゴー"
                        ]
                    )
                    
                    simpleField(
                        title: "その他",
                        text: $wine.fruitOther
                    )

                    Divider()
                        .padding(.vertical, 4)

                    tastingScaleRow(
                        title: "花・植物（花）",
                        selection: $wine.plantFlower,
                        options: [
                            "スイカズラ",
                            "アカシア",
                            "白バラ",
                            "キンモクセイ",
                            "菩提樹",
                            "柑橘系の花"
                        ]
                    )
                    
                    simpleField(
                        title: "その他",
                        text: $wine.plantFlowerOther
                    )

                    tastingScaleRow(
                        title: "花・植物（ハーブ）",
                        selection: $wine.plantHerb,
                        options: [
                            "ミント",
                            "アニス",
                            "ヴェルヴェーヌ",
                            "ハーブ",
                            "タイム"
                        ]
                    )
                    
                    simpleField(
                        title: "その他",
                        text: $wine.plantHerbOther
                    )

                    tastingScaleRow(
                        title: "花・植物（ナッツ）",
                        selection: $wine.plantNuts,
                        options: [
                            "フレッシュアーモンド",
                            "ヘーゼルナッツ"
                        ]
                    )
                    
                    simpleField(
                        title: "その他",
                        text: $wine.plantNutsOther
                    )

                    Divider()
                        .padding(.vertical, 4)

                    tastingScaleRow(
                        title: "香辛料・芳香・化学物質（ミネラル）",
                        selection: $wine.spiceMineral,
                        options: [
                            "石灰",
                            "火打石",
                            "貝殻",
                            "鉱物",
                            "海の香り"
                        ]
                    )
                    
                    simpleField(
                        title: "その他",
                        text: $wine.spiceMineralOther
                    )

                    tastingScaleRow(
                        title: "香辛料・芳香・化学物質（樽）",
                        selection: $wine.spicsOak,
                        options: [
                            "トースト",
                            "ヴァニラ",
                            "煙",
                            "薫製"
                        ]
                    )
                    
                    simpleField(
                        title: "その他",
                        text: $wine.spicsOakOther
                    )

                    tastingScaleRow(
                        title: "香辛料・芳香・化学物質（香辛料）",
                        selection: $wine.spiceSpice,
                        options: [
                            "シナモン",
                            "白胡椒",
                            "コリアンダーシード",
                            "丁字",
                            "香木",
                            "ジンジャーブレッド"
                        ]
                    )
                    
                    simpleField(
                        title: "その他",
                        text: $wine.spiceSpiceOther
                    )

                    tastingScaleRow(
                        title: "香辛料・芳香・化学物質（他）",
                        selection: $wine.spiceOthers,
                        options: [
                            "硫黄",
                            "ペトロール",
                            "パン・ド・ミ",
                            "乳製品",
                            "フェノール",
                            "麝香",
                            "花の蜜",
                            "蜂蜜",
                            "ワックス",
                            "蜜蝋"
                        ]
                    )
                    
                    simpleField(
                        title: "その他",
                        text: $wine.spiceOthersOther
                    )

                    Divider()
                        .padding(.vertical, 4)

                    tastingScaleRow(
                        title: "香りの印象（熟成感）",
                        selection: $wine.spiceMaturity,
                        options: [
                            "若々しい",
                            "嫌気的な",
                            "熟成感が現れている",
                            "酸化熟成の段階"
                        ]
                    )
                    
                    simpleField(
                        title: "その他",
                        text: $wine.spiceMaturityOther
                    )
                    
                    tastingScaleRow(
                        title: "香りの印象（特性）",
                        selection: $wine.spiceCharacteristic,
                        options: [
                            "第1アロマが強い",
                            "第2アロマが強い",
                            "ニュートラル",
                            "木樽からのニュアンス",
                            "成熟度が高い"
                        ]
                    )
                    
                    simpleField(
                        title: "その他",
                        text: $wine.spiceCharacteristicOther
                    )
                }

                sectionCard(
                    number: "3",
                    title: "味わい",
                    english: "TASTE"
                ) {

                    tastingScaleRow(
                        title: "アタック",
                        selection: $wine.attack,
                        options: [
                            "軽い",
                            "やや軽い",
                            "やや強い",
                            "強い",
                            "インパクトのある"
                        ]
                    )
                    
                    simpleField(
                        title: "その他",
                        text: $wine.attackOther
                    )

                    Divider()
                        .padding(.vertical, 4)

                    tastingScaleRow(
                        title: "甘味",
                        selection: $wine.sweetness,
                        options: [
                            "ドライ",
                            "ソフトな",
                            "まろやか",
                            "豊かな",
                            "残糖がある"
                        ]
                    )
                    
                    simpleField(
                        title: "その他",
                        text: $wine.sweetnessOther
                    )

                    Divider()
                        .padding(.vertical, 4)

                    tastingScaleRow(
                        title: "酸味",
                        selection: $wine.acidity,
                        options: [
                            "なめらかな",
                            "軽やかな",
                            "爽やかな",
                            "はつらつとした",
                            "力強い",
                            "直線的",
                            "堅固な"
                        ]
                    )
                    
                    simpleField(
                        title: "その他",
                        text: $wine.acidityOther
                    )
                    
                    Divider()
                        .padding(.vertical, 4)

                    tastingScaleRow(
                        title: "苦味",
                        selection: $wine.bitterness,
                        options: [
                            "控えめ",
                            "穏やかな",
                            "コク(深み)を与える",
                            "旨味をともなった",
                            "強い(突出した)"
                        ]
                    )
                    
                    simpleField(
                        title: "その他",
                        text: $wine.bitternessOther
                    )

                    Divider()
                        .padding(.vertical, 4)

                    tastingScaleRow(
                        title: "バランンス（左下）",
                        selection: $wine.balanceBottomLeft,
                        options: [
                            "スムーズな",
                            "コンパクトな"
                        ]
                    )
                    
                    simpleField(
                        title: "その他",
                        text: $wine.balanceBottomLeftOther
                    )

                    tastingScaleRow(
                        title: "バランンス（左上）",
                        selection: $wine.balanceTopLeft,
                        options: [
                            "スリムな",
                            "ドライな"
                        ]
                    )
                    
                    simpleField(
                        title: "その他",
                        text: $wine.balanceTopLeftOther
                    )
                    
                    tastingScaleRow(
                        title: "バランンス（右上）",
                        selection: $wine.balanceTopRight,
                        options: [
                            "ジューシーな",
                            "豊潤な",
                            "厚みのある"
                        ]
                    )
                    
                    simpleField(
                        title: "その他",
                        text: $wine.balanceTopRightOther
                    )
                    
                    tastingScaleRow(
                        title: "バランンス（右下）",
                        selection: $wine.balanceBottmRight,
                        options: [
                            "まろやかな",
                            "ねっとりした"
                        ]
                    )
                    
                    simpleField(
                        title: "その他",
                        text: $wine.balanceBottmRightOther
                    )
                    
                    Divider()
                        .padding(.vertical, 4)
                    
                    tastingScaleRow(
                        title: "アルコール",
                        selection: $wine.alcohol,
                        options: [
                            "11%未満",
                            "11%～12%未満",
                            "12%～13%未満",
                            "13%～14%未満",
                            "14%以上"
                        ]
                    )
                    
                    simpleField(
                        title: "その他",
                        text: $wine.alcoholOther
                    )

                    Divider()
                        .padding(.vertical, 4)

                    tastingScaleRow(
                        title: "余韻",
                        selection: $wine.finish,
                        options: [
                            "短い",
                            "やや短い",
                            "やや長い",
                            "長い"
                        ]
                    )
                    
                    simpleField(
                        title: "その他",
                        text: $wine.finishOther
                    )
                }

                sectionCard(
                    number: "4",
                    title: "結論",
                    english: "CONCLUSION"
                ) {

                    tastingScaleRow(
                        title: "評価",
                        selection: $wine.evaluation,
                        options: [
                            "シンプル、フレッシュ感を楽しむ",
                            "エレガントでミネラリー",
                            "なめらかでバランスが良い",
                            "成熟度が高く豊か",
                            "濃縮し力強い",
                            "ポテンシャルの高い"
                        ]
                    )
                    
                    simpleField(
                        title: "その他",
                        text: $wine.evaluationOther
                    )

                    Divider()
                        .padding(.vertical, 4)
                    
                    tastingScaleRow(
                        title: "適正温度",
                        selection: $wine.eervingTemperature,
                        options: [
                            "8度未満",
                            "8～10度",
                            "11～14度",
                            "15～18度",
                            "19度以上"
                        ]
                    )
                    
                    simpleField(
                        title: "その他",
                        text: $wine.eervingTemperatureOther
                    )

                    Divider()
                        .padding(.vertical, 4)

                    tastingScaleRow(
                        title: "グラス",
                        selection: $wine.glass,
                        options: [
                            "小ぶり",
                            "中庸",
                            "大ぶり",
                            "バルーン型",
                            "チューリップ型"
                        ]
                    )
                    
                    simpleField(
                        title: "その他",
                        text: $wine.glassOther
                    )

                    Divider()
                        .padding(.vertical, 4)

                    simpleField(
                        title: "収穫年",
                        text: $wine.vintage
                    )

                    simpleField(
                        title: "生産地",
                        text: $wine.country
                    )

                    simpleField(
                        title: "主なブドウ品種",
                        text: $wine.grape
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

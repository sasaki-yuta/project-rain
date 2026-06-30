//
//  RedWineTastingSheetView.swift
//  TASTingNote
//
//  Created by 佐々木 勇太 on 2026/06/02.
//
import SwiftUI
import PhotosUI
import CoreLocation
import Combine

struct RedWineTastingSheetView: View {

    @Bindable var wine: redWine
    @State private var selectedItem: PhotosPickerItem?

    @StateObject private var locationManager =
        RedWineLocationManager()
    
    @State private var showMapPicker = false

    private let accent = Color(
        red: 0.52,
        green: 0.15,
        blue: 0.26
    )

    var body: some View {
        ScrollViewReader { proxy in
            ScrollView {
                Color.clear
                        .frame(height: 1)
                        .id("top")
                
                VStack(spacing: 28) {
                    
                    redheaderView
                    
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
                                "深みのある",
                                "やや濁った",
                                "濁った",
                            ]
                        )
                        
                        otherField(text: $wine.clarityOther)
                        
                        Divider()
                            .padding(.vertical, 4)
                        
                        tastingScaleRow(
                            title: "輝き",
                            selection: $wine.brightness,
                            options: [
                                "輝きのある",
                                "艶のある",
                                "モヤがかった",
                            ]
                        )
                        
                        otherField(text: $wine.brightnessOther)
                        
                        Divider()
                            .padding(.vertical, 4)
                        
                        tastingScaleRow(
                            title: "色調（補助用語）",
                            selection: $wine.colorTone,
                            options: [
                                "紫がかった",
                                "オレンジがかった",
                                "黒みを帯びた",
                                "縁が明るい",
                            ]
                        )
                        
                        otherField(text: $wine.colorToneOther)
                        
                        tastingScaleRow(
                            title: "色調（メイン用語）",
                            selection: $wine.color,
                            options: [
                                "ルビー",
                                "ラズベリーレッド",
                                "ガーネット",
                                "ダークチェリーレッド",
                                "トパーズ",
                                "マホガニー",
                                "レンガ",
                            ]
                        )
                        
                        otherField(text: $wine.colorOther)
                        
                        Divider()
                            .padding(.vertical, 4)
                        
                        tastingScaleRow(
                            title: "濃淡",
                            selection: $wine.density,
                            options: [
                                "淡い",
                                "明るい",
                                "やや明るい",
                                "やや濃い",
                                "濃い",
                                "非常に濃い",
                            ]
                        )
                        
                        otherField(text: $wine.densityOther)
                        
                        Divider()
                            .padding(.vertical, 4)
                        
                        tastingScaleRow(
                            title: "粘性",
                            selection: $wine.viscosity,
                            options: [
                                "さらっとした",
                                "やや軽い",
                                "やや強い",
                                "強い",
                            ]
                        )
                        
                        otherField(text: $wine.viscosityOther)
                        
                        Divider()
                            .padding(.vertical, 4)
                        
                        tastingScaleRow(
                            title: "外観の印象（若さ）",
                            selection: $wine.youthfulness,
                            options: [
                                "若々しい",
                                "若い状態を抜けた",
                                "やや熟成した",
                                "熟成した",
                                "酸化熟成のニュアンス",
                                "酸化が進んだ",
                            ]
                        )
                        
                        otherField(text: $wine.youthfulnessOther)
                        
                        tastingScaleRow(
                            title: "外観の印象（成熟度）",
                            selection: $wine.maturity,
                            options: [
                                "軽快な",
                                "成熟度が高い",
                                "濃縮感が強い",
                            ]
                        )
                        
                        otherField(text: $wine.maturityOther)
/*
                        tastingScaleRow(
                            title: "外観の印象（発泡性）",
                            selection: $wine.effervescence,
                            options: [
                                "気泡が見える",
                                "発泡性",
                            ]
                        )
                        
                        otherField(text: $wine.effervescenceOther)
 */
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
                                "強い"
                            ]
                        )
                        
                        otherField(text: $wine.firstImpIntensityOther)
                        
                        tastingScaleRow(
                            title: "第一印象（性質）",
                            selection: $wine.firstImpCharacter,
                            options: [
                                "ミネラリー",
                                "華やかな",
                                "濃縮感がある",
                                "深みのある",
                                "複雑な",
                            ]
                        )
                        
                        otherField(text: $wine.firstImpCharacterOther)
                        
                        Divider()
                            .padding(.vertical, 4)
                        
                        tastingScaleRow(
                            title: "果実",
                            selection: $wine.fruit,
                            options: [
                                "イチゴ",
                                "ラズベリー",
                                "ブルーベリー",
                                "カシス",
                                "ブラックベリー",
                                "ブラックチェリー",
                                "干しプラム",
                                "乾燥イチジク",
                            ]
                        )
                        
                        otherField(text: $wine.fruitOther)
                        
                        Divider()
                            .padding(.vertical, 4)
                        
                        tastingScaleRow(
                            title: "花・植物（花）",
                            selection: $wine.plantFlower,
                            options: [
                                "バラ",
                                "スミレ",
                                "牡丹",
                                "ゼラニウム",
                            ]
                        )
                        
                        otherField(text: $wine.plantFlowerOther)
                        
                        tastingScaleRow(
                            title: "花・植物（ハーブ）",
                            selection: $wine.plantHerb,
                            options: [
                                "ピーマン",
                                "トマト",
                                "黒オリーブ",
                                "メントール",
                                "シダ",
                                "ローリエ",
                                "杉",
                                "針葉樹",
                                "ユーカリ",
                            ]
                        )
                        
                        otherField(text: $wine.plantHerbOther)
                        
                        tastingScaleRow(
                            title: "花・植物（ドライ）",
                            selection: $wine.plantNuts,
                            options: [
                                "ドライハーブ",
                                "タバコ",
                                "紅茶",
                                "スーボア",
                            ]
                        )
                        
                        otherField(text: $wine.plantNutsOther)
                        
                        // 変数違うけど白で使用しない変数を代用
                        tastingScaleRow(
                            title: "花・植物（菌類）",
                            selection: $wine.effervescence,
                            options: [
                                "キノコ",
                                "トリュフ",
                                "土",
                            ]
                        )
                        
                        otherField(text: $wine.effervescenceOther)
                        
                        Divider()
                            .padding(.vertical, 4)
                        
                        tastingScaleRow(
                            title: "香辛料・芳香・化学物質（香辛料）",
                            selection: $wine.spiceMineral,
                            options: [
                                "黒胡椒",
                                "丁子",
                                "シナモン",
                                "ナツメグ",
                                "甘草",
                            ]
                        )
                        
                        otherField(text: $wine.spiceMineralOther)
                        
                        tastingScaleRow(
                            title: "香辛料・芳香・化学物質（樽）",
                            selection: $wine.spicsOak,
                            options: [
                                "ヴァニラ",
                                "ロースト",
                                "コーヒー",
                                "チョコレート",
                                "煙、薫製",
                            ]
                        )
                        
                        otherField(text: $wine.spicsOakOther)
                        
                        tastingScaleRow(
                            title: "香辛料・芳香・化学物質（動物）",
                            selection: $wine.spiceSpice,
                            options: [
                                "動物的なニュアンス",
                                "鉄分",
                                "生肉",
                                "グリエ",
                                "乾いた肉",
                                "なめし皮",
                            ]
                        )
                        
                        otherField(text: $wine.spiceSpiceOther)
                        
                        tastingScaleRow(
                            title: "香辛料・芳香・化学物質（他）",
                            selection: $wine.spiceOthers,
                            options: [
                                "樹脂",
                                "ヨード",
                                "ランシオ",
                            ]
                        )
                        
                        otherField(text: $wine.spiceOthersOther)
                        
                        Divider()
                            .padding(.vertical, 4)
                        
                        tastingScaleRow(
                            title: "香りの印象（熟成感）",
                            selection: $wine.spiceMaturity,
                            options: [
                                "若々しい",
                                "嫌気的な",
                                "熟成感が現れている",
                                "酸化熟成の段階にある",
                                "酸化した",
                            ]
                        )
                        
                        otherField(text: $wine.spiceMaturityOther)
                        
                        tastingScaleRow(
                            title: "香りの印象（特性）",
                            selection: $wine.spiceCharacteristic,
                            options: [
                                "第1アロマが強い",
                                "第2アロマが強い",
                                "ニュートラル",
                                "木樽からのニュアンス",
                            ]
                        )
                        
                        otherField(text: $wine.spiceCharacteristicOther)
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
                        
                        otherField(text: $wine.attackOther)
                        
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
                        
                        otherField(text: $wine.sweetnessOther)
                        
                        Divider()
                            .padding(.vertical, 4)
                        
                        tastingScaleRow(
                            title: "酸味",
                            selection: $wine.acidity,
                            options: [
                                "なめらかな",
                                "軽やかな",
                                "爽やかな",
                                "生き生きとした",
                                "しなやかな",
                                "力強い",
                                "直線的",
                                "堅固な",
                            ]
                        )
                        
                        otherField(text: $wine.acidityOther)
                        
                        Divider()
                            .padding(.vertical, 4)
                        
                        tastingScaleRow(
                            title: "タンニン分",
                            selection: $wine.bitterness,
                            options: [
                                "サラサラとした",
                                "シルキーな",
                                "ヴィロードのような",
                                "溶け込んだ",
                                "緻密",
                                "力強い",
                                "収斂性のある",
                            ]
                        )
                        
                        otherField(text: $wine.bitternessOther)
                        
                        Divider()
                            .padding(.vertical, 4)
                        
/*
                        tastingScaleRow(
                            title: "バランス（左下）",
                            selection: $wine.balanceBottomLeft,
                            options: [
                                "スムーズな",
                                "コンパクトな"
                            ]
                        )
                        otherField(text: $wine.balanceBottomLeftOther)
 */

                        tastingScaleRow(
                            title: "バランス（左上）",
                            selection: $wine.balanceTopLeft,
                            options: [
                                "スマートな",
                                "骨格のしっかりとした",
                                "堅固な",
                                "痩せた、渇いた",
                            ]
                        )
                        
                        otherField(text: $wine.balanceTopLeftOther)
                        
                        tastingScaleRow(
                            title: "バランス（右上）",
                            selection: $wine.balanceTopRight,
                            options: [
                                "ジューシーな",
                                "豊満な",
                                "力強い",
                            ]
                        )
                        
                        otherField(text: $wine.balanceTopRightOther)
                        
                        tastingScaleRow(
                            title: "バランス（下）",
                            selection: $wine.balanceBottmRight,
                            options: [
                                "流れるような",
                                "ふくよかな",
                            ]
                        )
                        
                        otherField(text: $wine.balanceBottmRightOther)
                        
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
                        
                        otherField(text: $wine.alcoholOther)
                        
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
                        
                        otherField(text: $wine.finishOther)
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
                                "エレガントで余韻の長い",
                                "複雑性があり引き締まった",
                                "成熟度が高く豊か",
                                "濃縮し力強い",
                            ]
                        )
                        
                        otherField(text: $wine.evaluationOther)
                        
                        Divider()
                            .padding(.vertical, 4)
                        
                        tastingScaleRow(
                            title: "適正温度",
                            selection: $wine.eervingTemperature,
                            options: [
                                "10度未満",
                                "10～13度",
                                "14～16度",
                                "17～20度",
                                "21度以上",
                            ]
                        )
                        
                        otherField(text: $wine.eervingTemperatureOther)
                        
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
                        
                        otherField(text: $wine.glassOther)
                        
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
                    Color.clear
                        .frame(height: 1)
                        .id("bottom")
                }
                .padding()
            }
            .scrollDismissesKeyboard(.interactively)
            .overlay(alignment: .bottomTrailing) {
                HStack(spacing: 12) {
                    // 一番上へ
                    Button {
                        withAnimation {
                            proxy.scrollTo("top", anchor: .top)
                        }
                    } label: {
                        Image(systemName: "arrow.up.circle.fill")
                            .font(.system(size: 50))
                            .foregroundStyle(accent)
                            .background(.white)
                            .clipShape(Circle())
                            .shadow(radius: 4)
                    }

                    // 一番下へ
                    Button {
                        withAnimation {
                            proxy.scrollTo("bottom", anchor: .bottom)
                        }
                    } label: {
                        Image(systemName: "arrow.down.circle.fill")
                            .font(.system(size: 50))
                            .foregroundStyle(accent)
                            .background(.white)
                            .clipShape(Circle())
                            .shadow(radius: 4)
                    }
                }
                .padding()
            }
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
        
        .onAppear {
            wine.chartLocked = true
        }
        
        .onChange(of: selectedItem) {

            Task {

                if let data = try? await selectedItem?
                    .loadTransferable(type: Data.self) {

                    wine.imageData = data
                }
            }
        }
        .sheet(isPresented: $showMapPicker) {

            MapLocationPickerViewRed(
                latitude: $wine.latitude,
                longitude: $wine.longitude
            )
        }
    }
}

// MARK: - Header

extension RedWineTastingSheetView {

    var redheaderView: some View {

        VStack(alignment: .leading, spacing: 18) {

            if let image = wine.image {

                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
                    .frame(maxWidth: .infinity)
                    .frame(height: 220)
                    .background(Color(.systemGray6))
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
                            if wine.rating == star {
                                wine.rating = 0
                            } else {
                                wine.rating = star
                            }
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

                HStack {
                    Text("ワインチャート")
                        .font(.subheadline)
                        .fontWeight(.semibold)

                    Spacer()

                    Button {
                        wine.chartLocked.toggle()
                    } label: {
                        Label(
                            wine.chartLocked ? "ロック中" : "編集可能",
                            systemImage: wine.chartLocked
                            ? "lock.fill"
                            : "lock.open.fill"
                        )
                        .font(.caption)
                    }
                }

                HStack {
                    Text("甘口")
                    Spacer()
                    Text("辛口")
                }
                .font(.caption)
                .foregroundStyle(.secondary)

                WineChartPickerView(
                    xValue: $wine.chartX,
                    yValue: $wine.chartY,
                    isLocked: wine.chartLocked
                )
                .allowsHitTesting(!wine.chartLocked)
            }
            
            VStack(alignment: .leading) {
                Text("飲んだ場所")

                if let lat = wine.latitude,
                   let lon = wine.longitude {

                    Text(
                        "\(lat), \(lon)"
                    )
                    .font(.caption)
                    .foregroundStyle(.secondary)
                }

                Button("現在地を保存") {
                    guard let location =
                        locationManager.location
                    else { return }

                    wine.latitude =
                        location.coordinate.latitude

                    wine.longitude =
                        location.coordinate.longitude
                }

                Button {
                    showMapPicker = true
                } label: {
                    Label(
                        "地図から選択",
                        systemImage: "map"
                    )
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

extension RedWineTastingSheetView {

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

extension RedWineTastingSheetView {

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
                    GridItem(.flexible()),
                    GridItem(.flexible())
                ],
                spacing: 10
            ) {

                ForEach(options, id: \.self) { option in
                    Button {
                        if selection.wrappedValue == option {
                            selection.wrappedValue = nil   // 同じ場所を押したら解除
                        } else {
                            selection.wrappedValue = option
                        }
                    } label: {
                        HStack(spacing: 6) {
                            Image(
                                systemName:
                                    selection.wrappedValue == option
                                    ? "record.circle.fill"
                                    : "circle"
                            )

                            .padding(.top, 2)
                            
                            Text(option)
                                .font(.caption)
                                .multilineTextAlignment(.leading)
                                .lineLimit(2)
                                .fixedSize(horizontal: false, vertical: true)
                            
                            Spacer()
                        }
                        .foregroundStyle(
                            selection.wrappedValue == option
                            ? .white
                            : .primary
                        )
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .frame(minHeight: 30)
                        .padding(.horizontal, 10)
                        .padding(.vertical, 8)
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
    
    func otherField(
        text: Binding<String>
    ) -> some View {

        TextField("その他", text: text)
            .padding()
            .background(
                RoundedRectangle(cornerRadius: 12)
                    .fill(Color.gray.opacity(0.06))
            )
    }
}

final class RedWineLocationManager:
    NSObject,
    ObservableObject,
    CLLocationManagerDelegate {

    private let manager = CLLocationManager()

    @Published var location: CLLocation?

    override init() {

        super.init()

        manager.delegate = self
        manager.requestWhenInUseAuthorization()
        manager.startUpdatingLocation()
    }

    func locationManager(
        _ manager: CLLocationManager,
        didUpdateLocations locations: [CLLocation]
    ) {
        location = locations.first
    }
}



//
//  OrangeWineTastingSheetView.swift
//  TastingApp
//
//  Created by 佐々木 勇太 on 2026/07/30.
//
import SwiftUI
import PhotosUI
import CoreLocation
import Combine
import Vision

struct OrangeWineTastingSheetView: View {

    @Bindable var wine: orangeWine
    @State private var selectedItem: PhotosPickerItem?
    @State private var ocrSelectedItem: PhotosPickerItem?

    @StateObject private var locationManager =
        OrangeWineLocationManager()
    
    @State private var showMapPicker = false
    @State private var selectedItems: [PhotosPickerItem] = []
    @State private var selectedFullScreenImage: UIImage?
    @State private var showFullScreenImage = false
    
    // 削除時のダイアログ
    @State private var showDeleteAlert = false
    @State private var imageIndexToDelete: Int?
    
    // OCR
    @State private var showOCRMenu = false
    @State private var showCamera = false
    @State private var showPhotoPicker = false
    @State private var capturedImage: UIImage?
    
    @State private var ocrName = ""
    @State private var ocrVintage = ""
    @State private var ocrCountry = ""
    @State private var ocrGrape = ""

    @State private var showOCRResultSheet = false
    
    @State private var applyName = true
    @State private var applyVintage = true
    @State private var applyCountry = true
    @State private var applyGrape = true

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
                    
                    headerView
                    
                    sectionCard(
                        number: "1",
                        title: "外観",
                        english: "APPEARANCE"
                    ) {
                        
                        tastingScaleRow(
                            title: "清澄度",
                            selection: $wine.claritys,
                            options: [
                                "澄んだ",
                                "やや濁った",
                                "濁った",
                            ]
                        )
                        
                        otherField(text: $wine.clarityOther)
                        
                        Divider()
                            .padding(.vertical, 4)
                        
                        tastingScaleRow(
                            title: "輝き",
                            selection: $wine.brightnesss,
                            options: [
                                "輝きのある",
                                "ややくすんだ",
                                "落ち着いた",
                                "モヤがかった",
                            ]
                        )
                        
                        otherField(text: $wine.brightnessOther)
                        
                        Divider()
                            .padding(.vertical, 4)
                        
                        tastingScaleRow(
                            title: "色調（補助用語）",
                            selection: $wine.colorTones,
                            options: [
                                "黄色がかった",
                                "黄金色がかった",
                                "オレンジがかった",
                                "赤みがかった",
                                "褐色がかった"
                            ]
                        )
                        
                        otherField(text: $wine.colorToneOther)
                        
                        tastingScaleRow(
                            title: "色調（メイン用語）",
                            selection: $wine.colors,
                            options: [
                                "イエロー",
                                "黄金色",
                                "濃い黄金色",
                                "オレンジ",
                                "アンバー",
                                "琥珀色",
                                "褐色",
                            ]
                        )
                        
                        otherField(text: $wine.colorOther)
                        
                        Divider()
                            .padding(.vertical, 4)
                        
                        tastingScaleRow(
                            title: "濃淡",
                            selection: $wine.densitys,
                            options: [
                                "淡い",
                                "やや淡い",
                                "中程度",
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
                            selection: $wine.viscositys,
                            options: [
                                "さらっとした",
                                "適度な",
                                "やや強い",
                                "強い",
                                "ねっとりとした",
                            ]
                        )
                        
                        otherField(text: $wine.viscosityOther)
                        
                        Divider()
                            .padding(.vertical, 4)
                        
                        tastingScaleRow(
                            title: "外観の印象",
                            selection: $wine.youthfulnesss,
                            options: [
                                "若々しい",
                                "フレッシュな",
                                "やや発展した",
                                "熟成感がある",
                                "酸化のニュアンスがある",
                                "熟成した"
                            ]
                        )
                        
                        otherField(text: $wine.youthfulnessOther)
/*
                        tastingScaleRow(
                            title: "外観の印象（成熟度）",
                            selection: $wine.maturitys,
                            options: [
                                "軽快な",
                                "成熟度が高い",
                                "濃縮感がある",
                            ]
                        )
                        
                        otherField(text: $wine.maturityOther)
                        
                        tastingScaleRow(
                            title: "外観の印象（発泡性）",
                            selection: $wine.effervescences,
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
                            selection: $wine.firstImpIntensitys,
                            options: [
                                "閉じている",
                                "控えめ",
                                "開いている",
                                "力強い",
                            ]
                        )
                        
                        otherField(text: $wine.firstImpIntensityOther)
                        
                        tastingScaleRow(
                            title: "第一印象（性質）",
                            selection: $wine.firstImpCharacters,
                            options: [
                                "フレッシュな",
                                "フルーティーな",
                                "華やかな",
                                "ハーバルな",
                                "スパイシーな",
                                "セイボリーな",
                                "ミネラリー",
                                "複雑な",
                                "野性的な",
                            ]
                        )
                        
                        otherField(text: $wine.firstImpCharacterOther)
                        
                        Divider()
                            .padding(.vertical, 4)
                        
                        tastingScaleRow(
                            title: "果実",
                            selection: $wine.fruits,
                            options: [
                                "柑橘類",
                                "オレンジピール",
                                "レモンピール",
                                "リンゴ",
                                "洋梨",
                                "アプリコット",
                                "桃",
                                "柿",
                                "ドライアプリコット",
                                "ドライオレンジ",
                                "干しブドウ",
                                "赤い果実",
                            ]
                        )
                        
                        otherField(text: $wine.fruitOther)
                        
                        Divider()
                            .padding(.vertical, 4)
                        
                        tastingScaleRow(
                            title: "花・植物（花）",
                            selection: $wine.plantFlowers,
                            options: [
                                "オレンジの花",
                                "白い花",
                                "バラ",
                                "金木犀",
                                "カモミール",
                                "ドライフラワー",
                                "花の蜜",
                            ]
                        )
                        
                        otherField(text: $wine.plantFlowerOther)
                        
                        tastingScaleRow(
                            title: "花・植物（ハーブ）",
                            selection: $wine.plantHerbs,
                            options: [
                                "ミント",
                                "タイム",
                                "ローズマリー",
                                "フェンネル",
                                "アニス",
                                "ヴェルヴェーヌ",
                                "ハーブ",
                                "茶葉",
                            ]
                        )
                        
                        otherField(text: $wine.plantHerbOther)
                        
                        tastingScaleRow(
                            title: "ナッツ・種子",
                            selection: $wine.plantNutss,
                            options: [
                                "アーモンド",
                                "ヘーゼルナッツ",
                                "クルミ",
                                "栗",
                                "胡麻"
                            ]
                        )
                        
                        otherField(text: $wine.plantNutsOther)
                        
                        Divider()
                            .padding(.vertical, 4)
                        
                        tastingScaleRow(
                            title: "ミネラル",
                            selection: $wine.spiceMinerals,
                            options: [
                                "石灰",
                                "火打石",
                                "貝殻",
                                "鉱物",
                                "海の香り",
                                "土壌",
                            ]
                        )
/*
                        otherField(text: $wine.spiceMineralOther)
                        
                        tastingScaleRow(
                            title: "香辛料・芳香・化学物質（樽）",
                            selection: $wine.spicsOaks,
                            options: [
                                "トースト",
                                "ヴァニラ",
                                "煙",
                                "薫製"
                            ]
                        )
                        
                        otherField(text: $wine.spicsOakOther)
   */
                        tastingScaleRow(
                            title: "スパイス",
                            selection: $wine.spiceSpices,
                            options: [
                                "白胡椒",
                                "黒胡椒",
                                "コリアンダー",
                                "シナモン",
                                "ジンジャー",
                                "クローブ",
                                "香木",
                            ]
                        )
                        
                        otherField(text: $wine.spiceSpiceOther)
                        
                        tastingScaleRow(
                            title: "発酵・醸造由来",
                            selection: $wine.spiceOtherss,
                            options: [
                                "酵母",
                                "パン・ド・ミ",
                                "乳製品",
                                "ヨーグルト",
                                "発酵香",
                                "フェノール",
                                "蜜蝋",
                                "ワックス",
                            ]
                        )
                        
                        otherField(text: $wine.spiceOthersOther)
                        
                        Divider()
                            .padding(.vertical, 4)
                        
                        tastingScaleRow(
                            title: "熟成・酸化由来",
                            selection: $wine.spiceMaturitys,
                            options: [
                                "若々しい",
                                "熟成感がある",
                                "蜂蜜",
                                "ナッツ",
                                "紅茶",
                                "ドライフルーツ",
                                "酸化熟成のニュアンス"
                            ]
                        )
                        
                        otherField(text: $wine.spiceMaturityOther)
                        
                        tastingScaleRow(
                            title: "香りの特性",
                            selection: $wine.spiceCharacteristics,
                            options: [
                                "第1アロマが強い",
                                "第2アロマが強い",
                                "果皮由来の香りがある",
                                "フェノール香がある",
                                "酸化ニュアンスがある",
                                "木樽からのニュアンス",
                                "複雑な",
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
                            selection: $wine.attacks,
                            options: [
                                "軽い",
                                "やや軽い",
                                "中程度",
                                "やや強い",
                                "強い",
                                "インパクトのある",
                            ]
                        )
                        
                        otherField(text: $wine.attackOther)
                        
                        Divider()
                            .padding(.vertical, 4)
                        
                        tastingScaleRow(
                            title: "甘味",
                            selection: $wine.sweetnesss,
                            options: [
                                "ドライ",
                                "ややドライ",
                                "中程度",
                                "やや甘味を感じる",
                                "甘味が豊か",
                            ]
                        )
                        
                        otherField(text: $wine.sweetnessOther)
                        
                        Divider()
                            .padding(.vertical, 4)
                        
                        tastingScaleRow(
                            title: "酸味",
                            selection: $wine.aciditys,
                            options: [
                                "穏やかな",
                                "なめらかな",
                                "軽やかな",
                                "爽やかな",
                                "はつらつとした",
                                "力強い",
                                "直線的",
                                "堅固な",
                            ]
                        )
                        
                        otherField(text: $wine.acidityOther)
                        
                        Divider()
                            .padding(.vertical, 4)
                        
                        tastingScaleRow(
                            title: "タンニン",
                            selection: $wine.bitternesss,
                            options: [
                                "ほとんど感じない",
                                "控えめ",
                                "穏やかな",
                                "やや収斂する",
                                "しっかりした",
                                "強い",
                                "力強い",
                            ]
                        )
                        
                        otherField(text: $wine.bitternessOther)
                        
                        Divider()
                            .padding(.vertical, 4)
                        
                        tastingScaleRow(
                            title: "果実味",
                            selection: $wine.balanceTopLefts,
                            options: [
                                "控えめ",
                                "軽やかな",
                                "中程度",
                                "豊かな",
                                "ジューシーな",
                                "濃厚な",
                                "凝縮感のある",
                            ]
                        )
                        
                        otherField(text: $wine.balanceTopLeftOther)
                        
                        Divider()
                            .padding(.vertical, 4)
                        
                        tastingScaleRow(
                            title: "ボディ",
                            selection: $wine.balanceTopRights,
                            options: [
                                "ライト",
                                "ややライト",
                                "ミディアム",
                                "ややフル",
                                "フル",
                            ]
                        )
                        
                        otherField(text: $wine.balanceTopRightOther)
                        
                        Divider()
                            .padding(.vertical, 4)
                        
                        tastingScaleRow(
                            title: "バランス",
                            selection: $wine.balanceBottomLefts,
                            options: [
                                "フレッシュな",
                                "スリムな",
                                "ドライな",
                                "ジューシーな",
                                "豊かな",
                                "厚みのある",
                                "まろやかな",
                                "複雑な",
                                "調和のとれた",
                            ]
                        )
                        
                        otherField(text: $wine.balanceBottomLeftOther)
/*
                        tastingScaleRow(
                            title: "バランス（右下）",
                            selection: $wine.balanceBottmRights,
                            options: [
                                "まろやかな",
                                "ねっとりした",
                            ]
                        )
                        
                        otherField(text: $wine.balanceBottmRightOther)
 */
                        Divider()
                            .padding(.vertical, 4)
                        
                        tastingScaleRow(
                            title: "アルコール",
                            selection: $wine.alcohols,
                            options: [
                                "11%未満",
                                "11%～12%未満",
                                "12%～13%未満",
                                "13%～14%未満",
                                "14%以上",
                            ]
                        )
                        
                        otherField(text: $wine.alcoholOther)
                        
                        Divider()
                            .padding(.vertical, 4)
                        
                        tastingScaleRow(
                            title: "余韻",
                            selection: $wine.finishs,
                            options: [
                                "短い",
                                "やや短い",
                                "中程度",
                                "やや長い",
                                "長い",
                                "非常に長い",
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
                            selection: $wine.evaluations,
                            options: [
                                "軽快でフレッシュ",
                                "フルーティーでジューシー",
                                "ドライでミネラリー",
                                "タンニンが心地よい",
                                "複雑で奥行きがある",
                                "旨味が豊かな",
                                "力強く個性的",
                                "熟成による複雑性がある",
                                "非常に長い余韻",
                            ]
                        )
                        
                        otherField(text: $wine.evaluationOther)
                        
                        Divider()
                            .padding(.vertical, 4)
                        
                        tastingScaleRow(
                            title: "適正温度",
                            selection: $wine.eervingTemperatures,
                            options: [
                                "8～10度",
                                "10～12度",
                                "12～14度",
                                "14～16度",
                                "16度以上",
                            ]
                        )
                        
                        otherField(text: $wine.eervingTemperatureOther)
                        
                        Divider()
                            .padding(.vertical, 4)
                        
                        tastingScaleRow(
                            title: "グラス",
                            selection: $wine.glasss,
                            options: [
                                "小ぶり",
                                "中庸",
                                "大ぶり",
                                "チューリップ型",
                                "白ワイン用大ぶりグラス",
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
        .photosPicker(
            isPresented: $showPhotoPicker,
            selection: $ocrSelectedItem,
            matching: .images
        )
        
        .onAppear {
            wine.chartLocked = true
            wine.migrateSelections()
        }
        
        .onChange(of: selectedItem) {
            Task {
                if let data = try? await selectedItem?
                    .loadTransferable(type: Data.self) {
                    wine.imageData = data
                }

                selectedItem = nil
            }
        }
        
        .onChange(of: ocrSelectedItem) {

            Task {
                if let data = try? await ocrSelectedItem?
                .loadTransferable(type: Data.self),
                let image = UIImage(data: data) {
                    recognizeWineLabel(
                        image: image
                    )
                }

                ocrSelectedItem = nil
            }
        }
        
        .onChange(of: selectedItems) {

            Task {

                for item in selectedItems {

                    if let data = try? await item.loadTransferable(type: Data.self) {

                        wine.subImagesData.append(data)
                    }
                }

                selectedItems.removeAll()
            }
        }
        
        .sheet(isPresented: $showMapPicker) {

            MapLocationPickerView(
                latitude: $wine.latitude,
                longitude: $wine.longitude
            )
        }
        
        .alert(
            "画像を削除しますか？",
            isPresented: $showDeleteAlert
        ) {

            Button("削除", role: .destructive) {

                if let index = imageIndexToDelete,
                   wine.subImagesData.indices.contains(index) {

                    wine.subImagesData.remove(at: index)
                }

                imageIndexToDelete = nil
            }

            Button("キャンセル", role: .cancel) {

                imageIndexToDelete = nil
            }

        } message: {

            Text("このワインの写真を削除します。\nこの操作は取り消せません。")
        }
        
        .overlay {

            if showFullScreenImage,
               let image = selectedFullScreenImage {

                ZStack {

                    Color.black
                        .ignoresSafeArea()
                        .opacity(0.95)
                        .onTapGesture {
                            withAnimation(.easeInOut) {
                                showFullScreenImage = false
                            }
                        }

                    ZoomableImageView(image: image)

                    VStack {

                        HStack {

                            Spacer()

                            Button {

                                withAnimation(.easeInOut) {
                                    showFullScreenImage = false
                                }

                            } label: {

                                Image(systemName: "xmark.circle.fill")
                                    .font(.system(size: 34))
                                    .foregroundStyle(.white)
                            }
                            .padding()
                        }

                        Spacer()
                    }
                }
                .transition(.opacity)
                .zIndex(999)
            }
        }
        .animation(.easeInOut(duration: 0.2), value: showFullScreenImage)
        .confirmationDialog(
            "ラベル画像の取得方法",
            isPresented: $showOCRMenu
        ) {

            Button("カメラで撮影") {
                showCamera = true
            }

            Button("写真ライブラリから選択") {
                showPhotoPicker = true
            }

            Button(
                "キャンセル",
                role: .cancel
            ) {}
        }
        .sheet(isPresented: $showCamera) {

            CameraPicker(
                image: $capturedImage
            )
        }
        .onChange(of: capturedImage) { _, image in

            guard let image else {
                return
            }

            recognizeWineLabel(
                image: image
            )
        }
        .overlay {

            if showOCRResultSheet {

                Color.black
                    .opacity(0.35)
                    .ignoresSafeArea()
                    .onTapGesture {
                        showOCRResultSheet = false
                    }

                OCRResultCard()
            }
        }
    }
    
    func recognizeWineLabel(
        image: UIImage
    ) {
        applyName = true
        applyVintage = true
        applyCountry = true
        applyGrape = true

        ocrName = ""
        ocrVintage = ""
        ocrCountry = ""
        ocrGrape = ""
        
        guard let cgImage =
            image.cgImage
        else {
            return
        }

        let request = VNRecognizeTextRequest { request, error in

            guard let observations =
                    request.results as? [VNRecognizedTextObservation]
            else {
                return
            }

            let recognizedText = observations.compactMap {
                $0.topCandidates(1).first?.string
            }
            .joined(separator: "\n")

            DispatchQueue.main.async {

                print(recognizedText)

                let result = WineOCRParser.parse(
                    from: recognizedText
                )

                ocrName = result.name
                ocrVintage = result.vintage
                ocrCountry = result.productionArea
                ocrGrape = result.grape

                showOCRResultSheet = true
            }
        }

        request.recognitionLevel = .accurate
        request.recognitionLanguages = [
            "ja-JP",
            "en-US",
            "fr-FR",
            "it-IT",
            "es-ES"
        ]

        DispatchQueue.global(qos: .userInitiated).async {

            let handler = VNImageRequestHandler(
                cgImage: cgImage,
                options: [:]
            )

            try? handler.perform([request])
        }
    }
    
    func applyOCRResults() {

        if applyName && !ocrName.isEmpty {
            wine.name = ocrName
        }

        if applyVintage && !ocrVintage.isEmpty {
            wine.vintage = ocrVintage
        }

        if applyCountry && !ocrCountry.isEmpty {
            wine.country = ocrCountry
        }

        if applyGrape && !ocrGrape.isEmpty {
            wine.grape = ocrGrape
        }

        showOCRResultSheet = false
    }
    
    func OCRResultCard() -> some View {

        VStack(spacing: 20) {

            Text("OCR認識結果")
                .font(.headline)

            if !ocrName.isEmpty {
                Toggle("ワイン名\n\(ocrName)", isOn: $applyName)
            }

            if !ocrVintage.isEmpty {
                Toggle("ヴィンテージ\n\(ocrVintage)", isOn: $applyVintage)
            }

            if !ocrCountry.isEmpty {
                Toggle("生産地\n\(ocrCountry)", isOn: $applyCountry)
            }

            if !ocrGrape.isEmpty {
                Toggle("品種\n\(ocrGrape)", isOn: $applyGrape)
            }

            Divider()

            HStack {

                Button("キャンセル") {
                    showOCRResultSheet = false
                }

                Spacer()

                Button("反映する") {
                    applyOCRResults()
                }
                .buttonStyle(.borderedProminent)
            }
        }
        .padding(24)
        .frame(maxWidth: 350)
        .background(.white)
        .clipShape(
            RoundedRectangle(
                cornerRadius: 24
            )
        )
        .shadow(radius: 20)
    }
}

// MARK: - Header

extension OrangeWineTastingSheetView {

    var headerView: some View {

        VStack(alignment: .leading, spacing: 18) {

            if let image = wine.image {

                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
                    .frame(maxWidth: .infinity)
                    .frame(height: 220)
                    .background(Color(.systemGray6))
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                    .onTapGesture {
                        selectedFullScreenImage = image
                        withAnimation(.easeInOut) {
                            showFullScreenImage = true
                        }
                    }

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
            
            PhotosPicker(
                selection: $selectedItems,
                matching: .images
            ) {
                Label("追加画像", systemImage: "photo.on.rectangle")
            }

            // 画像複数枚登録する
            if !wine.subImages.isEmpty {

                ScrollView(.horizontal, showsIndicators: false) {

                    HStack(spacing: 12) {

                        ForEach(Array(wine.subImages.enumerated()), id: \.offset) { index, image in

                            ZStack(alignment: .topTrailing) {

                                Image(uiImage: image)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 140, height: 140)
                                    .onTapGesture {
                                        selectedFullScreenImage = image
                                        withAnimation(.easeInOut) {
                                            showFullScreenImage = true
                                        }
                                    }

                                Button {
                                    imageIndexToDelete = index
                                    showDeleteAlert = true

                                } label: {

                                    Image(systemName: "trash.circle.fill")
                                        .font(.system(size: 22))
                                        .foregroundStyle(.white, Color.black.opacity(0.65))
                                }
                            }
                        }
                    }
                    .padding(.horizontal, 4)
                    .padding(.top, 8)
                }
            }
            
            // OCR
            Button {
                showOCRMenu = true
            } label: {
                Label(
                    "AIラベル認識",
                    systemImage: "text.viewfinder"
                )
            }
            .buttonStyle(.borderedProminent)
            .tint(accent)
            
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

extension OrangeWineTastingSheetView {

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

extension OrangeWineTastingSheetView {

    func tastingScaleRow(
        title: String,
        selection: Binding<[String]>,
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
                        if selection.wrappedValue.contains(option) {
                            selection.wrappedValue.removeAll { $0 == option }
                        } else {
                            selection.wrappedValue.append(option)
                        }
                    } label: {
                        HStack(spacing: 6) {
                            Image(
                                systemName:
                                    selection.wrappedValue.contains(option)
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
                            selection.wrappedValue.contains(option)
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
                                    selection.wrappedValue.contains(option)
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
    
    struct ZoomableImageView: View {

        let image: UIImage

        @State private var scale: CGFloat = 1
        @State private var lastScale: CGFloat = 1

        @State private var offset: CGSize = .zero
        @State private var lastOffset: CGSize = .zero

        var body: some View {

            GeometryReader { geo in

                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
                    .scaleEffect(scale)
                    .offset(offset)
                    .simultaneousGesture(

                        MagnificationGesture()

                            .onChanged { value in

                                scale = lastScale * value
                            }

                            .onEnded { _ in

                                if scale < 1 {
                                    scale = 1
                                }

                                if scale > 5 {
                                    scale = 5
                                }

                                lastScale = scale
                            }
                    )
                    // ドラッグ
                    .simultaneousGesture(

                        DragGesture()

                            .onChanged { value in

                                if scale > 1 {

                                    offset = CGSize(
                                        width: lastOffset.width + value.translation.width,
                                        height: lastOffset.height + value.translation.height
                                    )
                                }
                            }

                            .onEnded { _ in

                                lastOffset = offset
                            }
                    )

                    // ダブルタップ
                    .onTapGesture(count: 2) {

                        withAnimation {

                            if scale == 1 {

                                scale = 3
                                lastScale = 3

                            } else {

                                scale = 1
                                lastScale = 1
                                offset = .zero
                                lastOffset = .zero
                            }
                        }
                    }

                    .frame(
                        width: geo.size.width,
                        height: geo.size.height
                    )
            }
        }
    }
}

final class OrangeWineLocationManager:
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

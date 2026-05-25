//
//  WhiteWineTastingListView.swift
//  TASTingNote
//
//  Created by 佐々木 勇太 on 2026/05/15.
//

import SwiftUI
import SwiftData
import PhotosUI

@Model
class Wine {

    // 基本データ
    var imageData: Data?                    // ワイン画像
    var name: String                        // ワイン名
    var isFavorite = false                  // お気に入り
    var tastingDate: Date = Date()          // 試飲日
    var rating: Int                         // 評価
    var comment: String                     // コメント
    
    // MARK: 外観
    var clarity: String?                    // 清澄度
    var appearance = ""                     // その他
    var brightness: String?                 // 輝き
    var colorTone: String?                  // 色調（補助用語）
    var color: String?                      // 色調（メイン用語）
    var density: String?                    // 濃淡
    var viscosity: String?                  // 粘性
    var youthfulness: String?               // 外観の印象（若さ）
    var maturity: String?                   // 外観の印象（成熟度）
    var effervescence: String?              // 外観の印象（発泡性）

    // MARK: 香り
    var firstImpIntensity: String? = nil    // 第一印象（強さ）
    var firstImpCharacter: String? = nil    // 第一印象（性質）
    var fruit: String? = nil                // 果実
    var plantFlower: String? = nil          // 花・植物（花）
    var plantHerb: String? = nil            // 花・植物（ハーブ）
    var plantNuts: String? = nil            // 花・植物（ナッツ）
    var spiceMineral: String? = nil         // 香辛料・芳香・化学物質（ミネラル）
    var spicsOak: String? = nil             // 香辛料・芳香・化学物質（樽）
    var spiceSpice: String? = nil           // 香辛料・芳香・化学物質（香辛料）
    var spiceOthers: String? = nil          // 香辛料・芳香・化学物質（他）
    var spiceMaturity: String? = nil        // 香りの印象（熟成感）
    var spiceCharacteristic: String? = nil  // 香りの印象（特性）

    // MARK: 味わい
    var attack: String? = nil               // アタック
    var sweetness: String? = nil            // 甘味
    var acidity: String? = nil              // 酸味
    var bitterness: String? = nil           // 苦味
    var balanceBottomLeft: String? = nil    // バランンス（左下）
    var balanceTopLeft: String? = nil       // バランンス（左上）
    var balanceTopRight: String? = nil      // バランンス（右上）
    var balanceBottmRight: String? = nil    // バランンス（右下）
    var alcohol: String? = nil              // アルコール
    var finish: String? = nil               // 余韻

    // MARK: 結論
    var evaluation: String? = nil           // 評価
    var eervingTemperature: String? = nil   // 適正温度
    var glass: String? = nil                // グラス
    var vintage = ""                        // 収穫年
    var country = ""                        // 生産地
    var grape = ""                          // 主なブドウ品種


    init(
        // 基本データ
        imageData: Data? = nil,
        name: String,
        isFavorite: Bool = false,
        tastingDate: Date = Date(),
        rating: Int = 0,
        comment: String = "",
        // MARK: 外観
        clarity: String? = nil,
        appearance: String = "",
        brightness: String? = nil,
        colorTone: String? = "",
        color: String? = "",
        density: String? = "",
        viscosity: String? = "",
        youthfulness: String? = nil,
        maturity: String? = nil,
        effervescence: String? = nil,
        // MARK: 香り
        firstImpIntensity: String? = "",
        firstImpCharacter: String? = "",
        fruit: String? = "",
        plantFlower: String? = "",
        plantHerb: String? = "",
        plantNuts: String? = "",
        spiceMineral: String? = "",
        spicOak: String? = "",
        spiceSpice: String? = "",
        spiceOthers: String? = "",
        spiceMaturity: String? = "",
        spiceCharacteristic: String? = "",
        // MARK: 味わい
        attack: String? = "",
        sweetness: String? = "",
        acidity: String? = "",
        bitterness: String? = "",
        balanceBottomLeft: String? = "",
        balanceTopLeft: String? = "",
        balanceTopRight: String? = "",
        balanceBottmRight: String? = "",
        alcohol: String? = "",
        finish: String? = "",
        // MARK: 結論
        evaluation: String? = "",
        ervingTemperature: String? = "",
        glass: String? = "",
        vintage: String = "",
        country: String = "",
        grape: String = "",
    ) {
        // 基本データ
        self.imageData = imageData
        self.name = name
        self.isFavorite = isFavorite
        self.tastingDate = tastingDate
        self.rating = rating
        self.comment = comment
        // MARK: 外観
        self.clarity = clarity
        self.appearance = appearance
        self.brightness = brightness
        self.colorTone = colorTone
        self.color = color
        self.density = density
        self.viscosity = viscosity
        self.youthfulness = youthfulness
        self.maturity = maturity
        self.effervescence = effervescence
        // MARK: 香り
        self.firstImpIntensity = firstImpIntensity
        self.firstImpCharacter = firstImpCharacter
        self.fruit = fruit
        self.plantFlower = plantFlower
        self.plantHerb = plantHerb
        self.plantNuts = plantNuts
        self.spiceMineral = spiceMineral
        self.spicsOak = spicsOak
        self.spiceSpice = spiceSpice
        self.spiceOthers = spiceOthers
        self.spiceMaturity = spiceMaturity
        self.spiceCharacteristic = spiceCharacteristic
        // MARK: 味わい
        self.attack = attack
        self.sweetness = sweetness
        self.acidity = acidity
        self.bitterness = bitterness
        self.balanceBottomLeft = balanceBottomLeft
        self.balanceTopLeft = balanceTopLeft
        self.balanceTopRight = balanceTopRight
        self.balanceBottmRight = balanceBottmRight
        self.alcohol = alcohol
        self.finish = finish
        // MARK: 結論
        self.evaluation = evaluation
        self.eervingTemperature = ervingTemperature
        self.glass = glass
        self.vintage = vintage
        self.country = country
        self.grape = grape
    }

    var image: UIImage? {
        guard let imageData else { return nil }
        return UIImage(data: imageData)
    }
}

struct WhiteWineTastingListView: View {
    @State private var searchText = ""
    @State private var showAddScreen = false

    @Query private var wines: [Wine]

    @Environment(\.modelContext)
    private var context

    var body: some View {
        VStack{
            NavigationView {
                List {
                    ForEach(wines) { wine in
                        NavigationLink {
                            WhiteWineTastingSheetView(wine: wine)
                        } label: {
                            HStack(spacing: 16) {
                                if let image = wine.image {
                                    Image(uiImage: image)
                                        .resizable()
                                        .scaledToFill()
                                        .frame(width: 80, height: 60)
                                        .clipShape(
                                            RoundedRectangle(cornerRadius: 12)
                                        )
                                } else {
                                    RoundedRectangle(cornerRadius: 12)
                                        .fill(Color.gray.opacity(0.15))
                                        .frame(width: 80, height: 60)
                                        .overlay {
                                            Image(systemName: "wineglass")
                                                .font(.title2)
                                                .foregroundColor(.gray)
                                        }
                                }

                                VStack(alignment: .leading) {
                                    Text(wine.name)
                                        .font(.headline)
                                    Text("白ワイン")
                                        .font(.caption)
                                        .foregroundColor(.secondary)
                                }
                            }
                            .padding(.vertical, 6)
                        }
                    }
                    .onDelete(perform: deleteWine)
                }
                .searchable(
                    text: $searchText,
                    prompt: "ワイン検索"
                )
                .navigationTitle("白ワイン")
                .toolbar {

                    ToolbarItem(placement: .topBarLeading) {
                        EditButton()
                    }

                    ToolbarItem(placement: .topBarTrailing) {
                        Button {
                            showAddScreen = true
                        } label: {
                            Image(systemName: "plus")
                        }
                    }
                }
                .sheet(isPresented: $showAddScreen) {
                    AddWineView()
                }
            }
        }
    }

    private func deleteWine(at offsets: IndexSet) {

        for index in offsets {

            let wine = wines[index]
            context.delete(wine)
        }

        try? context.save()
    }
}

struct AddWineView: View {
    @Environment(\.dismiss) private var dismiss
    @State private var wineName = ""
    @State private var selectedItem: PhotosPickerItem?
    @State private var selectedImage: UIImage?
    @Environment(\.modelContext)
    private var context

    var body: some View {
        NavigationStack {
            Form {
                Section("ワイン名") {
                    TextField(
                        "入力してください",
                        text: $wineName
                    )
                }

                Section("写真") {
                    if let selectedImage {
                        Image(uiImage: selectedImage)
                            .resizable()
                            .scaledToFill()
                            .frame(height: 220)
                            .clipShape(
                                RoundedRectangle(cornerRadius: 16)
                            )
                    }

                    PhotosPicker(
                        selection: $selectedItem,
                        matching: .images
                    ) {

                        Label(
                            "写真を選択",
                            systemImage: "photo"
                        )
                    }
                }
            }
            .navigationTitle("ワイン追加")
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button("キャンセル") {
                        dismiss()
                    }
                }

                ToolbarItem(placement: .topBarTrailing) {
                    Button("保存") {
                        let imageData = selectedImage?.jpegData(
                            compressionQuality: 0.8
                        )

                        let wine = Wine(
                            imageData: imageData,
                            name: wineName
                        )

                        context.insert(wine)
                        try? context.save()
                        dismiss()
                    }
                    .disabled(wineName.isEmpty)
                }
            }
            .onChange(of: selectedItem) {
                Task {
                    if let data = try? await selectedItem?.loadTransferable(type: Data.self),
                       let image = UIImage(data: data) {
                        selectedImage = image
                    }
                }
            }
        }
    }
}

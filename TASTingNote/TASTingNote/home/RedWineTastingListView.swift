//
//  RedWineTastingListView.swift
//  TASTingNote
//
//  Created by 佐々木 勇太 on 2026/05/13.
//

import SwiftUI
import SwiftData
import PhotosUI


@Model
class redWine {
    // 基本データ
    var imageData: Data?                        // ワイン画像
    var name: String                            // ワイン名
    var isFavorite = false                      // お気に入り
    var tastingDate: Date = Date()              // 試飲日
    var rating: Int                             // 評価
    var comment: String                         // コメント
    
    // チャート
    var chartX: Double?
    var chartY: Double?
    var chartLocked: Bool = true
    
    // 飲んだ場所
    var latitude: Double?
    var longitude: Double?
    var placeName: String = ""
    
    // MARK: 外観
    var clarity: String?                        // 清澄度
    var clarityOther = ""                       // 清澄度(その他)
    var brightness: String?                     // 輝き
    var brightnessOther = ""                    // 輝き(その他)
    var colorTone: String?                      // 色調（補助用語）
    var colorToneOther = ""                 // 色調（補助用語）(その他)
    var color: String?                          // 色調（メイン用語）
    var colorOther = ""                     // 色調（メイン用語）(その他)
    var density: String?                        // 濃淡
    var densityOther = ""                   // 濃淡(その他)
    var viscosity: String?                      // 粘性
    var viscosityOther = ""                 // 粘性(その他)
    var youthfulness: String?                   // 外観の印象（若さ）
    var youthfulnessOther = ""              // 外観の印象（若さ）(その他)
    var maturity: String?                       // 外観の印象（成熟度）
    var maturityOther = ""                  // 外観の印象（成熟度）(その他)
    var effervescence: String?                  // 外観の印象（発泡性）
    var effervescenceOther = ""             // 外観の印象（発泡性）(その他)

    // MARK: 香り
    var firstImpIntensity: String? = nil        // 第一印象（強さ）
    var firstImpIntensityOther = ""   // 第一印象（強さ）(その他)
    var firstImpCharacter: String? = nil        // 第一印象（性質）
    var firstImpCharacterOther = ""   // 第一印象（性質）(その他)
    var fruit: String? = nil                    // 果実
    var fruitOther = ""               // 果実(その他)
    var plantFlower: String? = nil              // 花・植物（花）
    var plantFlowerOther = ""         // 花・植物（花）(その他)
    var plantHerb: String? = nil                // 花・植物（ハーブ）
    var plantHerbOther = ""           // 花・植物（ハーブ）(その他)
    var plantNuts: String? = nil                // 花・植物（ナッツ）
    var plantNutsOther = ""           // 花・植物（ナッツ）(その他)
    var spiceMineral: String? = nil             // 香辛料・芳香・化学物質（ミネラル）
    var spiceMineralOther = ""        // 香辛料・芳香・化学物質（ミネラル）(その他)
    var spicsOak: String? = nil                 // 香辛料・芳香・化学物質（樽）
    var spicsOakOther = ""            // 香辛料・芳香・化学物質（樽）(その他)
    var spiceSpice: String? = nil               // 香辛料・芳香・化学物質（香辛料）
    var spiceSpiceOther = ""          // 香辛料・芳香・化学物質（香辛料）(その他)
    var spiceOthers: String? = nil              // 香辛料・芳香・化学物質（他）
    var spiceOthersOther = ""         // 香辛料・芳香・化学物質（他）(その他)
    var spiceMaturity: String? = nil            // 香りの印象（熟成感）
    var spiceMaturityOther = ""       // 香りの印象（熟成感）(その他)
    var spiceCharacteristic: String? = nil      // 香りの印象（特性）
    var spiceCharacteristicOther = "" // 香りの印象（特性）(その他)

    // MARK: 味わい
    var attack: String? = nil                   // アタック
    var attackOther = ""              // アタック(その他)
    var sweetness: String? = nil                // 甘味
    var sweetnessOther = ""           // 甘味(その他)
    var acidity: String? = nil                  // 酸味
    var acidityOther = ""             // 酸味(その他)
    var bitterness: String? = nil               // 苦味
    var bitternessOther = ""          // 苦味(その他)
    var balanceBottomLeft: String? = nil        // バランンス（左下）
    var balanceBottomLeftOther = ""   // バランンス（左下）(その他)
    var balanceTopLeft: String? = nil           // バランンス（左上）
    var balanceTopLeftOther = ""      // バランンス（左上）(その他)
    var balanceTopRight: String? = nil          // バランンス（右上）
    var balanceTopRightOther = ""     // バランンス（右上）(その他)
    var balanceBottmRight: String? = nil        // バランンス（右下）
    var balanceBottmRightOther = ""   // バランンス（右下）(その他)
    var alcohol: String? = nil                  // アルコール
    var alcoholOther = ""             // アルコール(その他)
    var finish: String? = nil                   // 余韻
    var finishOther = ""              // 余韻(その他)

    // MARK: 結論
    var evaluation: String? = nil               // 評価
    var evaluationOther = ""          // 評価(その他)
    var eervingTemperature: String? = nil       // 適正温度
    var eervingTemperatureOther = ""  // 適正温度(その他)
    var glass: String? = nil                    // グラス
    var glassOther = ""               // グラス(その他)
    var vintage = ""                            // 収穫年
    var country = ""                            // 生産地
    var grape = ""                              // 主なブドウ品種

    
    init(
        // 基本データ
        imageData: Data? = nil,
        name: String,
        isFavorite: Bool = false,
        tastingDate: Date = Date(),
        rating: Int = 0,
        comment: String = "",
        // チャート
        chartX: Double? = nil,
        chartY: Double? = nil,
        chartLocked:Bool = true,
        // 飲んだ場所
        latitude: Double? = nil,
        longitude: Double? = nil,
        placeName: String = "",
        // MARK: 外観
        clarity: String? = nil,
        clarityOther: String = "",
        brightness: String? = nil,
        brightnessOther: String = "",
        colorTone: String? = "",
        colorToneOther: String = "",
        color: String? = "",
        colorOther: String = "",
        density: String? = "",
        densityOther: String = "",
        viscosity: String? = "",
        viscosityOther: String = "",
        youthfulness: String? = nil,
        youthfulnessOther: String = "",
        maturity: String? = nil,
        maturityOther: String = "",
        effervescence: String? = nil,
        effervescenceOther: String = "",
        // MARK: 香り
        firstImpIntensity: String? = "",
        firstImpIntensityOther: String = "",
        firstImpCharacter: String? = "",
        firstImpCharacterOther: String = "",
        fruit: String? = "",
        fruitOther: String = "",
        plantFlower: String? = "",
        plantFlowerOther: String = "",
        plantHerb: String? = "",
        plantHerbOther: String = "",
        plantNuts: String? = "",
        plantNutsOther: String = "",
        spiceMineral: String? = "",
        spiceMineralOther: String = "",
        spicOak: String? = "",
        spicOakOther: String = "",
        spiceSpice: String? = "",
        spiceSpiceOther: String = "",
        spiceOthers: String? = "",
        spiceOthersOther: String = "",
        spiceMaturity: String? = "",
        spiceMaturityOther: String = "",
        spiceCharacteristic: String? = "",
        spiceCharacteristicOther: String = "",
        // MARK: 味わい
        attack: String? = "",
        attackOther: String = "",
        sweetness: String? = "",
        sweetnessOther: String = "",
        acidity: String? = "",
        acidityOther: String = "",
        bitterness: String? = "",
        bitternessOther: String = "",
        balanceBottomLeft: String? = "",
        balanceBottomLeftOther: String = "",
        balanceTopLeft: String? = "",
        balanceTopLeftOther: String = "",
        balanceTopRight: String? = "",
        balanceTopRightOther: String = "",
        balanceBottmRight: String? = "",
        balanceBottmRightOther: String = "",
        alcohol: String? = "",
        alcoholOther: String = "",
        finish: String? = "",
        finishOther: String = "",
        // MARK: 結論
        evaluation: String? = "",
        evaluationOther: String = "",
        ervingTemperature: String? = "",
        ervingTemperatureOther: String = "",
        glass: String? = "",
        glassOther: String = "",
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
        // チャート
        self.chartX = chartX
        self.chartY = chartY
        self.chartLocked = chartLocked
        // 飲んだ場所
        self.latitude = latitude
        self.longitude = longitude
        self.placeName = placeName
        // MARK: 外観
        self.clarity = clarity
        self.clarityOther = clarityOther
        self.brightness = brightness
        self.brightnessOther = brightnessOther
        self.colorTone = colorTone
        self.colorToneOther = colorToneOther
        self.color = color
        self.colorOther = colorOther
        self.density = density
        self.densityOther = densityOther
        self.viscosity = viscosity
        self.viscosityOther = viscosityOther
        self.youthfulness = youthfulness
        self.youthfulnessOther = youthfulnessOther
        self.maturity = maturity
        self.maturityOther = maturityOther
        self.effervescence = effervescence
        self.effervescenceOther = effervescenceOther
        // MARK: 香り
        self.firstImpIntensity = firstImpIntensity
        self.firstImpIntensityOther = firstImpIntensityOther
        self.firstImpCharacter = firstImpCharacter
        self.firstImpCharacterOther = firstImpCharacterOther
        self.fruit = fruit
        self.fruitOther = fruitOther
        self.plantFlower = plantFlower
        self.plantFlowerOther = plantFlowerOther
        self.plantHerb = plantHerb
        self.plantHerbOther = plantHerbOther
        self.plantNuts = plantNuts
        self.plantNutsOther = plantNutsOther
        self.spiceMineral = spiceMineral
        self.spiceMineralOther = spiceMineralOther
        self.spicsOak = spicsOak
        self.spicsOakOther = spicsOakOther
        self.spiceSpice = spiceSpice
        self.spiceSpiceOther = spiceSpiceOther
        self.spiceOthers = spiceOthers
        self.spiceOthersOther = spiceOthersOther
        self.spiceMaturity = spiceMaturity
        self.spiceMaturityOther = spiceMaturityOther
        self.spiceCharacteristic = spiceCharacteristic
        self.spiceCharacteristicOther = spiceCharacteristicOther
        // MARK: 味わい
        self.attack = attack
        self.attackOther = attackOther
        self.sweetness = sweetness
        self.sweetnessOther = sweetnessOther
        self.acidity = acidity
        self.acidityOther = acidityOther
        self.bitterness = bitterness
        self.bitternessOther = bitternessOther
        self.balanceBottomLeft = balanceBottomLeft
        self.balanceBottomLeftOther = balanceBottomLeftOther
        self.balanceTopLeft = balanceTopLeft
        self.balanceTopLeftOther = balanceTopLeftOther
        self.balanceTopRight = balanceTopRight
        self.balanceTopRightOther = balanceTopRightOther
        self.balanceBottmRight = balanceBottmRight
        self.balanceBottmRightOther = balanceBottmRightOther
        self.alcohol = alcohol
        self.alcoholOther = alcoholOther
        self.finish = finish
        self.finishOther = finishOther
        // MARK: 結論
        self.evaluation = evaluation
        self.evaluationOther = evaluationOther
        self.eervingTemperature = ervingTemperature
        self.eervingTemperatureOther = ervingTemperatureOther
        self.glass = glass
        self.glassOther = glassOther
        self.vintage = vintage
        self.country = country
        self.grape = grape
    }
    
    var image: UIImage? {
        guard let imageData else { return nil }
        return UIImage(data: imageData)
    }
}

struct RedWineTastingListView: View {
    @State private var searchText = ""
    @State private var showAddScreen = false

    @Query(
        sort: \redWine.tastingDate,
        order: .reverse
    )
    private var wines: [redWine]

    @Environment(\.modelContext)
    private var context
    
    // 検索用
    private var filteredWines: [redWine] {
        if searchText.isEmpty {
            return wines
        }

        return wines.filter {
            $0.name.localizedCaseInsensitiveContains(searchText)
        }
    }

    var body: some View {
        VStack{
            NavigationView {
                List {
                    ForEach(filteredWines) { wine in
                        NavigationLink {
                            RedWineTastingSheetView(wine: wine)
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

                                    Text(
                                        wine.tastingDate,
                                        format: .dateTime.year().month().day()
                                    )
                                    .font(.caption)
                                    .foregroundColor(.secondary)

                                    Text("白ワイン")
                                        .font(.caption2)
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
                    AddRedWineView()
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

struct AddRedWineView: View {
    @Environment(\.dismiss) private var dismiss
    @State private var wineName = ""
    @State private var selectedItem: PhotosPickerItem?
    @State private var selectedImage: UIImage?
    @State private var tastingDate = Date()
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
                
                Section("試飲日") {
                    DatePicker(
                        "試飲日",
                        selection: $tastingDate,
                        displayedComponents: .date
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

                        let wine = redWine(
                            imageData: imageData,
                            name: wineName,
                            tastingDate: tastingDate
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

//
//  SparklingWineTastingListView.swift
//  TastingApp
//
//  Created by 佐々木 勇太 on 2026/07/26.
//
import SwiftUI
import SwiftData
import PhotosUI

@Model
class spWine {
    // 基本データ
    var imageData: Data?                        // ワイン画像
    var subImagesData: [Data] = []              // 追加画像（複数）
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
    var claritys: [String] = []                        // 清澄度
    var clarityOther = ""                       // 清澄度(その他)
    var brightness: String?                     // 輝き
    var brightnesss: [String] = []                     // 輝き
    var brightnessOther = ""                    // 輝き(その他)
    var colorTone: String?                      // 色調（補助用語）
    var colorTones: [String] = []                      // 色調（補助用語）
    var colorToneOther = ""                 // 色調（補助用語）(その他)
    var color: String?                          // 色調（メイン用語）
    var colors: [String] = []                          // 色調（メイン用語）
    var colorOther = ""                     // 色調（メイン用語）(その他)
    var density: String?                        // 濃淡
    var densitys: [String] = []                        // 濃淡
    var densityOther = ""                   // 濃淡(その他)
    var viscosity: String?                      // 粘性
    var viscositys: [String] = []                      // 粘性
    var viscosityOther = ""                 // 粘性(その他)
    var youthfulness: String?                   // 外観の印象（若さ）
    var youthfulnesss: [String] = []                   // 外観の印象（若さ）
    var youthfulnessOther = ""              // 外観の印象（若さ）(その他)
    var maturity: String?                       // 外観の印象（成熟度）
    var maturitys: [String] = []                       // 外観の印象（成熟度）
    var maturityOther = ""                  // 外観の印象（成熟度）(その他)
    var effervescence: String?                  // 外観の印象（発泡性）
    var effervescences: [String] = []                  // 外観の印象（発泡性）
    var effervescenceOther = ""             // 外観の印象（発泡性）(その他)

    // MARK: 香り
    var firstImpIntensity: String? = nil        // 第一印象（強さ）
    var firstImpIntensitys: [String] = []        // 第一印象（強さ）
    var firstImpIntensityOther = ""   // 第一印象（強さ）(その他)
    var firstImpCharacter: String? = nil        // 第一印象（性質）
    var firstImpCharacters: [String] = []        // 第一印象（性質）
    var firstImpCharacterOther = ""   // 第一印象（性質）(その他)
    var fruit: String? = nil                    // 果実
    var fruits: [String] = []                    // 果実
    var fruitOther = ""               // 果実(その他)
    var plantFlower: String? = nil              // 花・植物（花）
    var plantFlowers: [String] = []              // 花・植物（花）
    var plantFlowerOther = ""         // 花・植物（花）(その他)
    var plantHerb: String? = nil                // 花・植物（ハーブ）
    var plantHerbs: [String] = []                // 花・植物（ハーブ）
    var plantHerbOther = ""           // 花・植物（ハーブ）(その他)
    var plantNuts: String? = nil                // 花・植物（ナッツ）
    var plantNutss: [String] = []                // 花・植物（ナッツ）
    var plantNutsOther = ""           // 花・植物（ナッツ）(その他)
    var spiceMineral: String? = nil             // 香辛料・芳香・化学物質（ミネラル）
    var spiceMinerals: [String] = []             // 香辛料・芳香・化学物質（ミネラル）
    var spiceMineralOther = ""        // 香辛料・芳香・化学物質（ミネラル）(その他)
    var spicsOak: String? = nil                 // 香辛料・芳香・化学物質（樽）
    var spicsOaks: [String] = []                 // 香辛料・芳香・化学物質（樽）
    var spicsOakOther = ""            // 香辛料・芳香・化学物質（樽）(その他)
    var spiceSpice: String? = nil               // 香辛料・芳香・化学物質（香辛料）
    var spiceSpices: [String] = []               // 香辛料・芳香・化学物質（香辛料）
    var spiceSpiceOther = ""          // 香辛料・芳香・化学物質（香辛料）(その他)
    var spiceOthers: String? = nil              // 香辛料・芳香・化学物質（他）
    var spiceOtherss: [String] = []              // 香辛料・芳香・化学物質（他）
    var spiceOthersOther = ""         // 香辛料・芳香・化学物質（他）(その他)
    var spiceMaturity: String? = nil            // 香りの印象（熟成感）
    var spiceMaturitys: [String] = []            // 香りの印象（熟成感）
    var spiceMaturityOther = ""       // 香りの印象（熟成感）(その他)
    var spiceCharacteristic: String? = nil      // 香りの印象（特性）
    var spiceCharacteristics: [String] = []      // 香りの印象（特性）
    var spiceCharacteristicOther = "" // 香りの印象（特性）(その他)

    // MARK: 味わい
    var attack: String? = nil                   // アタック
    var attacks: [String] = []                   // アタック
    var attackOther = ""              // アタック(その他)
    var sweetness: String? = nil                // 甘味
    var sweetnesss: [String] = []                // 甘味
    var sweetnessOther = ""           // 甘味(その他)
    var acidity: String? = nil                  // 酸味
    var aciditys: [String] = []                  // 酸味
    var acidityOther = ""             // 酸味(その他)
    var bitterness: String? = nil               // 苦味
    var bitternesss: [String] = []               // 苦味
    var bitternessOther = ""          // 苦味(その他)
    var balanceBottomLeft: String? = nil        // バランンス（左下）
    var balanceBottomLefts: [String] = []        // バランンス（左下）
    var balanceBottomLeftOther = ""   // バランンス（左下）(その他)
/*
    var balanceTopLeft: String? = nil           // バランンス（左上）
    var balanceTopLefts: [String] = []           // バランンス（左上）
    var balanceTopLeftOther = ""      // バランンス（左上）(その他)
    var balanceTopRight: String? = nil          // バランンス（右上）
    var balanceTopRights: [String] = []          // バランンス（右上）
    var balanceTopRightOther = ""     // バランンス（右上）(その他)
    var balanceBottmRight: String? = nil        // バランンス（右下）
    var balanceBottmRights: [String] = []        // バランンス（右下）
    var balanceBottmRightOther = ""   // バランンス（右下）(その他)
 */
    var alcohol: String? = nil                  // アルコール
    var alcohols: [String] = []                  // アルコール
    var alcoholOther = ""             // アルコール(その他)
    var finish: String? = nil                   // 余韻
    var finishs: [String] = []                   // 余韻
    var finishOther = ""              // 余韻(その他)

    // MARK: 結論
    var evaluation: String? = nil               // 評価
    var evaluations: [String] = []               // 評価
    var evaluationOther = ""          // 評価(その他)
    var eervingTemperature: String? = nil       // 適正温度
    var eervingTemperatures: [String] = []       // 適正温度
    var eervingTemperatureOther = ""  // 適正温度(その他)
    var glass: String? = nil                    // グラス
    var glasss: [String] = []                    // グラス
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
/*
        balanceTopLeft: String? = "",
        balanceTopLeftOther: String = "",
        balanceTopRight: String? = "",
        balanceTopRightOther: String = "",
        balanceBottmRight: String? = "",
        balanceBottmRightOther: String = "",
 */
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
/*
        self.balanceTopLeft = balanceTopLeft
        self.balanceTopLeftOther = balanceTopLeftOther
        self.balanceTopRight = balanceTopRight
        self.balanceTopRightOther = balanceTopRightOther
        self.balanceBottmRight = balanceBottmRight
        self.balanceBottmRightOther = balanceBottmRightOther
 */
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
    
    var subImages: [UIImage] {
        subImagesData.compactMap {
            UIImage(data: $0)
        }
    }
    
    func migrateSelections() {
        // MARK: 外観
        if claritys.isEmpty, let value = clarity, !value.isEmpty {
            claritys = [value]
        }

        if brightnesss.isEmpty, let value = brightness, !value.isEmpty {
            brightnesss = [value]
        }

        if colorTones.isEmpty, let value = colorTone, !value.isEmpty {
            colorTones = [value]
        }

        if colors.isEmpty, let value = color, !value.isEmpty {
            colors = [value]
        }

        if densitys.isEmpty, let value = density, !value.isEmpty {
            densitys = [value]
        }

        if viscositys.isEmpty, let value = viscosity, !value.isEmpty {
            viscositys = [value]
        }

        if youthfulnesss.isEmpty, let value = youthfulness, !value.isEmpty {
            youthfulnesss = [value]
        }

        if maturitys.isEmpty, let value = maturity, !value.isEmpty {
            maturitys = [value]
        }

        if effervescences.isEmpty, let value = effervescence, !value.isEmpty {
            effervescences = [value]
        }

        // MARK: 香り
        if firstImpIntensitys.isEmpty, let value = firstImpIntensity, !value.isEmpty {
            firstImpIntensitys = [value]
        }

        if firstImpCharacters.isEmpty, let value = firstImpCharacter, !value.isEmpty {
            firstImpCharacters = [value]
        }

        if fruits.isEmpty, let value = fruit, !value.isEmpty {
            fruits = [value]
        }

        if plantFlowers.isEmpty, let value = plantFlower, !value.isEmpty {
            plantFlowers = [value]
        }

        if plantHerbs.isEmpty, let value = plantHerb, !value.isEmpty {
            plantHerbs = [value]
        }

        if plantNutss.isEmpty, let value = plantNuts, !value.isEmpty {
            plantNutss = [value]
        }

        if spiceMinerals.isEmpty, let value = spiceMineral, !value.isEmpty {
            spiceMinerals = [value]
        }

        if spicsOaks.isEmpty, let value = spicsOak, !value.isEmpty {
            spicsOaks = [value]
        }

        if spiceSpices.isEmpty, let value = spiceSpice, !value.isEmpty {
            spiceSpices = [value]
        }

        if spiceOtherss.isEmpty, let value = spiceOthers, !value.isEmpty {
            spiceOtherss = [value]
        }

        if spiceMaturitys.isEmpty, let value = spiceMaturity, !value.isEmpty {
            spiceMaturitys = [value]
        }

        if spiceCharacteristics.isEmpty, let value = spiceCharacteristic, !value.isEmpty {
            spiceCharacteristics = [value]
        }

        // MARK: 味わい
        if attacks.isEmpty, let value = attack, !value.isEmpty {
            attacks = [value]
        }

        if sweetnesss.isEmpty, let value = sweetness, !value.isEmpty {
            sweetnesss = [value]
        }

        if aciditys.isEmpty, let value = acidity, !value.isEmpty {
            aciditys = [value]
        }

        if bitternesss.isEmpty, let value = bitterness, !value.isEmpty {
            bitternesss = [value]
        }

        if balanceBottomLefts.isEmpty, let value = balanceBottomLeft, !value.isEmpty {
            balanceBottomLefts = [value]
        }
/*
        if balanceTopLefts.isEmpty, let value = balanceTopLeft, !value.isEmpty {
            balanceTopLefts = [value]
        }

        if balanceTopRights.isEmpty, let value = balanceTopRight, !value.isEmpty {
            balanceTopRights = [value]
        }

        if balanceBottmRights.isEmpty, let value = balanceBottmRight, !value.isEmpty {
            balanceBottmRights = [value]
        }
 */
        if alcohols.isEmpty, let value = alcohol, !value.isEmpty {
            alcohols = [value]
        }

        if finishs.isEmpty, let value = finish, !value.isEmpty {
            finishs = [value]
        }

        // MARK: 結論
        if evaluations.isEmpty, let value = evaluation, !value.isEmpty {
            evaluations = [value]
        }

        if eervingTemperatures.isEmpty, let value = eervingTemperature, !value.isEmpty {
            eervingTemperatures = [value]
        }

        if glasss.isEmpty, let value = glass, !value.isEmpty {
            glasss = [value]
        }
    }
}

struct SparklingWineTastingListView: View {
    @State private var searchText = ""
    @State private var showAddScreen = false
    @State private var showDeleteAlert = false
    @State private var deleteOffsets: IndexSet?

    @Query(
        sort: \spWine.tastingDate,
        order: .reverse
    )
    private var wines: [spWine]

    @Environment(\.modelContext)
    private var context
    
    // 検索用
    private var filteredWines: [spWine] {
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
                            SparklingWineTastingSheetView(wine: wine)
                        } label: {
                            HStack(spacing: 16) {
                                if let image = wine.image {
                                    Image(uiImage: image)
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 80, height: 60)
                                        .background(Color.gray.opacity(0.1))
                                        .clipShape(RoundedRectangle(cornerRadius: 12))
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

                                    Text("スパークリングワイン")
                                        .font(.caption2)
                                        .foregroundColor(.secondary)
                                }
                            }
                            .padding(.vertical, 6)
                        }
                    }
                    .onDelete { offsets in
                        deleteOffsets = offsets
                        showDeleteAlert = true
                    }
                }
                .searchable(
                    text: $searchText,
                    prompt: "ワイン検索"
                )
                .navigationTitle("スパークリングワイン")
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
                    AddSparklingWineView()
                }
                .alert(
                    "ワインを削除しますか？",
                    isPresented: $showDeleteAlert
                ) {
                    Button("削除", role: .destructive) {

                        if let offsets = deleteOffsets {
                            deleteWine(at: offsets)
                        }

                        deleteOffsets = nil
                    }
                    Button("キャンセル", role: .cancel) {
                        deleteOffsets = nil
                    }
                } message: {
                    Text("このワインの記録を削除します。\nこの操作は取り消せません。")
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

struct AddSparklingWineView: View {
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
                                .scaledToFit()
                                .frame(maxWidth: .infinity)
                                .frame(height: 220)
                                .background(Color(.systemGray6))
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

                        let wine = spWine(
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


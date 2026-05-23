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
    var imageData: Data?
    var name: String
    var tastingDate: Date = Date()
    var rating: Int
    var comment: String
    var isFavorite = false
    
    // MARK: 外観
    var clarity: String?        // 清澄度
    var brightness: String?     // 輝き
    var colorTone: String?      // 色調（補助用語）
    var color: String?          // 色調（メイン用語）
    var density: String?        // 濃淡
    var viscosity: String?      // 粘性
    var youthfulness: String?   // 外観の印象（若さ）
    var maturity: String?       // 外観の印象（成熟度）
    var effervescence: String?  // 外観の印象（発泡性）
    var appearance = ""         // その他

    // MARK: 香り
    var firstImpression: String? = nil
    var fruit: String? = nil
    var flower: String? = nil
    var spice: String? = nil

    // MARK: 味わい
    var sweetness: String? = nil
    var acidity: String? = nil
    var balance: String? = nil
    var alcohol: String? = nil
    var finish: String? = nil

    // MARK: 結論
    var grape = ""
    var country = ""
    var vintage = ""
    

    init(
        name: String,
        imageData: Data? = nil,
        rating: Int = 0,
        comment: String = "",
        isFavorite: Bool = false,
        tastingDate: Date = Date(),
        clarity: String? = nil,
        brightness: String? = nil,
        colorTone: String? = "",
        color: String? = "",
        density: String? = "",
        viscosity: String? = "",
        youthfulness: String? = nil,
        maturity: String? = nil,
        effervescence: String? = nil,
        appearance: String = "",
        firstImpression: String? = "",
        fruit: String? = "",
        flower: String? = "",
        spice: String? = "",
        sweetness: String? = "",
        acidity: String? = "",
        balance: String? = "",
        alcohol: String? = "",
        finish: String? = "",
        grape: String = "",
        country: String = "",
        vintage: String = "",
    ) {
        self.name = name
        self.imageData = imageData
        self.rating = rating
        self.comment = comment
        self.isFavorite = isFavorite
        self.tastingDate = tastingDate
        self.clarity = clarity
        self.brightness = brightness
        self.colorTone = colorTone
        self.color = color
        self.density = density
        self.viscosity = viscosity
        self.youthfulness = youthfulness
        self.maturity = maturity
        self.effervescence = effervescence
        self.appearance = appearance
        self.firstImpression = firstImpression
        self.fruit = fruit
        self.flower = flower
        self.spice = spice
        self.sweetness = sweetness
        self.acidity = acidity
        self.balance = balance
        self.alcohol = alcohol
        self.finish = finish
        self.grape = grape
        self.country = country
        self.vintage = vintage
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
                            name: wineName,
                            imageData: imageData
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

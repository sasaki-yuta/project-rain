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
class RedWine {
    // 基本データ
    var imageData: Data?                        // ワイン画像
    var name: String                            // ワイン名
    var isFavorite = false                      // お気に入り
    var tastingDate: Date = Date()              // 試飲日
    var rating: Int                             // 評価
    var comment: String                         // コメント

    init(
        // 基本データ
        imageData: Data? = nil,
        name: String,
        isFavorite: Bool = false,
        tastingDate: Date = Date(),
        rating: Int = 0,
        comment: String = "",
    ) {
        // 基本データ
        self.imageData = imageData
        self.name = name
        self.isFavorite = isFavorite
        self.tastingDate = tastingDate
        self.rating = rating
        self.comment = comment
    }

    var image: UIImage? {
        guard let imageData else { return nil }
        return UIImage(data: imageData)
    }
}

struct RedWineTastingListView: View {

    @State private var searchText = ""
    @State private var showAddScreen = false

    @Query private var wines: [RedWine]

    @Environment(\.modelContext)
    private var context

    var body: some View {
        NavigationView {
            List {
                ForEach(wines) { wine in
                    NavigationLink {
                        //RedWineTastingSheetView(wine: wine)
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

                                Text("赤ワイン")
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
            .navigationTitle("赤ワイン")
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
            .navigationTitle("赤ワイン追加")
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

                        let wine = RedWine(
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

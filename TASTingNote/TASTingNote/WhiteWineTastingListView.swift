import SwiftUI
import SwiftData
import PhotosUI

struct Wine: Identifiable {
    let id = UUID()
    var name: String
    var image: UIImage?
}

struct WhiteWineTastingListView: View {
    @State private var searchText = ""
    @State private var wines: [Wine] = []
    @State private var showAddScreen = false

    var filteredWines: [Wine] {
        if searchText.isEmpty {
            return wines
        } else {
            return wines.filter {
                $0.name.localizedCaseInsensitiveContains(searchText)
            }
        }
    }

    var body: some View {
        VStack{
            NavigationView {
                List(filteredWines) { wine in
                    NavigationLink {
                        WineTastingSheetView(
                            wine: binding(for: wine)
                        )
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
                .searchable(
                    text: $searchText,
                    prompt: "ワイン検索"
                )
                .navigationTitle("白ワイン")
                .toolbar {
                    ToolbarItem(placement: .topBarTrailing) {
                        Button {
                            showAddScreen = true
                        } label: {
                            Image(systemName: "plus")
                        }
                    }
                }
                .sheet(isPresented: $showAddScreen) {
                    AddWineView { newWine in
                        wines.append(newWine)
                    }
                }
            }
        }
    }

    // Binding取得
    func binding(for wine: Wine) -> Binding<Wine> {
        guard let index = wines.firstIndex(where: {
            $0.id == wine.id
        }) else {
            fatalError("Wine not found")
        }
        return $wines[index]
    }
}

struct AddWineView: View {
    @Environment(\.dismiss) private var dismiss
    @State private var wineName = ""
    @State private var selectedItem: PhotosPickerItem?
    @State private var selectedImage: UIImage?
    var onSave: (Wine) -> Void

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
                        let newWine = Wine(
                            name: wineName,
                            image: selectedImage
                        )
                        onSave(newWine)
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

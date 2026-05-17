import SwiftUI
import PhotosUI

struct WhiteWineTastingSheetView: View {

    @Binding var wine: Wine

    @State private var selectedItem: PhotosPickerItem?

    // 外観

    @State private var clarity = "清澄"

    @State private var brightness = "輝きのある"

    @State private var color = "レモン"

    @State private var viscosity = "やや強い"

    // 香り

    @State private var aromaIntensity = "やや強い"

    @State private var aromaMemo = ""

    // 味わい

    @State private var sweetness = 2

    @State private var acidity = 4

    @State private var bitterness = 2

    @State private var alcohol = 3

    @State private var body_ = "ややコク"

    @State private var finish = "やや長い"

    // 結論

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
                            "清澄",
                            "やや濁った",
                            "濁った"
                        ]
                    )

                    tastingRow(
                        title: "輝き",
                        selection: $brightness,
                        options: [
                            "輝きのある",
                            "落ち着いた"
                        ]
                    )

                    tastingRow(
                        title: "色調",
                        selection: $color,
                        options: [
                            "グリーン",
                            "レモン",
                            "ゴールド",
                            "アンバー"
                        ]
                    )

                    tastingRow(
                        title: "粘性",
                        selection: $viscosity,
                        options: [
                            "弱い",
                            "やや弱い",
                            "中程度",
                            "やや強い",
                            "強い"
                        ]
                    )
                }

                Divider()

                // MARK: 香り

                tastingSection(title: "香り") {

                    tastingRow(
                        title: "強さ",
                        selection: $aromaIntensity,
                        options: [
                            "弱い",
                            "中程度",
                            "やや強い",
                            "強い"
                        ]
                    )

                    VStack(alignment: .leading) {

                        Text("特徴")
                            .font(.headline)

                        TextEditor(text: $aromaMemo)
                            .frame(height: 100)
                            .overlay(
                                RoundedRectangle(cornerRadius: 8)
                                    .stroke(
                                        Color.gray.opacity(0.3)
                                    )
                            )
                    }
                }

                Divider()

                // MARK: 味わい

                tastingSection(title: "味わい") {

                    scoreRow(
                        title: "甘味",
                        value: $sweetness
                    )

                    scoreRow(
                        title: "酸味",
                        value: $acidity
                    )

                    scoreRow(
                        title: "苦味",
                        value: $bitterness
                    )

                    scoreRow(
                        title: "アルコール",
                        value: $alcohol
                    )

                    tastingRow(
                        title: "ボディ",
                        selection: $body_,
                        options: [
                            "軽い",
                            "やや軽い",
                            "中程度",
                            "ややコク",
                            "コク"
                        ]
                    )

                    tastingRow(
                        title: "余韻",
                        selection: $finish,
                        options: [
                            "短い",
                            "やや短い",
                            "中程度",
                            "やや長い",
                            "長い"
                        ]
                    )
                }

                Divider()

                // MARK: 結論

                tastingSection(title: "結論") {

                    TextField(
                        "品種",
                        text: $grape
                    )
                    .textFieldStyle(.roundedBorder)

                    TextField(
                        "産地",
                        text: $country
                    )
                    .textFieldStyle(.roundedBorder)

                    TextField(
                        "ヴィンテージ",
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
        .navigationTitle("白ワイン試験")
        .navigationBarTitleDisplayMode(.inline)

        // 写真変更

        .onChange(of: selectedItem) {

            Task {

                if let data = try? await selectedItem?.loadTransferable(type: Data.self),
                   let image = UIImage(data: data) {

                    wine.image = image
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

    func scoreRow(
        title: String,
        value: Binding<Int>
    ) -> some View {

        VStack(alignment: .leading) {

            Text("\(title): \(value.wrappedValue)")
                .font(.headline)

            Stepper(
                "",
                value: value,
                in: 1...5
            )
        }
    }
}

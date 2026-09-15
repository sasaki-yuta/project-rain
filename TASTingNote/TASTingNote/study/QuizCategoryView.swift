//
//  QuizCategoryView.swift
//  TastingApp
//
//  Created by 佐々木 勇太 on 2026/09/15.
//

import SwiftUI

struct QuizCategoryView: View {

    @State private var categories: [Category] = []
    @State private var selectedCategory: Category?
    @State private var isLoading = true
    @State private var errorMessage: String?

    private let api = QuizAPI()

    var body: some View {

        NavigationStack {

            List {

                // すべて
                Button {
                    selectedCategory = nil
                } label: {
                    HStack {
                        Text("すべて")
                            .foregroundStyle(.primary)

                        Spacer()

                        if selectedCategory == nil {
                            Image(systemName: "checkmark")
                                .foregroundStyle(.blue)
                        }
                    }
                }

                Section("出題範囲") {

                    ForEach(categories) { category in

                        Button {

                            selectedCategory = category

                        } label: {

                            HStack {

                                Text(category.name)
                                    .foregroundStyle(.primary)

                                Spacer()

                                if selectedCategory?.id == category.id {

                                    Image(
                                        systemName: "checkmark"
                                    )
                                    .foregroundStyle(.blue)
                                }
                            }
                        }
                    }
                }
            }
            .navigationTitle("出題範囲")
            .task {
                await loadCategories()
            }
            .safeAreaInset(edge: .bottom) {

                NavigationLink {
                    QuizGameView(
                        categoryId: selectedCategory?.id
                    )
                } label: {

                    Text("10問開始")
                        .font(.headline)
                        .frame(maxWidth: .infinity)
                        .padding()
                }
                .buttonStyle(.borderedProminent)
                .padding()
            }
        }
    }

    private func loadCategories() async {

        do {

            categories =
                try await api.fetchCategories()

            isLoading = false

        } catch {

            errorMessage =
                error.localizedDescription

            isLoading = false
        }
    }
}

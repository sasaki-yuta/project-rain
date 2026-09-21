//
//  QuizAPI.swift
//  TastingApp
//
//  Created by 佐々木 勇太 on 2026/09/15.
//

import Foundation

final class QuizAPI: Sendable {

    private let baseURL =
        "https://project-rain.jp/api"

    func fetchCategories() async throws -> [Category] {

        let url = URL(
            string: "\(baseURL)/categories.php"
        )!

        let (data, response) =
            try await URLSession.shared.data(from: url)

        guard let http =
                response as? HTTPURLResponse,
              200..<300 ~= http.statusCode else {

            throw URLError(.badServerResponse)
        }

        let result =
            try JSONDecoder().decode(
                CategoryResponse.self,
                from: data
            )

        return result.categories
    }

    /// 問題が1問以上登録されているカテゴリだけを返す
    func fetchAvailableCategories() async throws -> [Category] {

        let categories = try await fetchCategories()

        return try await withThrowingTaskGroup(
            of: Category?.self
        ) { group in

            for category in categories {
                group.addTask {
                    let quizzes = try await self.fetchQuizzes(
                        categoryId: category.id,
                        limit: 1
                    )
                    return quizzes.isEmpty ? nil : category
                }
            }

            var availableCategories: [Category] = []

            for try await category in group {
                if let category {
                    availableCategories.append(category)
                }
            }

            return availableCategories.sorted {
                $0.sortOrder < $1.sortOrder
            }
        }
    }

    func fetchQuizzes(
        categoryId: Int?,
        limit: Int = 10
    ) async throws -> [Quiz] {

        var components = URLComponents(
            string: "\(baseURL)/quizzes.php"
        )!

        var queryItems = [
            URLQueryItem(
                name: "limit",
                value: String(limit)
            )
        ]

        if let categoryId {
            queryItems.append(
                URLQueryItem(
                    name: "category_id",
                    value: String(categoryId)
                )
            )
        }

        components.queryItems = queryItems

        guard let url = components.url else {
            throw URLError(.badURL)
        }

        let (data, response) =
            try await URLSession.shared.data(
                from: url
            )

        guard let http =
                response as? HTTPURLResponse,
              200..<300 ~= http.statusCode else {

            throw URLError(.badServerResponse)
        }

        let result =
            try JSONDecoder().decode(
                QuizResponse.self,
                from: data
            )

        return result.quizzes
    }
}

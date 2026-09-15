//
//  QuizAPI.swift
//  TastingApp
//
//  Created by 佐々木 勇太 on 2026/09/15.
//

import Foundation

final class QuizAPI {

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

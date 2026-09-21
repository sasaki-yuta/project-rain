//
//  Quiz.swift
//  TastingApp
//
//  Created by 佐々木 勇太 on 2026/09/15.
//

struct Quiz: Codable, Identifiable {

    let id: Int
    let categoryId: Int

    let question: String

    let optionA: String
    let optionB: String
    let optionC: String
    let optionD: String

    let correctAnswer: String

    let explanation: String?

    let difficulty: Int

    var difficultyText: String {
        switch difficulty {
        case 1:
            return "初級"
        case 2:
            return "中級"
        case 3:
            return "上級"
        default:
            return "レベル \(difficulty)"
        }
    }

    var difficultyStars: String {
        let level = min(max(difficulty, 1), 3)
        return String(repeating: "★", count: level)
            + String(repeating: "☆", count: 3 - level)
    }

    enum CodingKeys: String, CodingKey {
        case id
        case categoryId = "category_id"
        case question
        case optionA = "option_a"
        case optionB = "option_b"
        case optionC = "option_c"
        case optionD = "option_d"
        case correctAnswer = "correct_answer"
        case explanation
        case difficulty
    }
}

struct Category: Codable, Identifiable {

    let id: Int
    let name: String
    let sortOrder: Int

    enum CodingKeys: String, CodingKey {
        case id
        case name
        case sortOrder = "sort_order"
    }
}

struct CategoryResponse: Codable {
    let success: Bool
    let categories: [Category]
}

struct QuizResponse: Codable {
    let success: Bool
    let quizzes: [Quiz]
}

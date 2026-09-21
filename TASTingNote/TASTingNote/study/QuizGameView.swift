//
//  QuizGameView.swift
//  TastingApp
//
//  Created by 佐々木 勇太 on 2026/09/15.
//

import SwiftUI

struct QuizGameView: View {

    let categoryId: Int?

    @State private var quizzes: [Quiz] = []
    @State private var categoryNames: [Int: String] = [:]
    @State private var currentIndex = 0
    @State private var selectedAnswer: String?
    @State private var showResult = false
    @State private var score = 0
    @State private var isFinished = false
    @State private var errorMessage: String?

    private let api = QuizAPI()

    var body: some View {

        VStack(spacing: 20) {

            if isFinished {

                resultView

            } else if quizzes.isEmpty {

                ProgressView("問題を読み込み中...")

            } else {

                quizView
            }
        }
        .padding()
        .navigationTitle("問題集")
        .task {
            await loadQuizzes()
        }
    }

    private var quizView: some View {

        let quiz = quizzes[currentIndex]

        return ScrollView {
            VStack(spacing: 20) {

                Text("第 \(currentIndex + 1) 問 / \(quizzes.count)")
                    .font(.headline)

                VStack(alignment: .leading, spacing: 8) {
                    Label(
                        categoryName(for: quiz),
                        systemImage: "globe.asia.australia.fill"
                    )
                    .foregroundStyle(.blue)

                    HStack(spacing: 6) {
                        Text("難易度：\(quiz.difficultyText)")
                        Text(quiz.difficultyStars)
                            .foregroundStyle(.orange)
                    }
                }
                .font(.subheadline)
                .fontWeight(.semibold)
                .frame(
                    maxWidth: .infinity,
                    alignment: .leading
                )

                Text(quiz.question)
                    .font(.title3)
                    .fontWeight(.bold)
                    .frame(
                        maxWidth: .infinity,
                        alignment: .leading
                    )

                answerButton(
                    "A",
                    quiz.optionA,
                    quiz: quiz
                )

                answerButton(
                    "B",
                    quiz.optionB,
                    quiz: quiz
                )

                answerButton(
                    "C",
                    quiz.optionC,
                    quiz: quiz
                )

                answerButton(
                    "D",
                    quiz.optionD,
                    quiz: quiz
                )

                // MARK: - 正解・不正解・解説

                if showResult {

                    Text(
                        selectedAnswer == quiz.correctAnswer
                        ? "正解！"
                        : "不正解"
                    )
                    .font(.title2)
                    .fontWeight(.bold)

                    if let explanation = quiz.explanation {

                        VStack(alignment: .leading, spacing: 8) {

                            Text("解説")
                                .font(.headline)

                            Text(explanation)
                                .font(.body)
                                .frame(
                                    maxWidth: .infinity,
                                    alignment: .leading
                                )
                                .fixedSize(
                                    horizontal: false,
                                    vertical: true
                                )
                        }
                        .frame(
                            maxWidth: .infinity,
                            alignment: .leading
                        )
                        .padding()
                        .background(
                            Color.gray.opacity(0.1)
                        )
                        .clipShape(
                            RoundedRectangle(
                                cornerRadius: 12
                            )
                        )
                    }

                    Button(
                        currentIndex + 1 < quizzes.count
                        ? "次の問題"
                        : "結果を見る"
                    ) {
                        nextQuestion()
                    }
                    .buttonStyle(.borderedProminent)
                    .padding(.top, 5)
                }
            }
            .frame(maxWidth: .infinity)
            .padding(.bottom, 20)
        }
    }

    private func answerButton(
        _ letter: String,
        _ text: String,
        quiz: Quiz
    ) -> some View {

        Button {

            guard !showResult else {
                return
            }

            selectedAnswer = letter
            showResult = true

            if letter == quiz.correctAnswer {
                score += 1
            }

        } label: {

            HStack {

                Text(letter)
                    .fontWeight(.bold)

                Text(text)

                Spacer()
            }
            .padding()
            .frame(maxWidth: .infinity)
        }
        .buttonStyle(.bordered)
    }

    private var resultView: some View {

        VStack(spacing: 20) {

            Text("テスト終了")
                .font(.largeTitle)
                .fontWeight(.bold)

            Text("\(score) / \(quizzes.count)")
                .font(.system(
                    size: 50,
                    weight: .bold
                ))

            Button("もう一度") {
                Task {
                    await loadQuizzes()
                }
            }
            .buttonStyle(.borderedProminent)
        }
    }

    private func nextQuestion() {

        if currentIndex + 1 < quizzes.count {

            currentIndex += 1
            selectedAnswer = nil
            showResult = false

        } else {

            isFinished = true
        }
    }

    private func categoryName(for quiz: Quiz) -> String {
        if let name = categoryNames[quiz.categoryId] {
            return "カテゴリ：\(name)"
        }

        return "カテゴリ：不明"
    }

    private func loadQuizzes() async {

        do {

            async let quizzesRequest = api.fetchQuizzes(
                categoryId: categoryId,
                limit: 10
            )
            async let categoriesRequest = api.fetchCategories()

            let (loadedQuizzes, loadedCategories) =
                try await (quizzesRequest, categoriesRequest)

            quizzes = loadedQuizzes
            categoryNames = Dictionary(
                uniqueKeysWithValues: loadedCategories.map {
                    ($0.id, $0.name)
                }
            )

            currentIndex = 0
            score = 0
            selectedAnswer = nil
            showResult = false
            isFinished = false

        } catch {

            errorMessage =
                error.localizedDescription
        }
    }
}

//
//  WineOCRParser.swift
//  TastingApp
//
//  Created by 佐々木 勇太 on 2026/07/12.
//
import Foundation

struct OCRWineResult {
    var name = ""
    var vintage = ""
    var country = ""
    var grape = ""
}

enum WineOCRParser {

    static func parse(
        from text: String
    ) -> OCRWineResult {

        var result = OCRWineResult()

        let lines = text.components(
            separatedBy: .newlines
        )

        if let first = lines.first(where: {
            $0.count > 3
        }) {
            result.name = first
        }

        // ヴィンテージ
        let pattern = "\\b(19|20)\\d{2}\\b"

        if let regex = try? NSRegularExpression(
            pattern: pattern
        ) {

            let range = NSRange(
                text.startIndex...,
                in: text
            )

            if let match = regex.firstMatch(
                in: text,
                range: range
            ),
            let r = Range(
                match.range,
                in: text
            ) {

                result.vintage = String(text[r])
            }
        }

        // 国
        let countries = [
            "France": "フランス",
            "FRANCE": "フランス",
            "Italy": "イタリア",
            "ITALY": "イタリア",
            "Chile": "チリ",
            "CHILE": "チリ",
            "ニュージーランド": "ニュージーランド"
        ]

        for (key, value) in countries {
            if text.contains(key) {
                result.country = value
                break
            }
        }

        // 品種
        let grapes = [
            "Cabernet Sauvignon": "カベルネ・ソーヴィニヨン",
            "Pinot Noir": "ピノ・ノワール",
            "Merlot": "メルロー",
            "Chardonnay": "シャルドネ",
            "Sauvignon Blanc": "ソーヴィニヨン・ブラン"
        ]

        for (key, value) in grapes {
            if text.contains(key) {
                result.grape = value
                break
            }
        }

        return result
    }
}

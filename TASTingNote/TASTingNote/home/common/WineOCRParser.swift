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
    var region = ""
    var productionArea = ""
    var grape = ""
}

enum WineOCRParser {
    static func containsWord(
        _ text: String,
        word: String
    ) -> Bool {

        let pattern =
            "\\b" +
            NSRegularExpression.escapedPattern(
                for: word
            ) +
            "\\b"

        guard let regex =
            try? NSRegularExpression(
                pattern: pattern,
                options: [.caseInsensitive]
            )
        else {
            return false
        }

        return regex.firstMatch(
            in: text,
            range: NSRange(
                text.startIndex...,
                in: text
            )
        ) != nil
    }

    static func parse(
        from text: String
    ) -> OCRWineResult {

        var result = OCRWineResult()

        let lines = text.components(
            separatedBy: .newlines
        )

        // OCR文字列を検索しやすい形に変換
        var normalizedText = text
        normalizedText = normalizedText.replacingOccurrences(of: "-", with: " ")
        normalizedText = normalizedText.replacingOccurrences(of: "–", with: " ")
        normalizedText = normalizedText.replacingOccurrences(of: "—", with: " ")
        normalizedText = normalizedText.replacingOccurrences(of: ".", with: "")
        normalizedText = normalizedText.replacingOccurrences(of: ",", with: "")
        normalizedText = normalizedText.replacingOccurrences(of: "(", with: "")
        normalizedText = normalizedText.replacingOccurrences(of: ")", with: "")
        normalizedText = normalizedText.replacingOccurrences(of: "\n", with: " ")
        
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
        let countryPatterns = [
            // 日本語
            "原産国[:：]\\s*([^\\n]+)",
            "原産国名[:：]\\s*([^\\n]+)",
            "生産国[:：]\\s*([^\\n]+)",
            "生産国名[:：]\\s*([^\\n]+)",
            "製造国[:：]\\s*([^\\n]+)",
            "醸造国[:：]\\s*([^\\n]+)",
            "産地[:：]\\s*([^\\n]+)",
            "原産地[:：]\\s*([^\\n]+)",
            "生産地[:：]\\s*([^\\n]+)",
            "葡萄産地[:：]\\s*([^\\n]+)",
            "ぶどう産地[:：]\\s*([^\\n]+)",

            // 英語
            "Country of Origin[:：]?\\s*([^\\n]+)",
            "Origin[:：]?\\s*([^\\n]+)",
            "Country[:：]?\\s*([^\\n]+)",
            "Made in\\s+([^\\n]+)",
            "Produced in\\s+([^\\n]+)",
            "Product of\\s+([^\\n]+)",
            "Produce of\\s+([^\\n]+)",
            "Grown in\\s+([^\\n]+)",
            "Wine of\\s+([^\\n]+)",
            "Estate Bottled in\\s+([^\\n]+)",
            "Bottled in\\s+([^\\n]+)",
            "Imported from\\s+([^\\n]+)",

            // フランス語
            "Produit de\\s+([^\\n]+)",
            "Origine[:：]?\\s*([^\\n]+)",
            "Pays d'origine[:：]?\\s*([^\\n]+)",
            "Mis en bouteille en\\s+([^\\n]+)",

            // イタリア語
            "Prodotto in\\s+([^\\n]+)",
            "Paese d'origine[:：]?\\s*([^\\n]+)",
            "Imbottigliato in\\s+([^\\n]+)",

            // スペイン語
            "Producto de\\s+([^\\n]+)",
            "Origen[:：]?\\s*([^\\n]+)",
            "Embotellado en\\s+([^\\n]+)",

            // ドイツ語
            "Erzeugnis aus\\s+([^\\n]+)",
            "Herkunftsland[:：]?\\s*([^\\n]+)",
            "Abgefüllt in\\s+([^\\n]+)",

            // ポルトガル語
            "Produto de\\s+([^\\n]+)",
            "Origem[:：]?\\s*([^\\n]+)",
            "Engarrafado em\\s+([^\\n]+)"
        ]

        var isEmpty = true
        for pattern in countryPatterns {
            if let regex = try? NSRegularExpression(pattern: pattern),
               let match = regex.firstMatch(
                    in: text,
                    range: NSRange(text.startIndex..., in: text)
               ),
               let range = Range(match.range(at: 1), in: text) {

                let countryText = String(text[range])

                for (key, value) in WineOCRDictionaryCountries.countries {
                    if containsWord(
                        countryText,
                        word: key
                    ) {
                        result.country = value
                        isEmpty = false
                        break
                    }
                }
            }
        }
        
        let ignoreKeywords = [
            "輸入者",
            "輸入元",
            "販売者",
            "製造者",
            "加工所",
            "発売元",
            "販売元",

            "Importer",
            "Imported by",
            "Distributed by",
            "Imported and Distributed by",
            "Bottled for",
            "Packed by"
        ]
        
        if isEmpty {
            for line in lines {
                // 輸入者などの行は無視
                if ignoreKeywords.contains(where: {
                    line.localizedCaseInsensitiveContains($0)
                }) {
                    continue
                }
                
                for (key, value) in WineOCRDictionaryCountries.countries {
                    if containsWord(
                        line,
                        word: key
                    ) {
                        result.country = value
                        isEmpty = false
                        break
                    }
                }

                if !isEmpty {
                    break
                }
            }
        }
        
        print("======== OCR ========")
        print(text)
        
        
        let sortedRegions =
        WineOCRDictionaryRegions.regions.sorted {
            $0.key.count > $1.key.count
        }

        for (key, value) in sortedRegions {

            if containsWord(text, word: key) {

                print("Region Hit =", key)

                result.region = value.region

                if result.country.isEmpty {
                    result.country = value.country
                }

                break
            }
        }
        
        // 品種検索
        let sortedGrapes =
        WineOCRDictionaryGrapes.grapes.sorted {
            $0.key.count > $1.key.count
        }

        for (key, value) in sortedGrapes {

            if normalizedText.localizedCaseInsensitiveContains(key) {

                print("Grape Hit =", key)

                result.grape = value
                break
            }
        }
        
        // 国＋半角スペース＋産地で、生産地の文字列を保存
        if !result.country.isEmpty && !result.region.isEmpty {
            result.productionArea =
                "\(result.country) \(result.region)"

        } else if !result.country.isEmpty {

            result.productionArea =
                result.country

        } else if !result.region.isEmpty {

            result.productionArea =
                result.region
        }
        
        return result
    }
}

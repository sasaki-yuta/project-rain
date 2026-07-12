//
//  WineOCRDictionary.swift
//  TastingApp
//
//  Created by 佐々木 勇太 on 2026/07/12.
//
import Foundation

enum WineOCRDictionaryGrapes {

    static let grapes: [String: String] = [
        // ===== 赤 =====

           // Cabernet Sauvignon
           "Cabernet Sauvignon": "カベルネ・ソーヴィニヨン",
           "Cabernet": "カベルネ・ソーヴィニヨン",
           "CS": "カベルネ・ソーヴィニヨン",
           "カベルネ・ソーヴィニヨン": "カベルネ・ソーヴィニヨン",

           // Merlot
           "Merlot": "メルロー",
           "メルロー": "メルロー",

           // Pinot Noir
           "Pinot Noir": "ピノ・ノワール",
           "Pinot Nero": "ピノ・ノワール",
           "Spätburgunder": "ピノ・ノワール",
           "Blauburgunder": "ピノ・ノワール",
           "ピノ・ノワール": "ピノ・ノワール",

           // Syrah / Shiraz
           "Syrah": "シラー",
           "Shiraz": "シラー",
           "シラー": "シラー",
           "シラーズ": "シラー",

           // Cabernet Franc
           "Cabernet Franc": "カベルネ・フラン",
           "カベルネ・フラン": "カベルネ・フラン",

           // Malbec
           "Malbec": "マルベック",
           "Côt": "マルベック",
           "Auxerrois": "マルベック",
           "マルベック": "マルベック",

           // Petit Verdot
           "Petit Verdot": "プティ・ヴェルド",
           "プティ・ヴェルド": "プティ・ヴェルド",

           // Grenache
           "Grenache": "グルナッシュ",
           "Garnacha": "グルナッシュ",
           "Cannonau": "グルナッシュ",
           "グルナッシュ": "グルナッシュ",

           // Mourvèdre
           "Mourvedre": "ムールヴェードル",
           "Mourvèdre": "ムールヴェードル",
           "Monastrell": "ムールヴェードル",
           "Mataro": "ムールヴェードル",
           "ムールヴェードル": "ムールヴェードル",

           // Carignan
           "Carignan": "カリニャン",
           "Carignane": "カリニャン",
           "Cariñena": "カリニャン",
           "カリニャン": "カリニャン",

           // Tempranillo
           "Tempranillo": "テンプラニーリョ",
           "Tinto Fino": "テンプラニーリョ",
           "Tinta del Pais": "テンプラニーリョ",
           "テンプラニーリョ": "テンプラニーリョ",

           // Sangiovese
           "Sangiovese": "サンジョヴェーゼ",
           "サンジョヴェーゼ": "サンジョヴェーゼ",

           // Nebbiolo
           "Nebbiolo": "ネッビオーロ",
           "ネッビオーロ": "ネッビオーロ",

           // Barbera
           "Barbera": "バルベーラ",
           "バルベーラ": "バルベーラ",

           // Zinfandel
           "Zinfandel": "ジンファンデル",
           "Primitivo": "ジンファンデル",
           "ジンファンデル": "ジンファンデル",

           // Gamay
           "Gamay": "ガメイ",
           "ガメイ": "ガメイ",

           // ===== 白 =====

           // Chardonnay
           "Chardonnay": "シャルドネ",
           "シャルドネ": "シャルドネ",

           // Sauvignon Blanc
           "Sauvignon Blanc": "ソーヴィニヨン・ブラン",
           "Sauv Blanc": "ソーヴィニヨン・ブラン",
           "SB": "ソーヴィニヨン・ブラン",
           "ソーヴィニヨン・ブラン": "ソーヴィニヨン・ブラン",

           // Riesling
           "Riesling": "リースリング",
           "リースリング": "リースリング",

           // Pinot Gris / Grigio
           "Pinot Gris": "ピノ・グリ",
           "Pinot Grigio": "ピノ・グリ",
           "Grauburgunder": "ピノ・グリ",
           "ピノ・グリ": "ピノ・グリ",
           "ピノ・グリージョ": "ピノ・グリ",

           // Gewurztraminer
           "Gewurztraminer": "ゲヴュルツトラミネール",
           "Gewürztraminer": "ゲヴュルツトラミネール",
           "ゲヴュルツトラミネール": "ゲヴュルツトラミネール",

           // Chenin Blanc
           "Chenin Blanc": "シュナン・ブラン",
           "シュナン・ブラン": "シュナン・ブラン",

           // Viognier
           "Viognier": "ヴィオニエ",
           "ヴィオニエ": "ヴィオニエ",

           // Semillon
           "Semillon": "セミヨン",
           "Sémillon": "セミヨン",
           "セミヨン": "セミヨン",

           // Muscat
           "Muscat": "ミュスカ",
           "Moscato": "ミュスカ",
           "Muscat Blanc": "ミュスカ",
           "ミュスカ": "ミュスカ",
           "マスカット": "ミュスカ",

           // Albarino
           "Albarino": "アルバリーニョ",
           "Albariño": "アルバリーニョ",
           "アルバリーニョ": "アルバリーニョ",

           // Verdejo
           "Verdejo": "ベルデホ",
           "ベルデホ": "ベルデホ",

           // Gruner Veltliner
           "Gruner Veltliner": "グリューナー・ヴェルトリーナー",
           "Grüner Veltliner": "グリューナー・ヴェルトリーナー",
           "グリューナー・ヴェルトリーナー": "グリューナー・ヴェルトリーナー",

           // Torrontes
           "Torrontes": "トロンテス",
           "Torrontés": "トロンテス",
           "トロンテス": "トロンテス",

           // Furmint
           "Furmint": "フルミント",
           "フルミント": "フルミント",

           // Assyrtiko
           "Assyrtiko": "アシルティコ",
           "アシルティコ": "アシルティコ",

           // ===== 日本 =====

           // Koshu
           "Koshu": "甲州",
           "甲州": "甲州",

           // Muscat Bailey A
           "Muscat Bailey A": "マスカット・ベーリーA",
           "MBA": "マスカット・ベーリーA",
           "マスカット・ベーリーA": "マスカット・ベーリーA",

           // Black Queen
           "Black Queen": "ブラック・クイーン",
           "ブラック・クイーン": "ブラック・クイーン",

           // Delaware
           "Delaware": "デラウェア",
           "デラウェア": "デラウェア"
    ]
}

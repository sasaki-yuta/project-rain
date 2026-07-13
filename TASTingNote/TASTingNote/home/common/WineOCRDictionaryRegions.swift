//
//  WineOCRDictionaryRegions.swift
//  TastingApp
//
//  Created by 佐々木 勇太 on 2026/07/13.
//
import Foundation

enum WineOCRDictionaryRegions {

    static let regions: [String: (country: String, region: String)] = [

        // ニュージーランド
        "Marlborough": ("ニュージーランド","Marlborough"),
        "Marlborough G.I": ("ニュージーランド","Marlborough"),
        "Central Otago": ("ニュージーランド","Central Otago"),
        "Hawke's Bay": ("ニュージーランド","Hawke's Bay"),
        "Wairarapa": ("ニュージーランド","Wairarapa"),
        "Gisborne": ("ニュージーランド","Gisborne"),

        // フランス
        "Bordeaux": ("フランス","Bordeaux"),
        "Bordeaux Superieur": ("フランス","Bordeaux"),
        "Bordeaux Supérieur": ("フランス","Bordeaux"),
        "Medoc": ("フランス","Médoc"),
        "Médoc": ("フランス","Médoc"),
        "Pauillac": ("フランス","Pauillac"),
        "Margaux": ("フランス","Margaux"),
        "Saint Emilion": ("フランス","Saint-Émilion"),
        "Saint-Emilion": ("フランス","Saint-Émilion"),
        "Saint-Émilion": ("フランス","Saint-Émilion"),
        "Pomerol": ("フランス","Pomerol"),

        "Bourgogne": ("フランス","Bourgogne"),
        "Burgundy": ("フランス","Bourgogne"),
        "Chablis": ("フランス","Chablis"),
        "Meursault": ("フランス","Meursault"),
        "Puligny Montrachet": ("フランス","Puligny-Montrachet"),
        "Puligny-Montrachet": ("フランス","Puligny-Montrachet"),
        "Vosne Romanee": ("フランス","Vosne-Romanée"),
        "Vosne-Romanee": ("フランス","Vosne-Romanée"),

        "Champagne": ("フランス","Champagne"),
        "Alsace": ("フランス","Alsace"),
        "Sancerre": ("フランス","Sancerre"),
        "Pouilly Fume": ("フランス","Pouilly-Fumé"),
        "Pouilly-Fume": ("フランス","Pouilly-Fumé"),
        "Cotes du Rhone": ("フランス","Côtes du Rhône"),
        "Chateauneuf du Pape": ("フランス","Châteauneuf-du-Pape"),

        // イタリア
        "Piemonte": ("イタリア","Piemonte"),
        "Barolo": ("イタリア","Barolo"),
        "Barbaresco": ("イタリア","Barbaresco"),
        "Langhe": ("イタリア","Langhe"),
        "Toscana": ("イタリア","Toscana"),
        "Chianti": ("イタリア","Chianti"),
        "Brunello di Montalcino": ("イタリア","Brunello di Montalcino"),
        "Bolgheri": ("イタリア","Bolgheri"),
        "Veneto": ("イタリア","Veneto"),
        "Valpolicella": ("イタリア","Valpolicella"),
        "Amarone": ("イタリア","Amarone"),
        "Soave": ("イタリア","Soave"),
        "Sicilia": ("イタリア","Sicilia"),

        // スペイン
        "Rioja": ("スペイン","Rioja"),
        "Rioja Alta": ("スペイン","Rioja"),
        "Rioja Alavesa": ("スペイン","Rioja"),
        "Ribera del Duero": ("スペイン","Ribera del Duero"),
        "Priorat": ("スペイン","Priorat"),
        "Rias Baixas": ("スペイン","Rías Baixas"),
        "Jerez": ("スペイン","Jerez"),

        // アメリカ
        "Napa Valley": ("アメリカ","Napa Valley"),
        "Napa": ("アメリカ","Napa Valley"),
        "Sonoma": ("アメリカ","Sonoma"),
        "Russian River Valley": ("アメリカ","Russian River Valley"),
        "Paso Robles": ("アメリカ","Paso Robles"),
        "Willamette Valley": ("アメリカ","Willamette Valley"),

        // オーストラリア
        "Barossa Valley": ("オーストラリア","Barossa Valley"),
        "Barossa": ("オーストラリア","Barossa Valley"),
        "McLaren Vale": ("オーストラリア","McLaren Vale"),
        "Margaret River": ("オーストラリア","Margaret River"),
        "Hunter Valley": ("オーストラリア","Hunter Valley"),
        "Yarra Valley": ("オーストラリア","Yarra Valley"),

        // チリ
        "Maipo Valley": ("チリ","Maipo Valley"),
        "Colchagua Valley": ("チリ","Colchagua Valley"),
        "Casablanca Valley": ("チリ","Casablanca Valley"),

        // アルゼンチン
        "Mendoza": ("アルゼンチン","Mendoza"),
        "Uco Valley": ("アルゼンチン","Uco Valley"),

        // 南アフリカ
        "Stellenbosch": ("南アフリカ","Stellenbosch"),
        "Paarl": ("南アフリカ","Paarl"),
        "Swartland": ("南アフリカ","Swartland"),

        // ドイツ
        "Mosel": ("ドイツ","Mosel"),
        "Rheingau": ("ドイツ","Rheingau"),
        "Rheinhessen": ("ドイツ","Rheinhessen"),
        "Pfalz": ("ドイツ","Pfalz"),

        // 日本
        "山梨": ("日本","山梨"),
        "長野": ("日本","長野"),
        "北海道": ("日本","北海道"),
        "山形": ("日本","山形"),
        "余市": ("日本","余市"),
        "勝沼": ("日本","勝沼")
    ]
}

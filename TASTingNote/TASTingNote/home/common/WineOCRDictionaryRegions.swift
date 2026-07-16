//
//  WineOCRDictionaryRegions.swift
//  TastingApp
//
//  Created by 佐々木 勇太 on 2026/07/13.
//
import Foundation

enum WineOCRDictionaryRegions {

    static let regions: [String: (country: String, region: String)] = [

        // =====================================================
        // 日本
        // =====================================================
        "日本": ("日本", "日本"),
        "山梨": ("日本", "山梨"),
        "勝沼": ("日本", "山梨"),
        "長野": ("日本", "長野"),
        "桔梗ヶ原": ("日本", "長野"),
        "高山村": ("日本", "長野"),
        "東御": ("日本", "長野"),
        "小諸": ("日本", "長野"),
        "北海道": ("日本", "北海道"),
        "余市": ("日本", "北海道"),
        "仁木": ("日本", "北海道"),
        "山形": ("日本", "山形"),
        "上山": ("日本", "山形"),
        "高畠": ("日本", "山形"),
        "新潟": ("日本", "新潟"),
        "岩手": ("日本", "岩手"),
        "宮崎": ("日本", "宮崎"),
        "熊本": ("日本", "熊本"),

        // =====================================================
        // フランス
        // =====================================================
        "France": ("フランス", "France"),
        "Bordeaux": ("フランス", "Bordeaux"),
        "Bordeaux Superieur": ("フランス", "Bordeaux"),
        "Bordeaux Supérieur": ("フランス", "Bordeaux"),
        "Medoc": ("フランス", "Médoc"),
        "Médoc": ("フランス", "Médoc"),
        "Margaux": ("フランス", "Margaux"),
        "Pauillac": ("フランス", "Pauillac"),
        "Saint Julien": ("フランス", "Saint-Julien"),
        "Saint Estephe": ("フランス", "Saint-Estèphe"),
        "Pomerol": ("フランス", "Pomerol"),
        "Saint Emilion": ("フランス", "Saint-Émilion"),
        "Saint-Émilion": ("フランス", "Saint-Émilion"),

        "Bourgogne": ("フランス", "Bourgogne"),
        "Burgundy": ("フランス", "Bourgogne"),
        "Chablis": ("フランス", "Chablis"),
        "Meursault": ("フランス", "Meursault"),
        "Puligny Montrachet": ("フランス", "Puligny-Montrachet"),
        "Chassagne Montrachet": ("フランス", "Chassagne-Montrachet"),
        "Vosne Romanee": ("フランス", "Vosne-Romanée"),
        "Gevrey Chambertin": ("フランス", "Gevrey-Chambertin"),
        "Nuits Saint Georges": ("フランス", "Nuits-Saint-Georges"),

        "Champagne": ("フランス", "Champagne"),
        "Alsace": ("フランス", "Alsace"),
        "Loire": ("フランス", "Loire"),
        "Sancerre": ("フランス", "Sancerre"),
        "Pouilly Fume": ("フランス", "Pouilly-Fumé"),
        "Cotes du Rhone": ("フランス", "Côtes du Rhône"),
        "Hermitage": ("フランス", "Hermitage"),
        "Crozes Hermitage": ("フランス", "Crozes-Hermitage"),
        "Condrieu": ("フランス", "Condrieu"),
        "Chateauneuf du Pape": ("フランス", "Châteauneuf-du-Pape"),
        
        // ボルドー
        "Graves": ("フランス", "Graves"),
        "Pessac Leognan": ("フランス", "Pessac-Léognan"),
        "Pessac-Léognan": ("フランス", "Pessac-Léognan"),
        "Listrac": ("フランス", "Listrac-Médoc"),
        "Moulis": ("フランス", "Moulis-en-Médoc"),
        "Fronsac": ("フランス", "Fronsac"),
        "Canon Fronsac": ("フランス", "Canon-Fronsac"),
        "Lalande de Pomerol": ("フランス", "Lalande-de-Pomerol"),
        "Cotes de Castillon": ("フランス", "Castillon Côtes de Bordeaux"),
        
        // ブルゴーニュ
        "Corton": ("フランス", "Corton"),
        "Corton Charlemagne": ("フランス", "Corton-Charlemagne"),
        "Montrachet": ("フランス", "Montrachet"),
        "Batard Montrachet": ("フランス", "Bâtard-Montrachet"),
        "Chevalier Montrachet": ("フランス", "Chevalier-Montrachet"),
        "Bienvenues Batard Montrachet": ("フランス", "Bienvenues-Bâtard-Montrachet"),
        
        // ローヌ
        "Saint Joseph": ("フランス", "Saint-Joseph"),
        "Cornas": ("フランス", "Cornas"),
        "Vacqueyras": ("フランス", "Vacqueyras"),
        "Gigondas": ("フランス", "Gigondas"),
        "Tavel": ("フランス", "Tavel"),
        
        // ロワール
        "Vouvray": ("フランス", "Vouvray"),
        "Chinon": ("フランス", "Chinon"),
        "Muscadet": ("フランス", "Muscadet"),
        "Saumur": ("フランス", "Saumur"),

        // =====================================================
        // イタリア
        // =====================================================
        "Piemonte": ("イタリア", "Piemonte"),
        "Barolo": ("イタリア", "Barolo"),
        "Barbaresco": ("イタリア", "Barbaresco"),
        "Langhe": ("イタリア", "Langhe"),
        "Roero": ("イタリア", "Roero"),

        "Toscana": ("イタリア", "Toscana"),
        "Chianti": ("イタリア", "Chianti"),
        "Chianti Classico": ("イタリア", "Chianti Classico"),
        "Bolgheri": ("イタリア", "Bolgheri"),
        "Brunello di Montalcino": ("イタリア", "Brunello di Montalcino"),
        "Vino Nobile di Montepulciano": ("イタリア", "Vino Nobile di Montepulciano"),

        "Veneto": ("イタリア", "Veneto"),
        "Soave": ("イタリア", "Soave"),
        "Valpolicella": ("イタリア", "Valpolicella"),
        "Amarone": ("イタリア", "Amarone"),

        "Sicilia": ("イタリア", "Sicilia"),
        "Etna": ("イタリア", "Etna"),
        
        "Gattinara": ("イタリア", "Gattinara"),
        "Ghemme": ("イタリア", "Ghemme"),
        "Monferrato": ("イタリア", "Monferrato"),
        "Montalcino": ("イタリア", "Montalcino"),
        "Maremma": ("イタリア", "Maremma"),
        "Montepulciano d'Abruzzo": ("イタリア", "Montepulciano d'Abruzzo"),
        "Franciacorta": ("イタリア", "Franciacorta"),
        "Lugana": ("イタリア", "Lugana"),

        // =====================================================
        // スペイン
        // =====================================================
        "Rioja": ("スペイン", "Rioja"),
        "Rioja Alta": ("スペイン", "Rioja"),
        "Rioja Alavesa": ("スペイン", "Rioja"),
        "Ribera del Duero": ("スペイン", "Ribera del Duero"),
        "Priorat": ("スペイン", "Priorat"),
        "Rias Baixas": ("スペイン", "Rías Baixas"),
        "Jerez": ("スペイン", "Jerez"),
        "Cava": ("スペイン", "Cava"),
        
        "Toro": ("スペイン", "Toro"),
        "Rueda": ("スペイン", "Rueda"),
        "Bierzo": ("スペイン", "Bierzo"),
        "Jumilla": ("スペイン", "Jumilla"),
        "Montsant": ("スペイン", "Montsant"),

        // =====================================================
        // ドイツ
        // =====================================================
        "Mosel": ("ドイツ", "Mosel"),
        "Rheingau": ("ドイツ", "Rheingau"),
        "Rheinhessen": ("ドイツ", "Rheinhessen"),
        "Pfalz": ("ドイツ", "Pfalz"),
        "Nahe": ("ドイツ", "Nahe"),
        "Franken": ("ドイツ", "Franken"),
        "Baden": ("ドイツ", "Baden"),

        "Ahr": ("ドイツ", "Ahr"),
        "Mittelrhein": ("ドイツ", "Mittelrhein"),
        "Wurttemberg": ("ドイツ", "Württemberg"),
        
        // =====================================================
        // オーストリア
        // =====================================================
        "Wachau": ("オーストリア", "Wachau"),
        "Kamptal": ("オーストリア", "Kamptal"),
        "Kremstal": ("オーストリア", "Kremstal"),
        "Burgenland": ("オーストリア", "Burgenland"),
        
        "Weinviertel": ("オーストリア", "Weinviertel"),
        "Thermenregion": ("オーストリア", "Thermenregion"),

        // =====================================================
        // アメリカ
        // =====================================================
        "California": ("アメリカ", "California"),
        "Napa": ("アメリカ", "Napa Valley"),
        "Napa Valley": ("アメリカ", "Napa Valley"),
        "Sonoma": ("アメリカ", "Sonoma"),
        "Russian River Valley": ("アメリカ", "Russian River Valley"),
        "Paso Robles": ("アメリカ", "Paso Robles"),
        "Santa Barbara": ("アメリカ", "Santa Barbara"),
        "Willamette Valley": ("アメリカ", "Willamette Valley"),
        "Oregon": ("アメリカ", "Oregon"),
        "Washington State": ("アメリカ", "Washington State"),

        "Alexander Valley": ("アメリカ", "Alexander Valley"),
        "Dry Creek Valley": ("アメリカ", "Dry Creek Valley"),
        "Carneros": ("アメリカ", "Carneros"),
        "Santa Rita Hills": ("アメリカ", "Santa Rita Hills"),
        
        // =====================================================
        // カナダ
        // =====================================================
        "Niagara": ("カナダ", "Niagara"),
        "Okanagan": ("カナダ", "Okanagan Valley"),

        // =====================================================
        // オーストラリア
        // =====================================================
        "Barossa": ("オーストラリア", "Barossa Valley"),
        "Barossa Valley": ("オーストラリア", "Barossa Valley"),
        "McLaren Vale": ("オーストラリア", "McLaren Vale"),
        "Margaret River": ("オーストラリア", "Margaret River"),
        "Hunter Valley": ("オーストラリア", "Hunter Valley"),
        "Yarra Valley": ("オーストラリア", "Yarra Valley"),
        "Coonawarra": ("オーストラリア", "Coonawarra"),
        "Adelaide Hills": ("オーストラリア", "Adelaide Hills"),
        
        "Eden Valley": ("オーストラリア", "Eden Valley"),
        "Clare Valley": ("オーストラリア", "Clare Valley"),
        "Mornington Peninsula": ("オーストラリア", "Mornington Peninsula"),
        "Tasmania": ("オーストラリア", "Tasmania"),
        
        // =====================================================
        // ニュージーランド
        // =====================================================
        "Marlborough": ("ニュージーランド", "Marlborough"),
        "Central Otago": ("ニュージーランド", "Central Otago"),
        "Hawke's Bay": ("ニュージーランド", "Hawke's Bay"),
        "Wairarapa": ("ニュージーランド", "Wairarapa"),
        "Gisborne": ("ニュージーランド", "Gisborne"),
        
        "Canterbury": ("ニュージーランド", "Canterbury"),
        "Nelson": ("ニュージーランド", "Nelson"),
        "North Canterbury": ("ニュージーランド", "North Canterbury"),
        
        // =====================================================
        // チリ
        // =====================================================
        "Maipo Valley": ("チリ", "Maipo Valley"),
        "Colchagua Valley": ("チリ", "Colchagua Valley"),
        "Casablanca Valley": ("チリ", "Casablanca Valley"),
        "Aconcagua": ("チリ", "Aconcagua"),

        // =====================================================
        // アルゼンチン
        // =====================================================
        "Mendoza": ("アルゼンチン", "Mendoza"),
        "Uco Valley": ("アルゼンチン", "Uco Valley"),
        "Salta": ("アルゼンチン", "Salta"),
        "Patagonia": ("アルゼンチン", "Patagonia"),

        // =====================================================
        // 南アフリカ
        // =====================================================
        "Stellenbosch": ("南アフリカ", "Stellenbosch"),
        "Paarl": ("南アフリカ", "Paarl"),
        "Swartland": ("南アフリカ", "Swartland"),
        "Walker Bay": ("南アフリカ", "Walker Bay"),

        "Constantia": ("南アフリカ", "Constantia"),
        "Elgin": ("南アフリカ", "Elgin"),
        
        // =====================================================
        // ポルトガル
        // =====================================================
        "Douro": ("ポルトガル", "Douro"),
        "Dao": ("ポルトガル", "Dão"),
        "Vinho Verde": ("ポルトガル", "Vinho Verde"),

        "Alentejo": ("ポルトガル", "Alentejo"),
        "Bairrada": ("ポルトガル", "Bairrada"),

        // =====================================================
        // ギリシャ
        // =====================================================
        "Santorini": ("ギリシャ", "Santorini"),
        "Nemea": ("ギリシャ", "Nemea"),

        // =====================================================
        // ハンガリー
        // =====================================================
        "Tokaji": ("ハンガリー", "Tokaji"),
        
        // =====================================================
        // ジョージア
        // =====================================================
        "Kakheti": ("ジョージア", "Kakheti"),
        "Kartli": ("ジョージア", "Kartli"),
        "Imereti": ("ジョージア", "Imereti"),
        
        // =====================================================
        // イギリス
        // =====================================================
        "Sussex": ("イギリス", "Sussex"),
        "Kent": ("イギリス", "Kent"),
        "Hampshire": ("イギリス", "Hampshire"),
        
        // =====================================================
        // 中国
        // =====================================================
        "Ningxia": ("中国", "Ningxia"),
        "Shandong": ("中国", "Shandong"),
        "Xinjiang": ("中国", "Xinjiang"),
        
        // =====================================================
        // ブラジル
        // =====================================================
        "Serra Gaucha": ("ブラジル", "Serra Gaúcha"),
        
        // =====================================================
        // ウルグアイ
        // =====================================================
        "Canelones": ("ウルグアイ", "Canelones"),
    ]
}

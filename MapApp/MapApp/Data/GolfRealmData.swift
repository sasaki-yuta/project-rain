//
//  GoldRealmData.swift
//  MapApp
//
//  Created by 佐々木勇太 on 2021/08/29.
//  Copyright © 2021 rain-00-00-09. All rights reserved.
//

import Foundation
import RealmSwift

// データ操作クラス
class GolfRealmControl: NSObject {
    var realm: Realm!
        
    // インスタンス生成時、マイグレーションしてRealmをインスタンス化する
    override init() {
        var config = Realm.Configuration()
        config.migrationBlock = { migration, oldSchemaVersion in
            // 設定していなければ oldSchemaVersion はゼロがデフォルトです
            print(oldSchemaVersion)
            if oldSchemaVersion < 1 {
                // 保存されている User 全てを列挙
            
            }
            if oldSchemaVersion < 2 {
                
            }
        }
        // 現在のRealmファイルの schemaVersion と、下記で設定した schemaVersion が違うと、マイグレーションが実行される
        config.schemaVersion = 0
        Realm.Configuration.defaultConfiguration = config
        
        realm = try! Realm()
    }
    
    // ラウンド中？
    func isRound() -> Bool {
        var result = false
        // realmから取得する
        let realmRoundData = realm.objects(GolfOneRoundData.self)
        if 0 < realmRoundData.count {
            result = true
        }
        return result
    }

    // ラウンド中のデータの取得(ラウンド中でなければラウンド中としてデータ生成する)
    func getRoundData() -> GolfOneRoundData {
        var letval = GolfOneRoundData()
        // realmから取得する
        let realmRoundData = realm.objects(GolfOneRoundData.self)
        if 0 < realmRoundData.count {
            print(realmRoundData.count)
            letval = realmRoundData[0] // １件しか存在しないが２件以上取れた場合は１件目を設定
        }
        else {
            letval.create()
        }
        return letval
    }

    // ゴルフコース設定 View GolfInputScoreで入力した情報を保存する
    func setGolfCource(_ course: String, _ date: String, _ lon: Double, _ lat: Double) {
        // realmから取得する
        let realmRoundData = realm.objects(GolfOneRoundData.self)
        if 0 < realmRoundData.count {
            try! realm.write {
                realmRoundData[0].courseName = course
                realmRoundData[0].roundDate = date
                realmRoundData[0].lon = lon
                realmRoundData[0].lat = lat
            }
        }
        else {
            let setdata = GolfOneRoundData()
            setdata.create()
            setdata.courseName = course
            setdata.roundDate = date
            setdata.lon = lon
            setdata.lat = lat
            
            try! realm.write {
                realm.add(setdata)
            }
        }
    }
    
    // ラウンド中のデータの確定
    func fixRoundData(_ round: GolfOneRoundData) {
        try! realm.write {
            realm.add(round)
        }
    }
    
}

// プレイヤーデータ
class PlayerInfo: Object {
    @objc dynamic var name:String?
}

// ラウンドデータ
class GolfOneRoundData: Object {
    @objc dynamic var pid: String?          // 主キー(0:現在のラウンドデータ、1以降が保存データ)
    @objc dynamic var courseName: String?   // ゴルフ場名
    @objc dynamic var roundDate: String?    // 日時 @objc dynamic var value = Date()
    @objc dynamic var lon:Double = 0.0      // ゴルフ場の座標
    @objc dynamic var lat:Double = 0.0      // ゴルフ場の座標
    let score_my = List<Int>()              // 本人のスコア

//    let score_p2 = RealmOptional<Int>()     // Player3スコア
//    let score_p3 = RealmOptional<Int>()     // Player3スコア
//    let score_p4 = RealmOptional<Int>()     // Player4スコア
    
    
//    @objc dynamic var players: [String] = []    // 本人以外のプレイヤー
    
    // プライマリキー
    override static func primaryKey() -> String? {
        return "pid"
    }
    
    func create() {
        let uuid = UUID()
        pid = String()
        pid = uuid.uuidString
        courseName = String()
        roundDate = String()
        for _ in 0 ..< 18 {
            score_my.append(0)
        }
    }
}

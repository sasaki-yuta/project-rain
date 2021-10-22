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
        config.schemaVersion = 2
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
    func setGolfCource(_ course: String, _ adr: String, _ date: String, _ lon: Double, _ lat: Double) {
        // realmから取得する
        let realmRoundData = realm.objects(GolfOneRoundData.self)
        if 0 < realmRoundData.count {
            try! realm.write {
                realmRoundData[0].courseName = course
                realmRoundData[0].courseAdr = adr
                realmRoundData[0].roundDate = date
                realmRoundData[0].lon = lon
                realmRoundData[0].lat = lat
            }
        }
        else {
            let setdata = GolfOneRoundData()
            setdata.create()
            setdata.courseName = course
            setdata.courseAdr = adr
            setdata.roundDate = date
            setdata.lon = lon
            setdata.lat = lat
            
            try! realm.write {
                realm.add(setdata)
            }
        }
    }
    
    // ラウンド中のデータを削除
    func deleteGolfCource() {
        // realmから削除する
        let realmRoundData = realm.objects(GolfOneRoundData.self)
        if 0 < realmRoundData.count {
            try! realm.write {
                realm.delete(realmRoundData)
            }
        }
    }
    
    // ラウンド中のデータを確定
    func saveGolfCource() {
        let realmRoundData = realm.objects(GolfOneRoundData.self)
        if 0 < realmRoundData.count {
            try! realm.write {
                let addData = GolfRoundData()
                addData.courseAdr = realmRoundData[0].courseAdr
                addData.courseName = realmRoundData[0].courseName
                addData.lat = realmRoundData[0].lat
                addData.lon = realmRoundData[0].lon
                addData.name_2 = realmRoundData[0].name_2
                addData.name_3 = realmRoundData[0].name_3
                addData.name_4 = realmRoundData[0].name_4
                addData.par_num = realmRoundData[0].par_num
                addData.pid = realmRoundData[0].pid
                addData.roundDate = realmRoundData[0].roundDate
                addData.score_2 = realmRoundData[0].score_2
                addData.score_2_act = realmRoundData[0].score_2_act
                addData.score_2_pad = realmRoundData[0].score_2_pad
                addData.score_3 = realmRoundData[0].score_3
                addData.score_3_act = realmRoundData[0].score_3_act
                addData.score_3_pad = realmRoundData[0].score_3_pad
                addData.score_4 = realmRoundData[0].score_4
                addData.score_4_act = realmRoundData[0].score_4_act
                addData.score_4_pad = realmRoundData[0].score_4_pad
                addData.score_my = realmRoundData[0].score_my
                addData.score_my_act = realmRoundData[0].score_my_act
                addData.score_my_pad = realmRoundData[0].score_my_pad
                realm.add(addData)
                realm.delete(realmRoundData)
            }
        }
    }
    
    // スコア設定 View GolfInputScoreで入力した情報を保存する
    func setGolfScore(_ par_num: [Int] ,_ score_my: [Int], _ score_my_pad: [Int], _ score_my_act: [Int],_ score_2: [Int], _ score_2_pad: [Int], _ score_2_act: [Int],_ score_3: [Int], _ score_3_pad: [Int], _ score_3_act: [Int], _ score_4: [Int], _ score_4_pad: [Int], _ score_4_act: [Int], _ name_2: String, _ name_3: String, _ name_4: String, _ isFirst: Bool) {
        // realmから取得する
        let realmRoundData = realm.objects(GolfOneRoundData.self)
        if 0 < realmRoundData.count {
            try! realm.write {
                if isFirst {
                    realmRoundData[0].isOut = true
                    var j = 0
                    for i in 0 ..< 9 {
                        realmRoundData[0].par_num[i] = par_num[j]
                        realmRoundData[0].score_my[i] = score_my[j]
                        realmRoundData[0].score_my_pad[i] = score_my_pad[j]
                        realmRoundData[0].score_my_act[i] = score_my_act[j]
                        realmRoundData[0].name_2 = name_2
                        realmRoundData[0].score_2[i] = score_2[j]
                        realmRoundData[0].score_2_pad[i] = score_2_pad[j]
                        realmRoundData[0].score_2_act[i] = score_2_act[j]
                        realmRoundData[0].name_3 = name_3
                        realmRoundData[0].score_3[i] = score_3[j]
                        realmRoundData[0].score_3_pad[i] = score_3_pad[j]
                        realmRoundData[0].score_3_act[i] = score_3_act[j]
                        realmRoundData[0].name_4 = name_4
                        realmRoundData[0].score_4[i] = score_4[j]
                        realmRoundData[0].score_4_pad[i] = score_4_pad[j]
                        realmRoundData[0].score_4_act[i] = score_4_act[j]
                        j = j + 1
                    }
                }
                else {
                    realmRoundData[0].isOut = false
                    var j = 0
                    for i in 9 ..< 18 {
                        realmRoundData[0].par_num[i] = par_num[j]
                        realmRoundData[0].score_my[i] = score_my[j]
                        realmRoundData[0].score_my_pad[i] = score_my_pad[j]
                        realmRoundData[0].score_my_act[i] = score_my_act[j]
                        realmRoundData[0].name_2 = name_2
                        realmRoundData[0].score_2[i] = score_2[j]
                        realmRoundData[0].score_2_pad[i] = score_2_pad[j]
                        realmRoundData[0].score_2_act[i] = score_2_act[j]
                        realmRoundData[0].name_3 = name_3
                        realmRoundData[0].score_3[i] = score_3[j]
                        realmRoundData[0].score_3_pad[i] = score_3_pad[j]
                        realmRoundData[0].score_3_act[i] = score_3_act[j]
                        realmRoundData[0].name_4 = name_4
                        realmRoundData[0].score_4[i] = score_4[j]
                        realmRoundData[0].score_4_pad[i] = score_4_pad[j]
                        realmRoundData[0].score_4_act[i] = score_4_act[j]
                        j = j + 1
                    }
                }
            }
        }
    }
    
    // プレイヤー情報の取得(realmになければ初期値で保存する)
    func getPlayerInfo() -> PlayerInfo {
        var letval = PlayerInfo()
        // realmから取得する
        let realmRoundData = realm.objects(PlayerInfo.self)
        if 0 < realmRoundData.count {
            print(realmRoundData.count)
            letval = realmRoundData[0] // １件しか存在しないが２件以上取れた場合は１件目を設定
        }
        else {
            letval.create()
            try! realm.write {
                realm.add(letval)
            }
        }
        return letval
    }
    
    // プレイヤー名の設定
    func setPlayerName(_ name: String) {
        // realmから取得する
        let realmRoundData = realm.objects(PlayerInfo.self)
        if 0 < realmRoundData.count {
            try! realm.write {
                realmRoundData[0].name = name
            }
        }
    }
}

// プレイヤーデータ
class PlayerInfo: Object {
    @objc dynamic var name:String?
    
    func create() {
        name = String()
        name = "本人"
    }
}

// ラウンドデータ
class GolfOneRoundData: Object {
    @objc dynamic var isOut = true
    @objc dynamic var pid: String?          // 主キー(0:現在のラウンドデータ、1以降が保存データ)
    @objc dynamic var courseName: String?   // ゴルフ場名
    @objc dynamic var courseAdr: String?    // ゴルフ場住所
    @objc dynamic var roundDate: String?    // 日時 @objc dynamic var value = Date()
    @objc dynamic var lon:Double = 0.0      // ゴルフ場の座標
    @objc dynamic var lat:Double = 0.0      // ゴルフ場の座標
    var par_num = List<Int>()               // Par

    var score_my = List<Int>()              // 本人のスコア
    var score_my_pad = List<Int>()          // 本人のスコア
    var score_my_act = List<Int>()          // 本人のスコア

    @objc dynamic var name_2: String?       // 二人目名前
    var score_2 = List<Int>()               // 二人目スコア
    var score_2_pad = List<Int>()           // 二人目スコア
    var score_2_act = List<Int>()           // 二人目スコア
    
    @objc dynamic var name_3: String?       // 三人目名前
    var score_3 = List<Int>()               // 三人目スコア
    var score_3_pad = List<Int>()           // 三人目スコア
    var score_3_act = List<Int>()           // 三人目スコア
    
    @objc dynamic var name_4: String?       // 四人目名前
    var score_4 = List<Int>()               // 四人目スコア
    var score_4_pad = List<Int>()           // 四人目スコア
    var score_4_act = List<Int>()           // 四人目スコア
    
    // プライマリキー
    override static func primaryKey() -> String? {
        return "pid"
    }
    
    func create() {
        let uuid = UUID()
        pid = String()
        pid = uuid.uuidString
        courseName = String()
        courseAdr = String()
        roundDate = String()
        name_2 = String()
        name_3 = String()
        name_4 = String()
        for _ in 0 ..< 18 {
            par_num.append(-1)
            score_my.append(-1)
            score_my_pad.append(-1)
            score_my_act.append(-1)
            score_2.append(-1)
            score_2_pad.append(-1)
            score_2_act.append(-1)
            score_3.append(-1)
            score_3_pad.append(-1)
            score_3_act.append(-1)
            score_4.append(-1)
            score_4_pad.append(-1)
            score_4_act.append(-1)
        }
    }
}

// 過去のラウンドデータ
class GolfRoundData: Object {
    @objc dynamic var pid: String?          // 主キー(0:現在のラウンドデータ、1以降が保存データ)
    @objc dynamic var courseName: String?   // ゴルフ場名
    @objc dynamic var courseAdr: String?    // ゴルフ場住所
    @objc dynamic var roundDate: String?    // 日時 @objc dynamic var value = Date()
    @objc dynamic var lon:Double = 0.0      // ゴルフ場の座標
    @objc dynamic var lat:Double = 0.0      // ゴルフ場の座標
    var par_num = List<Int>()               // Par

    var score_my = List<Int>()              // 本人のスコア
    var score_my_pad = List<Int>()          // 本人のスコア
    var score_my_act = List<Int>()          // 本人のスコア

    @objc dynamic var name_2: String?       // 二人目名前
    var score_2 = List<Int>()               // 二人目スコア
    var score_2_pad = List<Int>()           // 二人目スコア
    var score_2_act = List<Int>()           // 二人目スコア
    
    @objc dynamic var name_3: String?       // 三人目名前
    var score_3 = List<Int>()               // 三人目スコア
    var score_3_pad = List<Int>()           // 三人目スコア
    var score_3_act = List<Int>()           // 三人目スコア
    
    @objc dynamic var name_4: String?       // 四人目名前
    var score_4 = List<Int>()               // 四人目スコア
    var score_4_pad = List<Int>()           // 四人目スコア
    var score_4_act = List<Int>()           // 四人目スコア
    
    // プライマリキー
    override static func primaryKey() -> String? {
        return "pid"
    }
}

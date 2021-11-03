//
//  GoldRealmData.swift
//  MapApp
//
//  Created by 佐々木勇太 on 2021/08/29.
//  Copyright © 2021 rain-00-00-09. All rights reserved.
//

import Foundation
import RealmSwift

// スコア分析データクラス
class ScoreAnalysData: NSObject {
    var s_bestScore:Int         = 0     // ベストスコア
    var s_totalRoundNum:Int     = 0     // 総ラウンド数
    var s_aveScore:Double       = 0     // 平均スコア
    var s_tipin_num:Int         = 0     // チップイン数
    var s_holeinone_num:Int     = 0     // ホールインワン数
    var s_albatross_num:Int     = 0     // アルバトロス数
    var s_eagle_num:Int         = 0     // イーグル数
    var s_birdie_num:Int        = 0     // バーディー数
    var s_par_num:Int           = 0     // パー数
    var s_bogie_num:Int         = 0     // ボギー数
    var s_doublebogey_num:Int   = 0     // ダブルボギー数
    var s_tripleboge_num:Int    = 0     // トリプルボギー以上
}

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
        config.schemaVersion = 3
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
    
    // 全ラウンドデータの取得
    func getGolfRoundData() -> Results<GolfRoundData> {
        // realmから取得する
        let realmGolfRoundData = realm.objects(GolfRoundData.self)
        return realmGolfRoundData
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
    
    // スコア１件削除
    func deleteGolfRoundData(_ pid:String) {
        // realmから削除する
        let realmGolfRoundData = realm.objects(GolfRoundData.self).filter("pid == %@", pid)
        if 0 < realmGolfRoundData.count {
            try! realm.write {
                realm.delete(realmGolfRoundData)
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
                
                // 18ラウンド分ループ
                for i in 0 ..< 18 {
                    // スコアが未入力ならSKIP
                    if 0 >= realmRoundData[0].score_my[i] {
                        continue
                    }
    
                    // スコア加算
                    addData.s_total_score += realmRoundData[0].score_my[i]

                    // ホールインワン数など記録するので１ホールのパー数が未入力ならSKIPする
                    if 0 >= realmRoundData[0].par_num[i] {
                        continue
                    }
                    
                    // ホールインワン数など記録
                    let diff = realmRoundData[0].score_my[i] - realmRoundData[0].par_num[i]
                    if 1 == realmRoundData[0].score_my[i] {
                        addData.s_holeinone_num += 1    // ホールインワン数
                    }
                    else if -3 == diff {
                        addData.s_albatross_num += 1    // アルバトロス数
                    }
                    else if -2 == diff {
                        addData.s_eagle_num += 1        // イーグル数
                    }
                    else if -1 == diff {
                        addData.s_birdie_num += 1       // バーディー数
                    }
                    else if 0 == diff {
                        addData.s_par_num += 1          // パー数
                    }
                    else if 1 == diff {
                        addData.s_bogie_num += 1        // ボギー数
                    }
                    else if 2 == diff {
                        addData.s_doublebogey_num += 1  // ダブルボギー数
                    }
                    else if 3 <= diff {
                        addData.s_tripleboge_num += 1   // トリプルボギー以上
                    }
                    else {
                        // スコア上ありえないので加算しない
                    }
                    
                    // チップイン数の加算
                    if 0 == realmRoundData[0].score_my_pad[i] {
                        addData.s_tipin_num += 1
                    }
                }
                
                realm.add(addData)
                realm.delete(realmRoundData)
            }
        }
    }
    
    // スコア分析に表示する情報を取得する
    func getScoreAnalysData() -> ScoreAnalysData {
        let ret = ScoreAnalysData()
        ret.s_bestScore = 999 // ありえないスコアで初期化
        let roundData = getGolfRoundData()
        var validScoreNum = 0   // 平均スコアを算出するための分母(有効なラウンド数)
        var validTotalScore = 0 // 平均スコアを算出するための分子(有効なスコア合計)

        for i in 0 ..< roundData.count {
            if 0 < roundData[i].s_total_score {
                validScoreNum += 1
                validTotalScore += roundData[i].s_total_score
                if roundData[i].s_total_score < ret.s_bestScore {
                    ret.s_bestScore = roundData[i].s_total_score    // ベストスコア
                }
            }
            
            ret.s_totalRoundNum += 1                                // 総ラウンド数（スコア０でもラウンドデータを一覧表示するためベストスコア計算の分母には使わない）
            ret.s_tipin_num += roundData[i].s_tipin_num             // チップイン数
            ret.s_holeinone_num += roundData[i].s_holeinone_num     // ホールインワン数
            ret.s_albatross_num += roundData[i].s_albatross_num     // アルバトロス数
            ret.s_eagle_num += roundData[i].s_eagle_num             // イーグル数
            ret.s_birdie_num += roundData[i].s_birdie_num           // バーディー数
            ret.s_par_num += roundData[i].s_par_num                 // パー数
            ret.s_bogie_num += roundData[i].s_bogie_num             // ボギー数
            ret.s_doublebogey_num += roundData[i].s_doublebogey_num // ダブルボギー数
            ret.s_tripleboge_num += roundData[i].s_tripleboge_num   // トリプルボギー以上
        }
        
        // 1件もスコアが入力されていない場合はベストスコアを999から初期値の0に戻す
        if (999 == ret.s_bestScore) {
            ret.s_bestScore = 0
        }
        
        if 0 < validScoreNum {
            ret.s_aveScore = Double(validTotalScore / validScoreNum)  // 平均スコア
        }

        return ret
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
    
    // スコア管理用データ
    @objc dynamic var s_total_score:Int = 0       // スコア
    @objc dynamic var s_tipin_num:Int = 0         // チップイン数
    @objc dynamic var s_holeinone_num:Int = 0     // ホールインワン数
    @objc dynamic var s_albatross_num:Int = 0     // アルバトロス数
    @objc dynamic var s_eagle_num:Int = 0         // イーグル数
    @objc dynamic var s_birdie_num:Int = 0        // バーディー数
    @objc dynamic var s_par_num:Int = 0           // パー数
    @objc dynamic var s_bogie_num:Int = 0         // ボギー数
    @objc dynamic var s_doublebogey_num:Int = 0   // ダブルボギー数
    @objc dynamic var s_tripleboge_num:Int = 0    // トリプルボギー以上
    
    // プライマリキー
    override static func primaryKey() -> String? {
        return "pid"
    }
}

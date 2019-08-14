//
//  CoreDataManager.swift
//  MapApp
//
//  Created by yuta sasaki on 2019/08/13.
//  Copyright © 2019 rain-00-00-09. All rights reserved.
//

import Foundation
import UIKit

class UserDataManager: NSObject {
    // UserDefaults(データバックアップ用)
    let userDefaults = UserDefaults.standard
    var totalMaxSpeed: Double = 0.0
    var totalDrivingDist: Double = 0.0
    var totalDrivingTime: Double = 0.0
    // UserDataに変化があるか判断するための変数
    var isMSpeed: Double = 0.0
    var isTDist: Double = 0.0
    var isTTime: Double = 0.0

    // クラスの初期化
    override init() {
        userDefaults.register(defaults: ["totalMaxSpeed": 0.0])
        userDefaults.register(defaults: ["totalDrivingDist": 0.0])
        userDefaults.register(defaults: ["totalDrivingTime": 0.0])
    }
    
    // 全データ読み込み
    func roadData() {
        totalMaxSpeed = userDefaults.object(forKey: "totalMaxSpeed") as! Double
        isMSpeed = totalMaxSpeed
        totalDrivingDist = userDefaults.object(forKey: "totalDrivingDist") as! Double
        isTDist = totalDrivingDist
        totalDrivingTime = userDefaults.object(forKey: "totalDrivingTime") as! Double
        isTTime = totalDrivingTime
    }
    
    // 全データ保存
    func saveData() {
        // Cycleデータ保存
        saveCycleData()
    }
    
    // 累計最高速度の取得
    func getTotalMaxSpeed() -> Double {
        return totalMaxSpeed
    }
    
    // 累計最高速度の設定
    func setTotalMaxSpeed(_ speed: Double) {
        totalMaxSpeed = speed
    }
    
    // 累計走行距離の取得
    func getTotalDrivingDist() -> Double {
        return totalDrivingDist
    }
    
    // 累計走行距離の設定
    func setTotalDrivingDist(_ dist: Double) {
        totalDrivingDist = dist
    }
    
    // 累計走行時間の取得
    func getTotalDrivingTime() -> Double {
        return totalDrivingTime
    }
    
    // 累計走行時間の設定
    func setTotalDrivingTime(_ time: Double) {
        totalDrivingTime = time
    }

    // Cycleデータ保存
    func saveCycleData() {
        var isSync = false
        if isMSpeed != totalMaxSpeed {
            userDefaults.set(totalMaxSpeed, forKey: "totalMaxSpeed")
            isMSpeed = totalMaxSpeed
            isSync = true
        }
        if isTDist != totalDrivingDist {
            userDefaults.set(totalDrivingDist, forKey: "totalDrivingDist")
            isTDist = totalDrivingDist
            isSync = true
        }
        if isTTime != totalDrivingTime {
            userDefaults.set(totalDrivingTime, forKey: "totalDrivingTime")
            isTTime = totalDrivingTime
            isSync = true
        }
        if true == isSync {
            userDefaults.synchronize()
        }
    }
    
    // Cycleデータ消去
    func deleteCycleData() {
        totalMaxSpeed = 0.0
        totalDrivingDist = 0.0
        totalDrivingTime = 0.0
        userDefaults.set(0.0, forKey: "totalMaxSpeed")
        userDefaults.set(0.0, forKey: "totalDrivingDist")
        userDefaults.set(0.0, forKey: "totalDrivingTime")
        userDefaults.synchronize()
    }
}


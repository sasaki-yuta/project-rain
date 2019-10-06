//
//  CoreDataManager.swift
//  MapApp
//
//  Created by yuta sasaki on 2019/08/13.
//  Copyright © 2019 rain-00-00-09. All rights reserved.
//

import Foundation
import UIKit
import MapKit

class UserDataManager: NSObject {
    //=======================================================
    // Golfeモード変数
    //=======================================================
    // MapType
    var golfMapType: UInt = MKMapType.standard.rawValue

    //=======================================================
    // Cycleモード変数
    //=======================================================
    // MapType(データバックアップ用：即時書き込み(saveのみでsetメソッドはない))
    var cycleMapType: UInt = MKMapType.standard.rawValue
    
    // UserDefaults(データバックアップ用:特定タイミングで書き込み)
    let userDefaults = UserDefaults.standard
    var totalMaxSpeed: Double = 0.0
    var totalDrivingDist: Double = 0.0
    var totalDrivingTime: Double = 0.0
    var timeInterval: Int = 5   // 初期値5秒
    var accuracy: Int = 20      // 初期値20m

    // UserDataに変化があるか判断するための変数
    var isMSpeed: Double = 0.0
    var isTDist: Double = 0.0
    var isTTime: Double = 0.0
    var isTimeInterval: Int = 5 // 初期値5秒
    var isAccuracy: Int = 20    // 初期値20m

    // 計測中のデータをアプリ起動中は保持する
    // 平均速度
    var avgSumSpeed: Double! = 0.0
    var avgSumCount: Int! = 0
    // 走行距離
    var dDrivingDist: Double! = 0.0
    // 走行時間
    var dDrivingTime: Double! = 0.0
    // MAX速度
    var dMaxSpeed: Double! = 0.0
    

    //=======================================================
    // 共通メソッド
    //=======================================================
    // クラスの初期化
    override init() {
        // Golfモード
        userDefaults.register(defaults: ["golfMapType": MKMapType.standard.rawValue])
        // Cycleモード
        userDefaults.register(defaults: ["cycleMapType": MKMapType.standard.rawValue])
        userDefaults.register(defaults: ["totalMaxSpeed": 0.0])
        userDefaults.register(defaults: ["totalDrivingDist": 0.0])
        userDefaults.register(defaults: ["totalDrivingTime": 0.0])
        userDefaults.register(defaults: ["timeInterval": 5])
        userDefaults.register(defaults: ["accuracy": 20])
    }
    
    // 全データ読み込み
    func roadData() {
        // Golfモード
        golfMapType = userDefaults.object(forKey: "golfMapType") as! UInt
        // Cycleモード
        cycleMapType = userDefaults.object(forKey: "cycleMapType") as! UInt
        totalMaxSpeed = userDefaults.object(forKey: "totalMaxSpeed") as! Double
        isMSpeed = totalMaxSpeed
        totalDrivingDist = userDefaults.object(forKey: "totalDrivingDist") as! Double
        isTDist = totalDrivingDist
        totalDrivingTime = userDefaults.object(forKey: "totalDrivingTime") as! Double
        isTTime = totalDrivingTime
        timeInterval = userDefaults.object(forKey: "timeInterval") as! Int
        isTimeInterval = timeInterval
        accuracy = userDefaults.object(forKey: "accuracy") as! Int
        isAccuracy = accuracy
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

    //=======================================================
    // Golfモードメソッド
    //=======================================================
    // Golfモードの地図Typeを保存
    func saveGolfMapType(_ type: MKMapType) {
        golfMapType = type.rawValue
        userDefaults.set(golfMapType, forKey: "golfMapType")
        userDefaults.synchronize()
    }
    
    // Golfモードの地図Typeを取得
    func getGolfMapType() -> MKMapType {
        return MKMapType.init(rawValue: golfMapType)!
    }
    
    //=======================================================
    // Cycleモードメソッド
    //=======================================================
    // Cycleモードの地図Typeを保存
    func saveCycleMapType(_ type: MKMapType) {
        cycleMapType = type.rawValue
        userDefaults.set(cycleMapType, forKey: "cycleMapType")
        userDefaults.synchronize()
    }
    
    // Cycleモードの地図Typeを取得
    func getCycleMapType() -> MKMapType {
        return MKMapType.init(rawValue: cycleMapType)!
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

    // 累計走行時間の取得
    func getTimeInterval() -> Int {
        return timeInterval
    }
    
    // 累計走行時間の設定
    func setTimeInterval(_ Interval: Int) {
        timeInterval = Interval
    }

    // 累計走行時間の取得
    func getAccuracy() -> Int {
        return accuracy
    }
    
    // 累計走行時間の設定
    func setAccuracy(_ acr: Int) {
        accuracy = acr
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
        if isTimeInterval != timeInterval {
            userDefaults.set(timeInterval, forKey: "timeInterval")
            isTimeInterval = timeInterval
            isSync = true
        }
        if isAccuracy != accuracy {
            userDefaults.set(accuracy, forKey: "accuracy")
            isAccuracy = accuracy
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
    // Cycleデータ消去
    func deleteCycleSetupData() {
        timeInterval = 5
        accuracy = 20
        userDefaults.set(5, forKey: "timeInterval")
        userDefaults.set(20, forKey: "accuracy")
        userDefaults.synchronize()
    }

    // 計測中断、終了したデータを一時的に保存する
    // 平均速度設定
    func setAvgSumSpeed(_ speed: Double, _ count: Int) {
        avgSumSpeed = speed
        avgSumCount = count
    }
    // 平均速度取得
    func getAvgSumSpeed() -> Double {
        return avgSumSpeed
    }
    func getAvgSumCount() -> Int {
        return avgSumCount
    }
    
    // 走行距離設定
    func setDrivingDist(_ dist: Double) {
        dDrivingDist = dist
    }
    // 走行距離取得
    func getDrivingDist() -> Double {
        return dDrivingDist
    }
    
    // 走行時間設定
    func setDrivingTime(_ time: Double) {
        dDrivingTime = time
    }
    // 走行時間取得
    func getDrivingTime() -> Double {
        return dDrivingTime
    }
    
    // Max速度の設定
    func setMaxSpeed(_ speed: Double) {
    dMaxSpeed = speed
    }
    // MAX速度の取得
    func getMaxSpeed() -> Double {
    return dMaxSpeed
    }
    
}


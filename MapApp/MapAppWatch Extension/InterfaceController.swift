//
//  InterfaceController.swift
//  MapAppWatch Extension
//
//  Created by yuta sasaki on 2019/03/09.
//  Copyright © 2019 rain-00-00-09. All rights reserved.
//

import WatchKit
import Foundation
import WatchConnectivity
import CoreLocation

class InterfaceController:  WKInterfaceController,
                            WCSessionDelegate,
                            CLLocationManagerDelegate,
                            WKCrownDelegate {
    var session:WCSession!
    var dlon:Double! = 0    // iOS側でロングタップした地点の経度
    var dlat:Double! = 0    // iOS側でロングタップした地点の緯度
    var locationManager = CLLocationManager()
    var locCord2D:CLLocationCoordinate2D?   // watchOS側の現在位置
    var calcCord2D:CLLocationCoordinate2D?  // watchOS側の標高計測
    var dSpanlon:Double! = 0.005
    var dSpanlat:Double! = 0.005
    var sHeight:String! = "高低差：-"

    @IBOutlet var mapView: WKInterfaceMap!
    @IBOutlet weak var label: WKInterfaceLabel!
    @IBOutlet weak var modeLabel: WKInterfaceLabel!

    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        
        // Configure interface objects here.
        if (WCSession.isSupported()) {
            self.session = WCSession.default
            self.session.delegate = self
            self.session.activate()
        }
    }

    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()

        // 画面描画時(アクティブになった時)にiOSのアプリにデータ送信を要求する
        let contents =  ["GET":"LONLAT"]
        self.session.sendMessage(contents, replyHandler: { (replyMessage) -> Void in
            print (replyMessage);
        }) { (error) -> Void in
            print(error)
        }
        
        // crownSequencerにフォーカスを当てる
        crownSequencer.focus()
    }
    
    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }

    // Initializerメソッド
    override init() {
        super.init()

        // CLLocationManagerのdelegateを登録
        locationManager.delegate = self

        // 端末の位置情報サービスが有効である
        if CLLocationManager.locationServicesEnabled() {
            switch CLLocationManager.authorizationStatus() {
            // ユーザから位置情報利用の許可を一度得ている
            case .authorizedAlways, .authorizedWhenInUse:
                // 現在位置の更新を開始
                locationManager.startUpdatingLocation()
            case .notDetermined:
                print("notDetermined")
            case .restricted:
                print("restricted")
            case .denied:
                print("denied")
            }
        }
  
        // 地図の中心位置と縮尺を設定
        let coordinate = CLLocationCoordinate2DMake(37.331667, -122.030833)
        let span = MKCoordinateSpan(latitudeDelta: dSpanlat, longitudeDelta: dSpanlon)
        let region = MKCoordinateRegion(center: coordinate, span: span)
        mapView.setRegion(region)
        
        // Digital Crownのデリゲートを設定
        crownSequencer.delegate = self
    }

    // CLLocationManagerのdelegate：現在位置更新
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print(Date(), locations)
        
        // 現在位置をクラスのメンバ変数に保持する
        locCord2D = (locations.last?.coordinate)!
        
        // アノテーションを削除する
        mapView.removeAllAnnotations()

        // iOSから緯度経度を受信している場合
        if dlon != 0 && dlat != 0 {
            // 現在位置とiOSから受信した緯度経度との距離(m)を算出する
            let distance = calcDistance((locations.last?.coordinate)!)
            // mをyardに変換する
            let yardStr = Int(distance * 1.09361)
            // 距離をラベルのテキストに設定する
            let fontSize = UIFont.systemFont(ofSize: 20)
            let text = String(Int(distance).description + " m / " + yardStr.description + " y")
            let attrStr = NSAttributedString(string: text, attributes:[NSAttributedString.Key.font:fontSize])
            label.setAttributedText(attrStr)
            
            // ロングタッチポイントの緯度経度が有効であればアノテーションを設定する
            let cordinate2D = CLLocationCoordinate2DMake(dlat, dlon)
            mapView.addAnnotation(cordinate2D, with: .red)
        }
        
        // 現在位置のアノテーションを設定する
        mapView.addAnnotation(locCord2D!, with: .purple)
        
        // 地図の中心位置を現在位置に設定する
        updateCurrentLoc()
    }
    
    // Digital Crownのデリゲート
    func crownDidRotate(_ sequencer: WKCrownSequencer?, rotationalDelta: Double) {
        print("crownDidRotate rotationalDelta = " + rotationalDelta.description )

        var num: Double = 0
        
        // スケール変更量を微調整する
        if (0.01 > dSpanlat) || (0.01 > dSpanlon) {
            num = 0.0001
        }
        else if (0.1 > dSpanlat) || (0.1 > dSpanlon) {
            num = 0.001
        }
        else if (1.0 > dSpanlat) || (1.0 > dSpanlon) {
            num = 0.01
        }
        else if (10.0 > dSpanlat) || (1.0 > dSpanlon) {
            num = 0.1
        }
        else {
            num = 1.0
        }

        // 上に回転すると正の値が取得されるため、上回転でスケールを拡大したいので符号を逆転させる
        if (0 > rotationalDelta) {
            dSpanlat += num
            dSpanlon += num
        }
        else {
            dSpanlat -= num
            dSpanlon -= num
        }

        // 負の値になるとリセットするため最小値を設定
        if (0 > dSpanlat) || (0 > dSpanlon) {
            dSpanlat = 0.0
            dSpanlon = 0.0
        }
        // 最大値のチェック
        else if (36.0 <= dSpanlat) || (36.0 <= dSpanlon) {
            dSpanlat = 36.0
            dSpanlon = 36.0
        }
        else {
            // そのままのスケールを使用する
        }
        
        print("dSpanlat = " + dSpanlat.description, "dSpanlon = " + dSpanlat.description)
        updateCurrentLoc()
    }
    
    // 現在位置更新
    func updateCurrentLoc() {
        let coordinate = locCord2D!
        let span = MKCoordinateSpan(latitudeDelta: dSpanlat, longitudeDelta: dSpanlon)
        let region = MKCoordinateRegion(center: coordinate, span: span)
        mapView.setRegion(region)
    }
    
    // 2点間の距離(m)を算出する
    func calcDistance(_ a: CLLocationCoordinate2D) -> CLLocationDistance {
        // CLLocationオブジェクトを生成
        let aLoc: CLLocation = CLLocation(latitude: a.latitude, longitude: a.longitude)
        let cloclon:CLLocationDegrees = CLLocationDegrees(exactly: dlon)!
        let cloclat:CLLocationDegrees = CLLocationDegrees(exactly: dlat)!
        let bLoc: CLLocation = CLLocation(latitude: cloclat, longitude: cloclon)
        // CLLocationオブジェクトのdistanceで2点間の距離(m)を算出
        let dist = bLoc.distance(from: aLoc)
        return dist
    }
    
    // watchOSでは以下のメソッドの実装が必須(無いとエラーになる)
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
        print("session")
    }
    
    // iPhoneからMessage受信
    public func session(_ session: WCSession, didReceiveMessage message: [String : Any], replyHandler: @escaping ([String : Any]) -> Swift.Void){

        print("receiveMessage[watchOS]::\(message)")
        // String型以外は処理しない
        guard let resp_type = message["RESP"] as? String else {
            return
        }
        
        switch resp_type {
        // ゴルフモード 距離
        case "LONLAT":
            print("lonlat")
            guard let lon = message["lon"] as? Double else {
                return
            }
            guard let lat = message["lat"] as? Double else {
                return
            }
            
            // iOSからsendMessageで送信された緯度経度を変数に設定
            dlon = lon
            dlat = lat
            
            // アノテーションを削除する
            mapView.removeAllAnnotations()
            
            // iOSから緯度経度を受信した時にも現在位置との距離を表示する
            if (nil != locCord2D) {
                var text = ""
                
                // 現在位置のアノテーションを設定する
                mapView.addAnnotation(locCord2D!, with: .purple)
                
                if (0 != dlon) && (0 != dlat) {
                    // 現在位置とiOSから受信した緯度経度との距離(m)を算出する
                    let distance = calcDistance(locCord2D!)
                    // mをyardに変換する
                    let yardStr = Int(distance * 1.09361)
                    // 距離をラベルのテキストに設定する
                    text = String(Int(distance).description + " m / " + yardStr.description + " y")
                    
                    // 緯度経度が有効であればアノテーションを設定する
                    let cordinate2D = CLLocationCoordinate2DMake(dlat, dlon)
                    mapView.addAnnotation(cordinate2D, with: .red)
                }
                
                let fontSize = UIFont.systemFont(ofSize: 20)
                // モードタイトルを更新
                let attrStrTitle = NSAttributedString(string: "ゴルフモード", attributes:[NSAttributedString.Key.font:fontSize])
                modeLabel.setAttributedText(attrStrTitle)

                // タップした距離を表示
                let attrStr = NSAttributedString(string: text, attributes:[NSAttributedString.Key.font:fontSize])
                label.setAttributedText(attrStr)
            }

        // ゴルフモード 高低差
        case "HEIGHT":
            print("height")
            guard let str = message["STR"] as? String else {
                return
            }
            sHeight = str

        // モード
        case "MODE":
            print("mode")
            guard let str = message["title"] as? String else {
                return
            }

            // モードタイトルを更新
            let fontSize = UIFont.systemFont(ofSize: 20)
            let attrStrTitle = NSAttributedString(string: str, attributes:[NSAttributedString.Key.font:fontSize])
            modeLabel.setAttributedText(attrStrTitle)
            
        default:
            break
        }

    }
    
    // 高低差計測ボタンタッチダウン
    @IBAction func btnGetElevationTouchDown() {
        // 画面描画時(アクティブになった時)にiOSのアプリにデータ送信を要求する
        let lon:Double = locCord2D!.longitude
        let lat:Double = locCord2D!.latitude
        let contents =  ["GET":"HEIGHT", "lon":lon, "lat":lat] as [String : Any]
        self.session.sendMessage(contents, replyHandler: { (replyMessage) -> Void in
            print (replyMessage);
        }) { (error) -> Void in
            print(error)
        }
    }
}

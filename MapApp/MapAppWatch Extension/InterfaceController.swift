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
                            CLLocationManagerDelegate {
    var session:WCSession!
    var dlon:Double! = 0
    var dlat:Double! = 0
    var locationManager = CLLocationManager()
    var locCord2D:CLLocationCoordinate2D?

    @IBOutlet weak var label: WKInterfaceLabel!
    @IBOutlet var mapView: WKInterfaceMap!
    
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
  
        let coordinate = CLLocationCoordinate2DMake(37.331667, -122.030833)
        let span = MKCoordinateSpan(latitudeDelta: 0.005, longitudeDelta: 0.005)
        let region = MKCoordinateRegion(center: coordinate, span: span)
        mapView.setRegion(region)
    }

    // CLLocationManagerのdelegate：現在位置更新
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print(Date(), locations)
        
        // 現在位置をクラスのメンバ変数に保持する
        locCord2D = (locations.last?.coordinate)!
        
        // iOSから緯度経度を受信している場合
        if dlon != 0 && dlat != 0 {
            // 現在位置とiOSから受信した緯度経度との距離(m)を算出する
            let distance = calcDistance((locations.last?.coordinate)!)
            // mをyardに変換する
            let yardStr = Int(distance * 1.09361)
            // 距離をラベルのテキストに設定する
            let fontSize = UIFont.systemFont(ofSize: 20)
//          let text = String(Int(distance).description + "m" + "\n" + yardStr.description + "y")
            let text = String(yardStr.description + "y")
            let attrStr = NSAttributedString(string: text, attributes:[NSAttributedString.Key.font:fontSize])
            label.setAttributedText(attrStr)
        }

        let coordinate = (locations.last?.coordinate)!
        let span = MKCoordinateSpan(latitudeDelta: 0.005, longitudeDelta: 0.005)
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
        print("receiveMessage::\(message)")
        
        guard let lon = message["lon"] as? Double else {
            return
        }

        guard let lat = message["lat"] as? Double else {
            return
        }

        // iOSからsendMessageで送信された緯度経度を変数に設定
        dlon = lon
        dlat = lat

        // iOSから緯度経度を受信した時にも現在位置との距離を表示する
        if (nil != locCord2D) {
            var text = "no data"

            if (0 != dlon) && (0 != dlat) {
                // 現在位置とiOSから受信した緯度経度との距離(m)を算出する
                let distance = calcDistance(locCord2D!)
                // mをyardに変換する
                let yardStr = Int(distance * 1.09361)
                // 距離をラベルのテキストに設定する
//              text = String(Int(distance).description + "m" + "\n" + yardStr.description + "y")
                text = String(yardStr.description + "y")
            }

            let fontSize = UIFont.systemFont(ofSize: 20)
            let attrStr = NSAttributedString(string: text, attributes:[NSAttributedString.Key.font:fontSize])
            label.setAttributedText(attrStr)
        }
    }
}

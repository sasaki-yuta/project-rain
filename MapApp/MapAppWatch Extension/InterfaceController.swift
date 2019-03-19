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
                            CLLocationManagerDelegate { // sasaki
    var session:WCSession!
    var locationManager = CLLocationManager() // sasaki
    var dlon:Double! = 0 // sasaki
    var dlat:Double! = 0 // sasaki
    var locCord2D:CLLocationCoordinate2D? // sasaki

    @IBOutlet weak var label: WKInterfaceLabel!
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        
        // Configure interface objects here.
        if (WCSession.isSupported()) {
            self.session = WCSession.default
            self.session.delegate = self
            self.session.activate()
        }

        // sasaki
        // watchOSアプリ側の画面描画時にiOSアプリにデータを問い合わせる
        let contents =  ["get":"getlonlat"]
        self.session.sendMessage(contents, replyHandler: { (replyMessage) -> Void in
            print (replyMessage);
        }) { (error) -> Void in
            print(error)
        }
    }

    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()

        // sasaki
        // watchOSアプリ側の画面描画時にiOSアプリにデータを問い合わせる
        let contents =  ["get":"getlonlat"]
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

    // sasaki
    override init() {
        super.init()
        
        // delegate ON
        locationManager.delegate = self
        
        if CLLocationManager.locationServicesEnabled() {
            switch CLLocationManager.authorizationStatus() {
            case .authorizedAlways, .authorizedWhenInUse:
                // 座標の表示
                locationManager.startUpdatingLocation()
                
                break
            default:
                break
            }
        }
    }

    // sasaki
    // CLLocationManagerのdelegate：現在位置更新
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print(Date(), locations)

        if dlon != 0 && dlat != 0 {
            // 現在位置とiOSから受信した位置の距離(m)を算出する
            locCord2D = (locations.last?.coordinate)!
            let distance = calcDistance((locations.last?.coordinate)!)
            // yard
            let yardStr = Int(distance * 1.09361)
            label.setText(Int(distance).description + "m" + "\n" + yardStr.description + "y")
        }
    }
    
    // sasaki
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
        
        // sasaki start
        dlon = lon
        dlat = lat

        if nil != locCord2D {
            let distance = calcDistance(locCord2D!)
            // yard
            let yardStr = Int(distance * 1.09361)
            label.setText(Int(distance).description + "m" + "\n" + yardStr.description + "y")
        }
        // sasaki end
    }
}

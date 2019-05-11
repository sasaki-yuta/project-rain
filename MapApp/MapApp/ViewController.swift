//
//  ViewController.swift
//  MapApp
//
//  Created by yuta sasaki on 2019/02/16.
//  Copyright © 2019 rain-00-00-09. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation
import WatchConnectivity

// 国土地理院の標高取得WebAPIのOutputパラメータ
struct JsonElevation : Codable{
    var elevation : Double
    var hsrc : String
}

// アノテーション用クラス
class AplAnnotation: NSObject, MKAnnotation {
//  static let clusteringIdentifier = "Group Name" 今はグルーピングするアノテーションがないためデフォルトにする
    let coordinate: CLLocationCoordinate2D
    let glyphText: String
    let glyphTintColor: UIColor
    let markerTintColor: UIColor
    
    init(_ coordinate: CLLocationCoordinate2D, glyphText: String, glyphTintColor: UIColor, markerTintColor: UIColor) {
        self.coordinate = coordinate
        self.glyphText = glyphText
        self.glyphTintColor = glyphTintColor
        self.markerTintColor = markerTintColor
    }
}

// MKPointAnnotation拡張用クラス
class MapAnnotationSetting: MKPointAnnotation {
    var pinColor: UIColor = .red
    
    func setPinColor(_ color: UIColor) {
        pinColor = color
    }
}


class ViewController:   UIViewController,
                        CLLocationManagerDelegate,
                        UIGestureRecognizerDelegate,
                        WCSessionDelegate {

    @IBOutlet var mapView: MKMapView!
    @IBOutlet var longPressGesRec: UILongPressGestureRecognizer!
    @IBOutlet var mapViewTypeOver: UIButton!

    var locManager: CLLocationManager!
    var pointAno: MapAnnotationSetting = MapAnnotationSetting()
    var calcPointAno: AplAnnotation!
    var mapViewType: UIButton!
    var session: WCSession!
    var dlon:Double! = 0
    var dlat:Double! = 0
    
    // Infomationに表示するラベル
    var lblInfoBarBack: UILabel = UILabel()
    var lblNowElevation: UILabel = UILabel()
    var lblLongTapElevation: UILabel = UILabel()
    var lblDiffElevation: UILabel = UILabel()
    var lblDestMeter: UILabel = UILabel()
    var lblDestYard: UILabel = UILabel()

    // ロングタップした位置との標高差を取得する変数
    var currentElevation: Double = -100000.0
    var longTapElevation: Double = -100000.0

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

        // AppDelegateに追加したviewControllerに自身を設定
        let appDelegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.viewController = self
        
        // セッションをアクティブにする
        if (WCSession.isSupported()) {
            self.session = WCSession.default
            self.session.delegate = self
            self.session.activate()
        }

        // MapViewのdelegateを登録する
        mapView.delegate = self
        
        // CLLocationManagerのdelegateを登録する
        locManager = CLLocationManager()
        locManager.delegate = self

        // 位置情報の使用の許可を得る
        locManager.requestWhenInUseAuthorization()
        if CLLocationManager.locationServicesEnabled() {
            switch CLLocationManager.authorizationStatus() {
            case .authorizedWhenInUse:
                // 現在位置の更新を開始
                locManager.startUpdatingLocation()
                break
            default:
                break
            }
        }
        
        // 地図の初期化
        initMap()
    }
    
    // セッションアクティブ化の結果が通知される(無いとエラーになる)
    public func session(_ session: WCSession, activationDidCompleteWith activationState:    WCSessionActivationState, error: Error?){
        switch activationState {
        case .activated:
            print("セッションアクティブ")
        case .inactive:
            print("セッションはアクティブでデータ受信できる可能性はあるが、相手にはデータ送信できない")
        case .notActivated:
            print("セッション非アクティブで通信できない状態")
            let errStr = error?.localizedDescription.description
            print("error: " + (errStr?.description)!)
        }
    }
    
    public func sessionDidBecomeInactive(_ session: WCSession){
        print("sessionDidBecomeInactive")
    }
    
    public func sessionDidDeactivate(_ session: WCSession){
        print("sessionDidDeactivate")
    }
    
    // watchOSからMessage受信
    public func session(_ session: WCSession, didReceiveMessage message: [String : Any], replyHandler: @escaping ([String : Any]) -> Swift.Void){
        print("receiveMessage::\(message)")
        replyHandler(["message" : "received message."])

        // String型以外は処理しない
        guard let getType = message["GET"] as? String else {
            return
        }

        switch getType {
        case "LONLAT":
            // watchOSにロングタップしてピンを立てた地点の緯度経度を送信
            sendMessageLonLat()
        default:
            print("not exist type.")
        }
    }
    
    public func session(_ session: WCSession, didFinish userInfoTransfer: WCSessionUserInfoTransfer, error: Error?) {
        print("userInfoTransfer::\(userInfoTransfer)")
    }

    // 地図の初期化
    func initMap() {
        // 縮尺を設定
        var region:MKCoordinateRegion = mapView.region
        region.span.latitudeDelta = 0.02
        region.span.longitudeDelta = 0.02
        mapView.setRegion(region,animated:true)
        
        // 現在位置表示の有効化
        mapView.showsUserLocation = true
        // 現在位置設定
        mapView.userTrackingMode = .follow

        // デバイスの画面サイズを取得する
        let dispSize: CGSize = UIScreen.main.bounds.size
        let width = Int(dispSize.width)
        let height = Int(dispSize.height)
        
        // 地図のサイズを画面サイズに設定する
        mapView.frame.size = CGSize(width: width, height: height)
        
        // 地図表示タイプを切り替えるボタン
        mapViewType = UIButton(type: UIButton.ButtonType.detailDisclosure)
        mapViewType.frame = CGRect(x:width - 50, y:58, width:40, height:40)
        mapViewType.layer.backgroundColor = UIColor(white: 1, alpha: 0.8).cgColor // 背景色
        mapViewType.layer.masksToBounds = false
        mapViewType.layer.shadowColor = UIColor.black.cgColor
        mapViewType.layer.shadowOffset = CGSize(width: 2, height: 2)
        mapViewType.layer.shadowOpacity = 0.2
        mapViewType.layer.shadowRadius = 3 // ぼかし
        mapViewType.layer.cornerRadius = 5.0 // 角丸のサイズ
        self.view.addSubview(mapViewType)
//      mapViewType.addTarget(self, action: #selector(ViewController.mapViewTypeBtnThouchDown(_:)), for: .touchDown)
        
        mapViewTypeOver.frame = CGRect(x:width - 50, y:58, width:40, height:40)
        self.view.addSubview(mapViewTypeOver)
        
        // トラッキングボタン表示
        let trakingBtn = MKUserTrackingButton(mapView: mapView)
        trakingBtn.layer.backgroundColor = UIColor(white: 1, alpha: 0.8).cgColor
        trakingBtn.frame = CGRect(x:width - 50, y:100, width:40, height:40)
        trakingBtn.layer.shadowColor = UIColor.black.cgColor
        trakingBtn.layer.shadowColor = UIColor.black.cgColor
        trakingBtn.layer.shadowOffset = CGSize(width: 2, height: 2)
        trakingBtn.layer.shadowOpacity = 0.2
        trakingBtn.layer.shadowRadius = 3 // ぼかし
        trakingBtn.layer.cornerRadius = 5.0 // 角丸のサイズ
        self.view.addSubview(trakingBtn)
        
        // コンパスの表示
        let compass = MKCompassButton(mapView: mapView)
        compass.compassVisibility = .adaptive
        compass.frame = CGRect(x: width - 50, y: 150, width: 40, height: 40)
        self.view.addSubview(compass)
        // デフォルトのコンパスを非表示にする
        mapView.showsCompass = false

        // スケールバーの表示
        let scale = MKScaleView(mapView: mapView)
        scale.frame.origin.x = 15
        scale.frame.origin.y = 45
        scale.legendAlignment = .leading
        self.view.addSubview(scale)
        
        // Infomationに表示するラベル
        lblInfoBarBack.frame = CGRect(x: 0, y: height - 150, width: width, height: 90)
        lblInfoBarBack.backgroundColor = .black
        lblInfoBarBack.alpha = 0.5
        self.view.addSubview(lblInfoBarBack)
        
        lblDiffElevation.frame = CGRect(x: width - 170, y: height - 150, width: 140, height: 30)
        lblDiffElevation.font = UIFont.systemFont(ofSize: 15.0)
        lblDiffElevation.textColor = .green
        lblDiffElevation.text = "標高差：- m"
        self.view.addSubview(lblDiffElevation)

        lblNowElevation.frame = CGRect(x: width - 170, y: height - 120, width: 140, height: 30)
        lblNowElevation.font = UIFont.systemFont(ofSize: 15.0)
        lblNowElevation.textColor = .green
        lblNowElevation.text = "現在位置：- m"
        self.view.addSubview(lblNowElevation)
        
        lblLongTapElevation.frame = CGRect(x: width - 170, y: height - 90, width: 140, height: 30)
        lblLongTapElevation.font = UIFont.systemFont(ofSize: 15.0)
        lblLongTapElevation.textColor = .green
        lblLongTapElevation.text = "指定位置：- m"
        self.view.addSubview(lblLongTapElevation)

        lblDestMeter.frame = CGRect(x: 30, y: height - 150, width: 120, height: 30)
        lblDestMeter.font = UIFont.systemFont(ofSize: 15.0)
        lblDestMeter.textColor = .green
        lblDestMeter.text = "距離：- m"
        self.view.addSubview(lblDestMeter)

        lblDestYard.frame = CGRect(x: 30, y: height - 120, width: 120, height: 30)
        lblDestYard.font = UIFont.systemFont(ofSize: 15.0)
        lblDestYard.textColor = .green
        lblDestYard.text = "距離：- y"
        self.view.addSubview(lblDestYard)
    }

    // CLLocationManagerのdelegate：現在位置取得
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations:[CLLocation]) {
        let lonStr = (locations.last?.coordinate.longitude.description)!
        let latStr = (locations.last?.coordinate.latitude.description)!
        
        print("lon : " + lonStr)
        print("lat : " + latStr)

        if (true == isExistLongTapPoint()) {
            // 標高
//          let nowAlt = locations.last?.altitude
//          print("今の標高 = " + (nowAlt?.description)!)

            // 現在位置とタッウプした位置の距離(m)を算出する
            let distance = calcDistance(mapView.userLocation.coordinate, pointAno.coordinate)
            
            // ピンに設定する文字列を生成する
            var str:String = Int(distance).description
            str = str + " m"
            
            // yard
            let yardStr = Int(distance * 1.09361)
            str = str + " / " + yardStr.description + " y"
            
            if pointAno.title != str {
                // ピンまでの距離に変化があればtitleを更新する
                pointAno.title = str
                mapView.addAnnotation(pointAno)
                
                // Infomationを更新する
                lblDestMeter.text = "距離：" + Int(distance).description + " m"
                self.view.addSubview(lblDestMeter)
                lblDestYard.text = "距離：" + Int(distance * 1.09361).description + " y"
                self.view.addSubview(lblDestYard)
            }
        }
    }

    // 地図の中心位置の更新
    func updateCurrentPos(_ coordinate:CLLocationCoordinate2D) {
        var region:MKCoordinateRegion = mapView.region
        region.center = coordinate
        mapView.setRegion(region,animated:true)
    }
    
    // UILongPressGestureRecognizerのdelegate：ロングタップを検出する
    @IBAction func mapViewDidLongPress(_ sender: UILongPressGestureRecognizer) {
        // ロングタップ開始
        if sender.state == .began {
            // ロングタップ開始時に古いピンを削除する
            mapView.removeAnnotation(pointAno)
            dlon = 0
            dlat = 0
            
            // Infomationを更新する
            lblDestMeter.text = "距離：- m"
            self.view.addSubview(lblDestMeter)
            lblDestYard.text = "距離：- y"
            self.view.addSubview(lblDestYard)
        }
        // ロングタップ終了（手を離した）
        else if sender.state == .ended {
            // タップした位置（CGPoint）を指定してMkMapView上の緯度経度を取得する
            let tapPoint = sender.location(in: view)
            let center = mapView.convert(tapPoint, toCoordinateFrom: mapView)
 
            let lonStr = center.longitude.description
            let latStr = center.latitude.description
            print("lon : " + lonStr)
            print("lat : " + latStr)
            
            // 現在位置とタッウプした位置の距離(m)を算出する
            let distance = calcDistance(mapView.userLocation.coordinate, center)
            print("distance : " + distance.description)

            // ピンに設定する文字列を生成する
            var str:String = Int(distance).description
            str = str + " m"

            // yard
            let yardStr = Int(distance * 1.09361)
            str = str + " / " + yardStr.description + " y"
            
            // ロングタップを検出した位置にピンを立てる
            pointAno.coordinate = center
            pointAno.title = str
            mapView.addAnnotation(pointAno)
            
            // Infomationを更新する
            lblDestMeter.text = "距離：" + Int(distance).description + " m"
            self.view.addSubview(lblDestMeter)
            lblDestYard.text = "距離：" + Int(distance * 1.09361).description + " y"
            self.view.addSubview(lblDestYard)
            
            // watchOSにロングタップしてピンを立てた地点の緯度経度を送信
            dlon = center.longitude
            dlat = center.latitude
            sendMessageLonLat()
        }
    }
    
    // 2点間の距離(m)を算出する
    func calcDistance(_ a: CLLocationCoordinate2D, _ b: CLLocationCoordinate2D) -> CLLocationDistance {
        // CLLocationオブジェクトを生成
        let aLoc: CLLocation = CLLocation(latitude: a.latitude, longitude: a.longitude)
        let bLoc: CLLocation = CLLocation(latitude: b.latitude, longitude: b.longitude)
        
        // CLLocationオブジェクトのdistanceで2点間の距離(m)を算出
        let dist = bLoc.distance(from: aLoc)
        return dist
    }
    
    // 地図の表示タイプを切り替える
    @objc internal func mapViewTypeBtnThouchDown(_ sender: Any) {
        switch mapView.mapType {
        case .standard:         // 標準の地図
            mapView.mapType = .satellite
            break
        case .satellite:        // 航空写真
            mapView.mapType = .hybrid
            break
        case .hybrid:           // 標準の地図＋航空写真
            mapView.mapType = .satelliteFlyover
            break
        case .satelliteFlyover: // 3D航空写真
            mapView.mapType = .hybridFlyover
            break
        case .hybridFlyover:    // 3D標準の地図＋航空写真
            mapView.mapType = .mutedStandard
            break
        case .mutedStandard:    // 地図よりもデータを強調
            mapView.mapType = .standard
            break
        }
    }
    
    // 地図の表示タイプを切り替える
    func setMapType(_ mapType: MKMapType) {
        mapView.mapType = mapType
        
        // ステータスバーのスタイル変更を促す
        self.setNeedsStatusBarAppearanceUpdate();
    }
    
    // ステータスバー文字色を更新
    override var preferredStatusBarStyle: UIStatusBarStyle {
        var ret = UIStatusBarStyle.default
        
        if nil != mapView {
            if  (.standard != mapView.mapType) && (.mutedStandard != mapView.mapType) {
                ret = UIStatusBarStyle.lightContent
            }
        }
        
        return ret
    }
    
    // ロングタップした地点が存在するか？
    func isExistLongTapPoint() -> Bool {
        var retVal: Bool = false
        if 0 != dlon && 0 != dlat {
            retVal = true
        }
        return retVal
    }
    
    // ロングタップした地点を削除する
    func delLongTapPoint() {
        mapView.removeAnnotation(pointAno)
        dlon = 0
        dlat = 0
        if nil != calcPointAno {
            mapView.removeAnnotation(calcPointAno)
        }
        
        // Infomationを更新する
        lblDestMeter.text = "距離：- m"
        self.view.addSubview(lblDestMeter)
        lblDestYard.text = "距離：- y"
        self.view.addSubview(lblDestYard)
        lblDiffElevation.text = "標高差：- m"
        self.view.addSubview(lblDiffElevation)
        lblNowElevation.text = "現在位置：- m"
        self.view.addSubview(lblNowElevation)
        lblLongTapElevation.text = "指定位置：- m"
        self.view.addSubview(lblLongTapElevation)
        
        // watchOSに緯度経度を送信
        sendMessageLonLat()
    }
    
    // ロングタップした地点との標高差を表示する
    func showElevation() {
        // 初期値(無効値)を設定
        currentElevation = -100000.0
        longTapElevation = -100000.0

        // 国土地理院のURL
        let baseUrl = "http://cyberjapandata2.gsi.go.jp/general/dem/scripts/getelevation.php?"
        
        // 現在位置の標高を取得する
        var lonUrl = "&lon=" + mapView.userLocation.coordinate.longitude.description
        var latUrl = "&lat=" + mapView.userLocation.coordinate.latitude.description
        let outtypeUrl = "&outtype=JSON"
        var listUrl = baseUrl + lonUrl + latUrl + outtypeUrl

        // http:は「Info.plis」に「App Transport Security Settings」を設定しないとエラーになる
        guard let url = URL(string: listUrl) else { return }

        // 標高差の計測地点にアノテーションを設定する
        if nil != calcPointAno {
            // 計測地点のアノテーションがあれば再表示のため削除する
            mapView.removeAnnotation(calcPointAno)
        }
        calcPointAno = AplAnnotation(
                CLLocationCoordinate2D(
                        latitude: mapView.userLocation.coordinate.latitude,
                        longitude: mapView.userLocation.coordinate.longitude
                    ),
                glyphText: "計測地点",
                glyphTintColor: .white,
                markerTintColor: .green
            )
        mapView.addAnnotation(calcPointAno)

        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if error != nil {
                print(error!.localizedDescription)
            }
            
            guard let data = data else { return }
            
            let json = try? JSONDecoder().decode(JsonElevation.self, from: data)
            if nil != json {
                // mainスレッドで処理する
                DispatchQueue.main.async {
                    self.currentElevation = (json?.elevation)!
                    self.lblNowElevation.text = "現在位置：" + self.currentElevation.description + " m"
                    self.view.addSubview(self.lblNowElevation)
                    
                    // 指定位置が取得できていれば標高差を表示する
                    if -100000.0 != self.longTapElevation {
                        self.lblDiffElevation.text = "標高差：" + (round(((self.longTapElevation - self.currentElevation)*10))/10).description + " m"
                        self.view.addSubview(self.lblDiffElevation)
                    }
                }
            }
        }.resume()


        // ロングタップ地点の標高を取得する
        lonUrl = "&lon=" + pointAno.coordinate.longitude.description
        latUrl = "&lat=" + pointAno.coordinate.latitude.description

        listUrl = baseUrl + lonUrl + latUrl + outtypeUrl
        
        // http:は「Info.plis」に「App Transport Security Settings」を設定しないとエラーになる
        guard let url2 = URL(string: listUrl) else { return }
        
        URLSession.shared.dataTask(with: url2) { (data, response, error) in
            if error != nil {
                print(error!.localizedDescription)
            }
            
            guard let data = data else { return }
            
            let json = try? JSONDecoder().decode(JsonElevation.self, from: data)
            if nil != json {
                // mainスレッドで処理する
                DispatchQueue.main.async {
                    self.longTapElevation = (json?.elevation)!
                    self.lblLongTapElevation.text = "指定位置：" + self.longTapElevation.description + " m"
                    self.view.addSubview(self.lblLongTapElevation)
                    
                    // 現在位置が取得できていれば標高差を表示する
                    if -100000.0 != self.currentElevation {
                        // 少数第2位で四捨五入する
                        self.lblDiffElevation.text = "標高差：" + (round(((self.longTapElevation - self.currentElevation)*10))/10).description + " m"
                        self.view.addSubview(self.lblDiffElevation)
                    }
                }
            }
        }.resume()
    }
    
    // watchOSに緯度経度を送信
    func sendMessageLonLat() {
        let contents =  ["lon":dlon, "lat":dlat]
        self.session.sendMessage(contents as [String : Any], replyHandler: { (replyMessage) -> Void in
            print ("receive from apple watch");
        }) { (error) -> Void in
            print(error)
        }
    }
    
    // MapViewのdelegate
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        // 現在位置アイコンの場合は処理しない(現在位置アイコンがアノテーションイラストになるため)
        if annotation is MKUserLocation {
            return nil
        }

        
        // MKPointAnnotationの場合の処理
        let pinView = MKMarkerAnnotationView()
        pinView.annotation = annotation
        if let pin = annotation as? MapAnnotationSetting {
            pinView.glyphTintColor = pin.pinColor
            pinView.canShowCallout = true
            return pinView
        }
        
        // AplAnnotationに設定したパラメータで表示する
        // AplAnnotationを使用していない場合はデフォルトの設定でアノテーションを表示する
        let annotationView = mapView.dequeueReusableAnnotationView(withIdentifier:
                MKMapViewDefaultAnnotationViewReuseIdentifier, for: annotation)
        
        guard let markerAnnotationView = annotationView as? MKMarkerAnnotationView,
                let aplAnnotation = annotation as? AplAnnotation else {
            annotationView.tintColor = .red
            return annotationView
        }
        // 今はアノテーションをグルーピングしないためコメントアウトする
//      markerAnnotationView.clusteringIdentifier = aplAnnotation.clusteringIdentifier
        markerAnnotationView.glyphText = aplAnnotation.glyphText
        markerAnnotationView.glyphTintColor = aplAnnotation.glyphTintColor
        markerAnnotationView.markerTintColor = aplAnnotation.markerTintColor
        
        return markerAnnotationView
    }
}

// MKMapViewDelegate
extension ViewController : MKMapViewDelegate {
    // 読み込み開始
    func mapViewWillStartRenderingMap(_ mapView: MKMapView) {
        print("map load start")
    }
    
    // 読み込み終了時
    func mapViewDidFinishLoadingMap(_ mapView: MKMapView) {
        print("map load ended")
    }
}

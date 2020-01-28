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
import GoogleMobileAds

// 国土地理院の標高取得WebAPIのOutputパラメータ
struct JsonElevation : Codable{
    var elevation : Double
    var hsrc : String
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
                        WCSessionDelegate,
                        GADBannerViewDelegate {
    
    // Google AddMod広告
    var bannerView: GADBannerView!
    
    @IBOutlet var mapView: MKMapView!
    @IBOutlet var longPressGesRec: UILongPressGestureRecognizer!
    @IBOutlet var mapViewTypeOver: UIButton!

    // UserDefaults(データバックアップ用)オブジェクト
    var userDataManager:UserDataManager!
    
    var locManager: CLLocationManager!
    var pointAno: MapAnnotationSetting = MapAnnotationSetting()
    var calcPointAno: MapAnnotationSetting = MapAnnotationSetting()
    var mapViewType: UIButton!
    var session: WCSession!
    var dlon:Double! = 0
    var dlat:Double! = 0
    
    // Infomationに表示するラベル
    var lblNowElevation: String = String()
    var lblLongTapElevation: String = String()
    var lblDiffElevation: String = String()
    
    // ロングタップした位置との高低差を取得する変数
    var currentElevation: Double = -100000.0
    var longTapElevation: Double = -100000.0

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // Google AddMod広告
        bannerView = GADBannerView(adSize: kGADAdSizeBanner) //320×50
        addBannerViewToView(bannerView)

        bannerView.adUnitID = "ca-app-pub-3106594758397593/3761431592"
        bannerView.rootViewController = self
        bannerView.load(GADRequest())
        bannerView.delegate = self
        
        // AppDelegateに追加したviewControllerに自身を設定
        let appDelegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.viewController = self
        
        // UserDefaults(データバックアップ用)オブジェクト
        userDataManager = appDelegate.userDataManager
        
        // セッションをアクティブにする
        if (WCSession.isSupported()) {
            self.session = WCSession.default
            self.session.delegate = self
            self.session.activate()
        }

        // MapViewのdelegateを登録する
        mapView.delegate = self
                
        // 位置情報の使用の許可を得る
        let status = CLLocationManager.authorizationStatus()
        if status == CLAuthorizationStatus.restricted || status == CLAuthorizationStatus.denied
        {
            print("authorizationStatus = " + status.rawValue.description)
        }
        else {
            // CLLocationManagerのdelegateを登録する
            locManager = CLLocationManager()
            locManager.distanceFilter = 1
            locManager.delegate = self

            if status == CLAuthorizationStatus.notDetermined
            {
                locManager.requestWhenInUseAuthorization()
            }
            else
            {
                locManager.startUpdatingLocation()
            }
        }
        
        // 地図の初期化
        initMap()
        
        // watchOSにゴルフモードを送信する
        sendMessageMode()
    }
    
    // Google AddMod広告
    func addBannerViewToView(_ bannerView: GADBannerView) {
        bannerView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(bannerView)
        view.addConstraints(
        [NSLayoutConstraint(item: bannerView,
                           attribute: .bottom,
                           relatedBy: .equal,
                           toItem: bottomLayoutGuide,
                           attribute: .top,
                           multiplier: 1,
                           constant: 0),
        NSLayoutConstraint(item: bannerView,
                           attribute: .centerX,
                           relatedBy: .equal,
                           toItem: view,
                           attribute: .centerX,
                           multiplier: 1,
                           constant: 0)
        ])
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus)
    {
        if (status == .restricted) {
            print("機能制限している");
        }
        else if (status == .denied) {
            print("許可していない");
        }
        else if (status == .authorizedWhenInUse) {
            print("このアプリ使用中のみ許可している");
            locManager.startUpdatingLocation();
        }
        else if (status == .authorizedAlways) {
            print("常に許可している");
            locManager.startUpdatingLocation();
        }
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
        default:
            break
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
        print("receiveMessage[iOS]::\(message)")
        replyHandler(["message" : "received message."])

        // String型以外は処理しない
        guard let getType = message["GET"] as? String else {
            return
        }

        switch getType {
        case "LONLAT":
            // watchOSにロングタップしてピンを立てた地点の緯度経度を送信
            sendMessageLonLat()
        case "HEIGHT":
            print("Height")
            // Double型以外は処理しない
            guard let getLon = message["lon"] as? Double else {
                return
            }
            // Double型以外は処理しない
            guard let getLat = message["lat"] as? Double else {
                return
            }
            getWatchOSEElevation(getLon, getLat)
        case "MODE":
            sendMessageMode()
        default:
            print("not exist type.")
        }
    }
    
    public func session(_ session: WCSession, didFinish userInfoTransfer: WCSessionUserInfoTransfer, error: Error?) {
        print("userInfoTransfer::\(userInfoTransfer)")
    }

    // 地図の初期化
    func initMap() {
        // UserDefaultsの初期化
        userDataManager.roadData()

        // 全開のMapTypeをUserDataから取得してMapViewに設定する
        setMapType(userDataManager.getGolfMapType())
        
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
        
        lblLongTapElevation = ""
    }

    // CLLocationManagerのdelegate：現在位置取得
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations:[CLLocation]) {
        let lonStr = (locations.last?.coordinate.longitude.description)!
        let latStr = (locations.last?.coordinate.latitude.description)!
        
        print("lon : " + lonStr)
        print("lat : " + latStr)

        // ロングタップしたアノテーション情報を更新する
        updateLongTapPointAno()
    }
    
    // ロングタップしたアノテーション情報を更新する
    func updateLongTapPointAno() {
        if (true == isExistLongTapPoint()) {
            // 現在位置とタッウプした位置の距離(m)を算出する
            let distance = calcDistance(mapView.userLocation.coordinate, pointAno.coordinate)
            
            // ピンに設定する文字列を生成する
            var str:String = Int(distance).description
            str = str + " m"
            
            // yard
            let yardStr = Int(distance * 1.09361)
            str = str + " / " + yardStr.description + " y" + "\n" + lblLongTapElevation.description
            
            // 高低差
            str = str + "\n" + lblDiffElevation.description
            
            if pointAno.title != str {
                // ピンまでの距離に変化があればtitleを更新する
                pointAno.title = str
                mapView.addAnnotation(pointAno)
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
            lblLongTapElevation = ""
            lblDiffElevation = ""
            mapView.removeAnnotation(calcPointAno)
            mapView.removeAnnotation(pointAno)
            dlon = 0
            dlat = 0
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
            
            // 現在位置とタップした位置の距離(m)を算出する
            let distance = calcDistance(mapView.userLocation.coordinate, center)
            print("distance : " + distance.description)

            // ピンに設定する文字列を生成する
            var str:String = Int(distance).description
            str = str + " m"

            // yard
            let yardStr = Int(distance * 1.09361)
            str = str + " / " + yardStr.description + " y" + "\n" + lblLongTapElevation.description
            
            // ロングタップを検出した位置にピンを立てる
            pointAno.coordinate = center
            pointAno.title = str
            mapView.addAnnotation(pointAno)
            
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
        default:
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
        lblDiffElevation = ""
        mapView.removeAnnotation(calcPointAno)
        mapView.removeAnnotation(pointAno)
        dlon = 0
        dlat = 0
        currentElevation = -100000.0
        longTapElevation = -100000.0
        
        // watchOSに緯度経度を送信
        sendMessageLonLat()
    }
    
    // ロングタップした地点との高低差を表示する
    func showElevation() {
        // 初期値(無効値)を設定
        currentElevation = -100000.0
        longTapElevation = -100000.0

        // 国土地理院のURL
        let baseUrl = "https://cyberjapandata2.gsi.go.jp/general/dem/scripts/getelevation.php?"
        
        // 現在位置の標高を取得する
        var lonUrl = "&lon=" + mapView.userLocation.coordinate.longitude.description
        var latUrl = "&lat=" + mapView.userLocation.coordinate.latitude.description
        let outtypeUrl = "&outtype=JSON"
        var listUrl = baseUrl + lonUrl + latUrl + outtypeUrl

        // http:は「Info.plis」に「App Transport Security Settings」を設定しないとエラーになる
        guard let url = URL(string: listUrl) else { return }

        // 計測地点のアノテーションがあれば再表示のため削除する
        lblDiffElevation = ""
        mapView.removeAnnotation(calcPointAno)

        // 高低差の計測地点にアノテーションを設定する
        calcPointAno.coordinate = mapView.userLocation.coordinate
        calcPointAno.setPinColor(.green)
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
                    self.lblNowElevation = "計測位置：" + self.currentElevation.description + " m"
                    
                    // 指定位置が取得できていれば高低差を表示する
                    if -100000.0 != self.longTapElevation {
                        self.lblDiffElevation = "高低差：" + (round(((self.longTapElevation - self.currentElevation)*10))/10).description + " m"
                    }
                    self.setCalcPointAnoTitle()
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
                    self.lblLongTapElevation = "標高：" + self.longTapElevation.description + " m"
                    
                    // 現在位置が取得できていれば高低差を表示する
                    if -100000.0 != self.currentElevation {
                        // 少数第2位で四捨五入する
                        self.lblDiffElevation = "高低差：" + (round(((self.longTapElevation - self.currentElevation)*10))/10).description + " m"
                    }
                    self.setCalcPointAnoTitle()
                }
            }
        }.resume()
    }

    // watchOSからの高低差取得要求を処理する
    func getWatchOSEElevation(_ lon:Double, _ lat:Double) {
        // 国土地理院のURL
        let baseUrl = "https://cyberjapandata2.gsi.go.jp/general/dem/scripts/getelevation.php?"
        
        // 現在位置の標高を取得する
        let lonUrl = "&lon=" + lon.description
        let latUrl = "&lat=" + lat.description
        let outtypeUrl = "&outtype=JSON"
        let listUrl = baseUrl + lonUrl + latUrl + outtypeUrl
        
        // http:は「Info.plis」に「App Transport Security Settings」を設定しないとエラーになる
        guard let url = URL(string: listUrl) else { return }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if error != nil {
                print(error!.localizedDescription)
            }
            
            guard let data = data else { return }
            
            let json = try? JSONDecoder().decode(JsonElevation.self, from: data)
            if nil != json {
                // mainスレッドで処理する
                DispatchQueue.main.async {
                    let elevation = (json?.elevation)!
                    // 指定位置が取得できていれば高低差を表示する
                    if -100000.0 != self.longTapElevation {
                        let sendMsg = "高低差：" + (round(((self.longTapElevation - elevation)*10))/10).description + " m"
                        
                        //watchOSにメッセージ送信する
                        let contents =  ["RESP":"HEIGHT", "STR":sendMsg] as [String : Any]
                        self.session.sendMessage(contents, replyHandler: { (replyMessage) -> Void in
                            print ("receive from apple watch");
                        }) { (error) -> Void in
                            print(error)
                        }
                        
                    }
                }
            }
        }.resume()
    }
    
    // watchOSに緯度経度を送信
    func sendMessageLonLat() {
        let contents =  ["RESP":"LONLAT", "lon":dlon, "lat":dlat] as [String : Any]
        self.session.sendMessage(contents, replyHandler: { (replyMessage) -> Void in
            print ("receive from apple watch");
        }) { (error) -> Void in
            print(error)
        }
    }
    
    // watchOSにモードを送信する
    func sendMessageMode() {
        let contents =  ["RESP":"MODE", "title":"ゴルフモード"] as [String : Any]
        self.session.sendMessage(contents, replyHandler: { (replyMessage) -> Void in
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
            pinView.canShowCallout = true
            pinView.markerTintColor = pin.pinColor
        }

        return pinView
    }
    
    // 高低差の計測情報をアノテーションのタイトルに設定する
    func setCalcPointAnoTitle() {
        calcPointAno.title = "\r \n \r \n" + lblNowElevation.description + "\n" + lblDiffElevation.description
        mapView.addAnnotation(calcPointAno)
        
        // ロングタップしたアノテーション情報を更新する
        updateLongTapPointAno()
    }
    
    // CycleViewに遷移する
    func toCycleView() {
        // CycleViewControllerを表示する
        self.performSegue(withIdentifier: "toCycleView", sender: nil)
    }
    
    // WalkViewに遷移する
    func toWalkView() {
        // WalkViewControllerを表示する
        self.performSegue(withIdentifier: "toWalkView", sender: nil)
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

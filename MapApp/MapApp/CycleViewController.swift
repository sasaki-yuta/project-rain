//
//  CycleViewController.swift
//  MapApp
//
//  Created by yuta sasaki on 2019/07/21.
//  Copyright © 2019 rain-00-00-09. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation
import WatchConnectivity
import FloatingPanel
import GoogleMobileAds


// MKPointAnnotation拡張用クラス
class MapAnnotationCycle: MKPointAnnotation {
    var pinColor: UIColor = .red
    
    func setPinColor(_ color: UIColor) {
        pinColor = color
    }
}

class CycleViewController:  UIViewController,
                            CLLocationManagerDelegate,
                            WCSessionDelegate,
                            UIGestureRecognizerDelegate,
                            UISearchBarDelegate,
                            GADBannerViewDelegate {
    
    // Google AddMod広告
    var bannerView: GADBannerView!
    
    @IBOutlet var mapView: MKMapView!
    @IBOutlet var mapViewTypeOver: UIButton!
    @IBOutlet var longPressGesRec: UILongPressGestureRecognizer!
    
    var locManager: CLLocationManager!
    var mapViewType: UIButton!
    var isStarting: Bool! = false
    var session: WCSession!
    
    // Popup画面
    var floatingPanelController: FloatingPanelController!
    var isShowPopup: Bool = false
    
    // UserDefaults(データバックアップ用)オブジェクト
    var userDataManager:UserDataManager!
    
    // キーボード
    @IBOutlet var searchBar: UISearchBar!
    @IBOutlet var CancelBtn: UIButton!
    var annotationList = [MapAnnotationCycle]()
    
    // 速度
    @IBOutlet var speed: UILabel!
    @IBOutlet var lblSpeed: UILabel!
    // 平均速度
    var avgSumSpeed: Double! = 0.0
    var avgSumCount: Int! = 0
    @IBOutlet var avgSpeed: UILabel!
    @IBOutlet var lblAvgSpeed: UILabel!
    // MAX速度
    var dMaxSpeed: Double! = 0.0
    @IBOutlet var maxSpeed: UILabel!
    @IBOutlet var lblMaxSpeed: UILabel!
    // 速度表示切り替えボタン
    @IBOutlet var speedDispChange: UIButton!
    
    // 走行時間
    var beforSinRef: Double! = 0.0
    var dDrivingTime: Double! = 0.0
    @IBOutlet var drivingTime: UILabel!
    @IBOutlet var lblDrivingTime: UILabel!

    // 走行距離
    var beforLon: Double! = 0.0
    var beforLat: Double! = 0.0
    var dDrivingDist: Double! = 0.0
    @IBOutlet var drivingDist: UILabel!
    @IBOutlet var lblDrivingDist: UILabel!

    // 累計MAX速度
    var dTotalMaxSpeed: Double! = 0.0
    // 累計走行距離
    var dTotalDrivingDist: Double! = 0.0
    // 累計走行時間
    var dTotalDrivingTime: Double! = 0.0

    // bar
    @IBOutlet var lbar1: UILabel!
    @IBOutlet var lbar2: UILabel!
    @IBOutlet var lbar3: UILabel!
    @IBOutlet var lbar4: UILabel!
    
    // GPS誤差補正
    var timeInterval: Int = 0
    var accuracy: Int = 0
    
    // アノテーション
    var pointAno: MapAnnotationCycle = MapAnnotationCycle()         // ロングタップした地点
    var destinationAno: MapAnnotationCycle = MapAnnotationCycle()   // 目的地
    
    // タップした地点の情報
    var tapPointTitle: String! = ""                 // タップした地点のタイトル
    var tapStreetAddr: String! = ""                 // 住所
    var tapDistance: CLLocationDistance! = 0        // 距離
    var tapRoutePoint: CLLocationCoordinate2D!      // ルート探索用のタッチポイント
    
    // 表示したルート
    var routePolyLine: MKPolyline!
        
    // 計測画面表示切り替えボタン
    @IBOutlet var btnCalcSwitchDisp: UIButton!
    var isShowCalcDisp: Bool = true

    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        // Google AddMod広告
        bannerView = GADBannerView(adSize: kGADAdSizeBanner) //320×50
        addBannerViewToView(bannerView)

        bannerView.adUnitID = "ca-app-pub-3106594758397593/3761431592"
        bannerView.rootViewController = self
        bannerView.load(GADRequest())
        bannerView.delegate = self
        
        // AppDelegateに追加したCycleViewControllerに自身を設定
        let appDelegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.cycleViewController = self

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
    
        // CLLocationManagerのdelegateを登録する
        locManager = CLLocationManager()
        locManager.allowsBackgroundLocationUpdates = false
        locManager.pausesLocationUpdatesAutomatically = false
        locManager.distanceFilter = 3
        locManager.delegate = self
        
        // 位置情報の使用の許可を得る
        let status = CLLocationManager.authorizationStatus()
        if status == CLAuthorizationStatus.restricted || status == CLAuthorizationStatus.denied
        {
            print("authorizationStatus = " + status.rawValue.description)
        }
        else {
            if status == CLAuthorizationStatus.notDetermined
            {
                locManager.requestWhenInUseAuthorization()
            }
            else
            {
                locManager.startUpdatingLocation()
            }
        }
        
        // KeyBordのdelegateを登録する
        searchBar.delegate = self
        
        // KeyBordの表示、非表示を受け取る設定
        let notification = NotificationCenter.default
        notification.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        notification.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)

        // モーダルビュー
        floatingPanelController = FloatingPanelController()
        floatingPanelController.delegate = self
        
        // 地図の初期化
        initMap()
        
        // WatchOSにモードを通知する
        sendMessageMode()
    }
    
    // Google AddMod広告
    func addBannerViewToView(_ bannerView: GADBannerView) {
        bannerView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(bannerView)
        view.addConstraints([
        NSLayoutConstraint(item: bannerView,
                           attribute: .bottom,
                           relatedBy: .equal,
                           toItem: bottomLayoutGuide,
                           attribute: .bottomMargin,
                           multiplier: 1,
                           constant: -85),
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
    
    // 地図の初期化
    func initMap() {
        // UserDefaultsの初期化
        userDataManager.roadData()
        dTotalMaxSpeed = userDataManager.getTotalMaxSpeed()
        dTotalDrivingDist = userDataManager.getTotalDrivingDist()
        dTotalDrivingTime = userDataManager.getTotalDrivingTime()
        
        // 計測中断、終了したデータをViewを切り替えても表示できる様にLoradする
        loadCulcData()
        
        // 前回のMapTypeをUserDataから取得してMapViewに設定する
        setMapType(userDataManager.getCycleMapType())
        
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
        mapView.frame.size = CGSize(width: width, height: (height/3)*2-25-50) // 高さ2/3を地図にして計測画面の25、検索Barの50をマイナスする

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
        
        // Menu表示ボタン
        mapViewTypeOver.frame = CGRect(x:width - 50, y:58, width:40, height:40)
        self.view.addSubview(mapViewTypeOver)
        
        // トラッキングボタン表示
        let trakingBtn = MKUserTrackingButton(mapView: mapView)
        trakingBtn.layer.backgroundColor = UIColor(white: 1, alpha: 0.8).cgColor
        trakingBtn.frame = CGRect(x:width - 50, y:100, width:40, height:40)
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

        // 各種情報表示位置の係数
        let infoTopPos = (height/3)*2
        let labelHeight = ((height/3)*1)/2/2 // 画面の1/3を情報表示エリアにする
        
        // 検索フィールドの位置
        searchBar.frame = CGRect(x: 0, y: infoTopPos-50, width: width, height: 50)
        self.view.addSubview(searchBar)
        CancelBtn.frame = CGRect(x: width-80, y: infoTopPos-50, width: 80, height: 50)
        CancelBtn.isHidden = true
        self.view.addSubview(CancelBtn)
        
        // 計測画面表示切り替えボタンを検索フィールドの上に表示する
        btnCalcSwitchDisp.setTitle("計測画面", for: .normal)
        btnCalcSwitchDisp.frame = CGRect(x: 0, y: infoTopPos-75, width: width, height: 25)
        self.view.addSubview(btnCalcSwitchDisp)
        
        // 速度
        lblSpeed.frame = CGRect(x: width/2, y: infoTopPos, width: width/2, height: labelHeight/2)
        self.view.addSubview(lblSpeed)
        speed.frame = CGRect(x: width/2, y: infoTopPos+(labelHeight*1)-(labelHeight/2), width: width/2, height: labelHeight+(labelHeight/3)) // /2ではなく、/3で高さの表示位置を微調整した
        speed.text = "-"
        self.view.addSubview(speed)
        
        // MAX速度
        lblMaxSpeed.frame = CGRect(x: width/2, y: infoTopPos, width: width/2, height: labelHeight/2)
        lblMaxSpeed.isHidden = true
        self.view.addSubview(lblMaxSpeed)
        maxSpeed.frame = CGRect(x: width/2, y: infoTopPos+(labelHeight*1)-(labelHeight/2), width: width/2, height: labelHeight+(labelHeight/3)) // /2ではなく、/3で高さの表示位置を微調整した
        if 0.0 != dMaxSpeed {
            maxSpeed.text = dMaxSpeed.description
        }
        else {
            maxSpeed.text = "-"
        }
        maxSpeed.isHidden = true
        self.view.addSubview(maxSpeed)

        // 平均速度
        lblAvgSpeed.frame = CGRect(x: width/2, y: infoTopPos, width: width/2, height: labelHeight/2)
        lblAvgSpeed.isHidden = true
        self.view.addSubview(lblAvgSpeed)
        avgSpeed.frame = CGRect(x: width/2, y: infoTopPos+(labelHeight*1)-(labelHeight/2), width: width/2, height: labelHeight+(labelHeight/3)) // /2ではなく、/3で高さの表示位置を微調整した
        if (0.0 != avgSumSpeed) && (0 != avgSumCount) {
            let tmpAvgSpeed = floor(((avgSumSpeed / Double(avgSumCount)) * 3.6)*100)/100
            avgSpeed.text = tmpAvgSpeed.description
        }
        else {
            avgSpeed.text = "-"
        }
        avgSpeed.isHidden = true
        self.view.addSubview(avgSpeed)

        // 速度表示切り替えボタン
        speedDispChange.frame = CGRect(x: width/2, y: infoTopPos, width: width/2, height: labelHeight*2)
        self.view.addSubview(speedDispChange)

        // 走行距離
        lblDrivingDist.frame = CGRect(x: 0, y: infoTopPos, width: width/2, height: labelHeight/2)
        self.view.addSubview(lblDrivingDist)
        drivingDist.frame = CGRect(x: 0, y: infoTopPos+(labelHeight*1)-(labelHeight/2), width: width/2, height: labelHeight+(labelHeight/3)) // /2ではなく、/3で高さの表示位置を微調整した
        if 0.0 != dDrivingDist {
            let tmpDist = floor((dDrivingDist / 1000) * 100) / 100
            drivingDist.text = tmpDist.description
        }
        else {
            drivingDist.text = "-"
        }
        self.view.addSubview(drivingDist)
        
        // 走行時間
        lblDrivingTime.frame = CGRect(x: 0, y: infoTopPos+(labelHeight*2), width: width, height: labelHeight/2+5)
        self.view.addSubview(lblDrivingTime)
        drivingTime.frame = CGRect(x: 0, y: infoTopPos+(labelHeight*3)-(labelHeight/2), width: width, height: labelHeight/*+(labelHeight/2)*/)
        if 0.0 != dDrivingTime {
            let hour = Int(dDrivingTime) / 3600
            let min = (Int(dDrivingTime) - (hour * 3600)) / 60
            let sec = Int(dDrivingTime) - ((hour * 3600) + (min * 60))
            drivingTime.text = String(format: "%02d", hour) + ":" +  String(format: "%02d", min) + ":" +  String(format: "%02d", sec)
        }
        else {
            drivingTime.text = "-"
        }
        self.view.addSubview(drivingTime)

        
        // bar1
        lbar1.frame = CGRect(x: 0, y: infoTopPos, width: width, height: 1)
        self.view.addSubview(lbar1)
        
        // bar2
        lbar2.frame = CGRect(x: 0, y: infoTopPos+(labelHeight*2), width: width, height: 1)
        self.view.addSubview(lbar2)
        
        // bar3
        lbar3.frame = CGRect(x: 0, y: infoTopPos-50, width: width, height: 1)
        self.view.addSubview(lbar3)
        
        // bar4
        lbar4.frame = CGRect(x: width/2, y: infoTopPos, width: 1, height: labelHeight*2)
        self.view.addSubview(lbar4)

        // GPS誤差補正
        let appDelegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate
        timeInterval = appDelegate.userDataManager.getTimeInterval()
        accuracy = appDelegate.userDataManager.getAccuracy()
        
        // 地図Typeに合わせて情報の色を変更する
        changeMapType()
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    // CLLocationManagerのdelegate：現在位置取得
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations:[CLLocation]) {
        // Popup画面に表示する距離を更新
        if isShowPopup {
            self.tapDistance = calcDistance(mapView.userLocation.coordinate, tapRoutePoint)
            let strDist = self.getTapDistance()

            let appDelegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate
            appDelegate.pointPopupViewController.setDistance(strDist)
        }

        // 計測開始していなければreturnする
        if (false == isStarting) {
            return
        }
                
        // 秒速を少数第2位の時速に変換
        let speed: Double = floor((locations.last!.speed * 3.6)*100)/100
        print("speed = " + speed.description)
        print("timeIntervalSinceNow = " + abs(locations.last!.timestamp.timeIntervalSinceNow).description)
        print("horizontalAccuracy = " + locations.last!.horizontalAccuracy.description)

        // 精度の悪い位置情報を捨てる
        var isBreak:Bool = false
        if timeInterval <= Int(abs(locations.last!.timestamp.timeIntervalSinceNow)) {
            // GPS時間鮮度が設定値オーバー
            isBreak = true
        }
        if 0 > locations.last!.horizontalAccuracy {
            // GPS取得の諸条件のどれかが致命的に悪い場合
            isBreak = true
        }
        if accuracy < Int(locations.last!.horizontalAccuracy) {
            // 水平誤差が設定値オーバー
            isBreak = true
        }
        
        if (isBreak) {
            // GPSが精度が許容範囲外なら表示速度を0、前回の計測位置を初期化する
            self.speed.text = "0.0"
            self.beforLon = 0
            self.beforLat = 0
            // 走行距離、速度を計測しない場合は時間も計上しない
            self.beforSinRef = 0
            return
        }
        
        // 停止中ではない場合
        if (0.0 < speed) {
            //=============================================================
            // 速度
            //=============================================================
            // 現在の速度の更新
            self.speed.text = speed.description

            // 平均速度の更新
            self.avgSumSpeed += locations.last!.speed
            self.avgSumCount += 1
            let tmpAvgSpeed = floor(((self.avgSumSpeed / Double(self.avgSumCount)) * 3.6)*100)/100
            self.avgSpeed.text = tmpAvgSpeed.description
            
            // 今回のCycleでの最高速度
            if speed > dMaxSpeed {
                dMaxSpeed = speed
                maxSpeed.text = dMaxSpeed.description
            }
            
            // 累計最高速度
            if speed > dTotalMaxSpeed {
                dTotalMaxSpeed = speed
                // UserDefaultsにバックアップする
                userDataManager.setTotalMaxSpeed(dTotalMaxSpeed)
            }
            
            //=============================================================
            // 走行時間
            //=============================================================
            // 速度を検出している間の走行時間の更新
            if (0 < self.beforSinRef) { // 走行時間の前回値がある場合(初回でない場合)
                // 現在の走行時間の更新
                let dTime = locations.last!.timestamp.timeIntervalSinceReferenceDate - self.beforSinRef
                self.dDrivingTime += dTime
                let hour = Int(self.dDrivingTime) / 3600
                let min = (Int(self.dDrivingTime) - (hour * 3600)) / 60
                let sec = Int(self.dDrivingTime) - ((hour * 3600) + (min * 60))
                self.drivingTime.text = String(format: "%02d", hour) + ":" +  String(format: "%02d", min) + ":" +  String(format: "%02d", sec)
                
                // 累計の走行時間の更新
                self.dTotalDrivingTime += dTime
                // UserDefaultsにバックアップする
                userDataManager.setTotalDrivingTime(dTotalDrivingTime)
                
                // 前回値を保存
                self.beforSinRef = locations.last!.timestamp.timeIntervalSinceReferenceDate
            }
            else {
                // 前回値がない(初回)場合、前回値だけ保持して、次回時間を計測する
                self.beforSinRef = locations.last!.timestamp.timeIntervalSinceReferenceDate
            }

            //=============================================================
            // 走行距離
            //=============================================================
            if (0.0 != self.beforLon && 0.0 != self.beforLat) {
                // 走行距離の更新
                let aLoc: CLLocation = CLLocation(latitude: self.beforLat, longitude: self.beforLon)
                let dlon: Double! = locations.last?.coordinate.longitude
                let dlat: Double! = locations.last?.coordinate.latitude
                let bLoc: CLLocation = CLLocation(latitude: dlat, longitude: dlon)
                let dist = bLoc.distance(from: aLoc)
                self.dDrivingDist += dist
                let tmpDist = floor((self.dDrivingDist / 1000) * 100) / 100
                self.drivingDist.text = tmpDist.description

                // 累計走行距離の更新
                self.dTotalDrivingDist += dist
                // UserDefaultsにバックアップする
                userDataManager.setTotalDrivingDist(dTotalDrivingDist)
                
                // 前回と今回の位置に線を引く
                let coordinate_1 = CLLocationCoordinate2D(latitude: self.beforLat, longitude: self.beforLon)
                let coordinate_2 = CLLocationCoordinate2D(latitude: dlat, longitude: dlon)
                var coordinates = [coordinate_1, coordinate_2]
                let myPolyLine: MKPolyline = MKPolyline(coordinates: &coordinates, count: coordinates.count)
                myPolyLine.subtitle = "run"
                self.mapView.addOverlay(myPolyLine)
                
                // 前回値を保存
                self.beforLon = locations.last?.coordinate.longitude
                self.beforLat = locations.last?.coordinate.latitude
            }
            else {
                // 前回値がない(初回)場合、前回値だけ保持して、次回時間を計測する
                self.beforLon = locations.last?.coordinate.longitude
                self.beforLat = locations.last?.coordinate.latitude
            }
        }
        // 停止中の場合は計測をSKIPするため、前回値を今回値にする
        else {
            // 速度表示の更新
            self.speed.text = "0.0"
            // 前回値として2001年1月1日の00:00:00 UTCと現在の日時の間の秒間隔:ex 587280439.457562)を保持
            self.beforSinRef = locations.last!.timestamp.timeIntervalSinceReferenceDate
            // 緯度経度を更新
            self.beforLon = locations.last?.coordinate.longitude
            self.beforLat = locations.last?.coordinate.latitude
        }
    }

    // 地図の表示タイプを切り替える
    func setMapType(_ mapType: MKMapType) {
        mapView.mapType = mapType
        
        // ステータスバーのスタイル変更を促す
        self.setNeedsStatusBarAppearanceUpdate();
    }
    
    // ViewControllerに遷移する
    func toGolfView() {
        // ViewControllerを表示する
        self.performSegue(withIdentifier: "toGolfView", sender: nil)
    }
    
    // WalkViewに遷移する
    func toWalkView() {
        // WalkViewControllerを表示する
        self.performSegue(withIdentifier: "toWalkViewFromCycle", sender: nil)
    }

    // CycleSettingViewControllerに遷移する
    func toCycleSettingViewController() {
        // CycleSettingViewControllerを表示する
        self.performSegue(withIdentifier: "toCycleSetting", sender: nil)
    }

    // 累計データを消去する
    func deleteData() {
        self.userDataManager.deleteCycleData()
        dTotalMaxSpeed = 0.0
        dTotalDrivingDist = 0.0
        dTotalDrivingTime = 0.0
    }
    
    // 計測を開始する
    func cycleStart() {
        // 計測中にだけバックグラウンドでの位置情報更新を許可する
        locManager.allowsBackgroundLocationUpdates = true
        
        // 平均速度
        self.avgSumSpeed = 0.0
        self.avgSumCount = 0
        // 走行距離
        self.beforLon = 0.0
        self.beforLat = 0.0
        self.dDrivingDist = 0.0
        // 走行時間
        self.beforSinRef = 0.0
        self.dDrivingTime = 0.0
        // MAX速度
        self.dMaxSpeed = 0.0

        // 速度
        speed.text = "0.0"
        // 平均速度
        avgSpeed.text = "0.0"
        // 走行距離
        drivingDist.text = "0.0"
        // 走行時間
        drivingTime.text = "00:00:00"
        // MAX速度
        maxSpeed.text = "0.0"

        self.isStarting = true
        
        // オーバーレイを全て削除する
        mapView.removeOverlays(mapView.overlays)
        // ルートがあれば再描画する
        if nil != self.routePolyLine {
            self.mapView.addOverlay(self.routePolyLine)
        }
        
        // パーツを表示する
        showRunningParts()

        // AppleWatchからモード情報を再取得してもらうためモード情報を送信
        sendMessageMode()
    }
    
    // 計測を再開する
    func cycleReStart() {
        // 計測中にだけバックグラウンドでの位置情報更新を許可する
        locManager.allowsBackgroundLocationUpdates = true
        
        self.isStarting = true
        
        // パーツを表示する
        showRunningParts()
        
        // AppleWatchからモード情報を再取得してもらうためモード情報を送信
        sendMessageMode()
    }
    
    // 計測を中断する
    func cycleStop() {
        // 計測中にだけバックグラウンドでの位置情報更新を許可する
        locManager.allowsBackgroundLocationUpdates = false
        
        // 再開した時に/終了した地点からの距離と時間を計測してしまうため初期化する
        beforLon = 0.0
        beforLat = 0.0
        beforSinRef = 0.0
        
        // 計測中状態を更新
        self.isStarting = false
        
        // 累計データを保存する
        userDataManager.saveCycleData()
        // 中断、終了したデータを保存する
        saveCulcData()

        // AppleWatchからモード情報を再取得してもらうためモード情報を送信
        sendMessageMode()
    }

    // 計測を終了する
    func cycleEnd() {
        // 計測中にだけバックグラウンドでの位置情報更新を許可する
        locManager.allowsBackgroundLocationUpdates = false

        // 再開した時に/終了した地点からの距離と時間を計測してしまうため初期化する
        beforLon = 0.0
        beforLat = 0.0
        beforSinRef = 0.0

        // 計測中状態を更新
        self.isStarting = false
        
        // 累計データを保存する
        userDataManager.saveCycleData()
        // 中断、終了したデータを保存する
        saveCulcData()
        
        // AppleWatchからモード情報を再取得してもらうためモード情報を送信
        sendMessageMode()
    }
    
    // 計測中断、終了したデータをViewを切り替えても表示できる様に保存する
    func saveCulcData() {
        let appDelegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.userDataManager.setAvgSumSpeed(avgSumSpeed, avgSumCount)
        appDelegate.userDataManager.setDrivingDist(dDrivingDist)
        appDelegate.userDataManager.setDrivingTime(dDrivingTime)
        appDelegate.userDataManager.setMaxSpeed(dMaxSpeed)
        // 走行履歴を保存する
        saveMapOverlays()
    }

    // 計測中断、終了したデータをViewを切り替えても表示できる様にLoradする
    func loadCulcData() {
        let appDelegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate
        avgSumSpeed = appDelegate.userDataManager.getAvgSumSpeed()
        avgSumCount = appDelegate.userDataManager.getAvgSumCount()
        dDrivingDist = appDelegate.userDataManager.getDrivingDist()
        dDrivingTime = appDelegate.userDataManager.getDrivingTime()
        dMaxSpeed = appDelegate.userDataManager.getMaxSpeed()
        // 走行履歴をロードする
        loadMapOverlays()
    }
    
    // メニューで地図Typeを変えた場合
    func changeMapType() {
        var isBlack:Bool = false

        switch mapView.mapType {
        case .standard:         // 標準の地図
            break
        case .mutedStandard:    // 地図よりもデータを強調
            break
        case .satellite:        // 航空写真
            isBlack = true
            break
        case .hybrid:           // 標準の地図＋航空写真
            isBlack = true
            break
        default:
            break
        }
        
        // サイクルデータの色を地図に合わせて変更する
        if false == isBlack {
            speed.backgroundColor = .white
            speed.textColor = .black
            lblSpeed.backgroundColor = .white
            lblSpeed.textColor = .black
            avgSpeed.backgroundColor = .white
            avgSpeed.textColor = .black
            lblAvgSpeed.backgroundColor = .white
            lblAvgSpeed.textColor = .black
            maxSpeed.backgroundColor = .white
            maxSpeed.textColor = .black
            lblMaxSpeed.backgroundColor = .white
            lblMaxSpeed.textColor = .black
            drivingTime.backgroundColor = .white
            drivingTime.textColor = .black
            lblDrivingTime.backgroundColor = .white
            lblDrivingTime.textColor = .black
            drivingDist.backgroundColor = .white
            drivingDist.textColor = .black
            lblDrivingDist.backgroundColor = .white
            lblDrivingDist.textColor = .black
            view.backgroundColor = .white
        }
        else {
            speed.backgroundColor = .black
            speed.textColor = .white
            lblSpeed.backgroundColor = .black
            lblSpeed.textColor = .white
            avgSpeed.backgroundColor = .black
            avgSpeed.textColor = .white
            lblAvgSpeed.backgroundColor = .black
            lblAvgSpeed.textColor = .white
            maxSpeed.backgroundColor = .black
            maxSpeed.textColor = .white
            lblMaxSpeed.backgroundColor = .black
            lblMaxSpeed.textColor = .white
            drivingTime.backgroundColor = .black
            drivingTime.textColor = .white
            lblDrivingTime.backgroundColor = .black
            lblDrivingTime.textColor = .white
            drivingDist.backgroundColor = .black
            drivingDist.textColor = .white
            lblDrivingDist.backgroundColor = .black
            lblDrivingDist.textColor = .white
            view.backgroundColor = .black
        }
    }
    
    // Speed表示切り替えを押下した時の処理
    @IBAction func btnSpeedChangeThouchDown(_ sender: Any) {
        if (false == speed.isHidden) {
            // 速度を消して平均速度を表示する
            speed.isHidden = true
            lblSpeed.isHidden = true
            avgSpeed.isHidden = false
            lblAvgSpeed.isHidden = false
        }
        else if (false == avgSpeed.isHidden) {
            // 平均速度を消して最高速度を表示する
            avgSpeed.isHidden = true
            lblAvgSpeed.isHidden = true
            maxSpeed.isHidden = false
            lblMaxSpeed.isHidden = false
        }
        else {
            //最高速度を消して速度を表示する
            maxSpeed.isHidden = true
            lblMaxSpeed.isHidden = true
            speed.isHidden = false
            lblSpeed.isHidden = false
        }
    }
    
    // 計測画面表示切り替えを押下した時の処理
    @IBAction func btnCalcChangeThouchDown(_ sender: Any) {
        if isShowCalcDisp {
            hideRunningParts()
        }
        else {
            showRunningParts()
        }
    }
    
    // ランニングパーツを表示する
    func showRunningParts() {
        isShowCalcDisp = true
        
        // デバイスの画面サイズを取得する
        let dispSize: CGSize = UIScreen.main.bounds.size
        let width = Int(dispSize.width)
        let height = Int(dispSize.height)

        // 地図、計測画面表示切り替えボタン、検索フィールドの表示エリアを移動する
        mapView.frame.size = CGSize(width: width, height: (height/3)*2-25-50) // 計測画面25、検索Barの50をマイナス
        btnCalcSwitchDisp.frame = CGRect(x: 0, y: (height/3)*2-75, width: width, height: 25)
        let infoTopPos = (height/3)*2
        lbar1.frame = CGRect(x: 0, y: infoTopPos, width: width, height: 1)
        lbar3.frame = CGRect(x: 0, y: (height/3)*2-50, width: width, height: 1)
        searchBar.frame = CGRect(x: 0, y: (height/3)*2-50, width: width, height: 50)
        CancelBtn.frame = CGRect(x: width-80, y: infoTopPos-50, width: 80, height: 50)

        // パーツを表示する
        lblSpeed.isHidden = false
        speed.isHidden = false
        lblMaxSpeed.isHidden = true
        maxSpeed.isHidden = true
        lblAvgSpeed.isHidden = true
        avgSpeed.isHidden = true
        speedDispChange.isHidden = false
        lblDrivingDist.isHidden = false
        drivingDist.isHidden = false
        lblDrivingTime.isHidden = false
        drivingTime.isHidden = false
        lbar2.isHidden = false
        lbar4.isHidden = false
    }
    
    // ランニングパーツを非表示にする
    func hideRunningParts() {
        isShowCalcDisp = false
        
        // パーツを非表示にする
        lblSpeed.isHidden = true
        speed.isHidden = true
        lblMaxSpeed.isHidden = true
        maxSpeed.isHidden = true
        lblAvgSpeed.isHidden = true
        avgSpeed.isHidden = true
        speedDispChange.isHidden = true
        lblDrivingDist.isHidden = true
        drivingDist.isHidden = true
        lblDrivingTime.isHidden = true
        drivingTime.isHidden = true
        lbar2.isHidden = true
        lbar4.isHidden = true
        
        // デバイスの画面サイズを取得する
        let dispSize: CGSize = UIScreen.main.bounds.size
        let width = Int(dispSize.width)
        let height = Int(dispSize.height)
        
        // 地図と検索フィールドの位置を戻す
        CancelBtn.frame = CGRect(x: width-80, y: height-50, width: 80, height: 50)
        searchBar.frame = CGRect(x: 0, y: height-50, width: width, height: 50)
        lbar3.frame = CGRect(x: 0, y: height-50, width: width, height: 1)
        lbar1.frame = CGRect(x: 0, y: height-1, width: width, height: 1)
        btnCalcSwitchDisp.frame = CGRect(x: 0, y: height-75, width: width, height: 25)
        mapView.frame.size = CGSize(width: width, height: height-25-50) // 検索Barのheight50分マイナス
    }
    
    // 走行履歴を保存する
    func saveMapOverlays() {
        // 画面表示時にルートも復帰されるため、setOverlaysにルートを保存しない様に一時的に削除する
        if nil != self.routePolyLine {
            self.mapView.removeOverlay(self.routePolyLine)
            self.routePolyLine = nil
        }
        
        // 走行履歴を保存する
        let appDelegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.userDataManager.setOverlays(self.mapView.overlays)
        
        // ルートを復活する
        if nil != self.routePolyLine {
            self.mapView.addOverlay(self.routePolyLine)
        }
    }
    
    // 走行履歴をロードする
    func loadMapOverlays() {
        let appDelegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate
        let overlays = appDelegate.userDataManager.getOverlays()
        let count = overlays.count
        if 0 != count {
            mapView.addOverlays(overlays)
        }
    }
    
    // 地点の有無を確認する
    func isExistPoint() -> Bool {
        var retVal: Bool = false
        if (0 != pointAno.coordinate.latitude) && (0 != pointAno.coordinate.longitude) {
            retVal = true
        }
        if 0 < annotationList.count {
            retVal = true
        }
        if (0 != destinationAno.coordinate.latitude) && (0 != destinationAno.coordinate.longitude) {
            retVal = true
        }
        return retVal
    }
    
    // 地点を削除する
    func deletePoint() {
        // 地点画面を消去する
        ExitPointPopupView()

        // 地図上のオーバーレイを削除
        if nil != routePolyLine {
            mapView.removeOverlay(self.routePolyLine)
            routePolyLine = nil
        }
        
        // ロングタップ地点を削除
        mapView.removeAnnotation(pointAno)
        pointAno.coordinate.longitude = 0
        pointAno.coordinate.latitude = 0
        
        // 目的地を削除
        mapView.removeAnnotation(destinationAno)
        destinationAno.coordinate.longitude = 0
        destinationAno.coordinate.latitude = 0
        
        // 検索地点を削除
        if 0 < annotationList.count {
            mapView.removeAnnotations(annotationList)
            annotationList.removeAll()
        }
    }
    
    // PopUp画面表示
    func showPointPopupView() {
        isShowPopup = true
        // セミモーダルビューを表示する
        floatingPanelController.surfaceView.cornerRadius = 24.0 // かどを丸くする
        let viewCnt = PointPopupViewController()
        floatingPanelController.set(contentViewController: viewCnt)
        // セミモーダルビューを表示する
        floatingPanelController.addPanel(toParent: self, belowView: nil, animated: true)
        floatingPanelController.move(to: .half, animated: true)
    }

    // PopUp画面の消去
    func ExitPointPopupView() {
        isShowPopup = false
        // セミモーダルビューを非表示にする
        floatingPanelController.removePanelFromParent(animated: true)
    }

    
    //==================================================================
    // テキストフィールド
    //==================================================================
    // テキストフィールドをタップ後、入力状態になる前
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        return true
    }

    //検索ボタン押下時の呼び出しメソッド
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        // キーボードを戻す
        searchBar.resignFirstResponder()

        // 地点画面を消去する
        ExitPointPopupView()
        
        if 0 < annotationList.count {
            // 前回検索したアノテーションを削除する
            mapView.removeAnnotations(annotationList)
            annotationList.removeAll()
        }

        if "" == searchBar.text {
            return
        }

        //検索条件を作成する。
        let request = MKLocalSearch.Request()
        request.naturalLanguageQuery = searchBar.text
        
        //検索範囲はマップビューと同じにする。
        request.region = mapView.region
        
        //ローカル検索を実行する。
        let localSearch:MKLocalSearch = MKLocalSearch(request: request)
        localSearch.start(completionHandler: {(result, error) in
            if nil != result {
                for placemark in (result?.mapItems)! {
                    if(error == nil) {
                        //検索された場所にピンを刺す。
                        let annotation = MapAnnotationCycle()
                        annotation.coordinate =     CLLocationCoordinate2DMake(placemark.placemark.coordinate.latitude, placemark.placemark.coordinate.longitude)
                        annotation.title = placemark.placemark.name
                        annotation.subtitle = "〒\(placemark.placemark.postalCode ?? "")\n\(placemark.placemark.administrativeArea ?? "")\(placemark.placemark.locality ?? "")\n\(placemark.placemark.name ?? "")"//placemark.placemark.title
                        annotation.setPinColor(.green)
                        self.annotationList.append(annotation)
                        self.mapView.addAnnotation(annotation)
                    }
                    else {
                        //エラー
                        print(error.debugDescription)
                    }
                }
            }
        })
    }

    // キーボードが表示された時
    @objc private func keyboardWillShow(_ notification: Notification) {
        guard let userInfo = notification.userInfo as? [String: Any] else {
            return
        }
        guard let keyboardInfo = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else {
            return
        }
        guard let duration = userInfo[UIResponder.keyboardAnimationDurationUserInfoKey] as? Double else {
            return
        }
        // 検索バーの幅を減らして(-80)、キャンセルボタンを表示する
        let dispSize: CGSize = UIScreen.main.bounds.size
        let width = Int(dispSize.width)
        let height = Int(dispSize.height)
        if isShowCalcDisp {
            searchBar.frame = CGRect(x: 0, y: (height/3)*2-50, width: width-80, height: 50)
        }
        else {
            searchBar.frame = CGRect(x: 0, y: height-50, width: width-80, height: 50)
        }
        CancelBtn.isHidden = false
        
        // キーボードに合わせてViewを上にスライドする
        let keyboardSize = keyboardInfo.cgRectValue.size
        UIView.animate(withDuration: duration) {
            let transform = CGAffineTransform(translationX: 0, y: -(keyboardSize.height))
            self.view.transform = transform
        }
    }

    // キーボードが消去された時
    @objc private func keyboardWillHide(_ notification: Notification) {
        guard let duration = notification.userInfo?[UIResponder.keyboardAnimationCurveUserInfoKey] as? TimeInterval else { return }
        UIView.animate(withDuration: duration) {
            self.view.transform = CGAffineTransform.identity
        }
        
        // 検索バーの幅を戻して、キャンセルボタンを消去する
        CancelBtn.isHidden = true
        let dispSize: CGSize = UIScreen.main.bounds.size
        let width = Int(dispSize.width)
        let height = Int(dispSize.height)
        if isShowCalcDisp {
            searchBar.frame = CGRect(x: 0, y: (height/3)*2-50, width: width, height: 50)
        }
        else {
            searchBar.frame = CGRect(x: 0, y: height-50, width: width, height: 50)
        }
    }

    // Cancelボタン押下
    @IBAction func btnCancelThouchDown(_ sender: Any) {
        // キーボードを戻す
        searchBar.resignFirstResponder()
    }
    
    //==================================================================
    // ロングタップ
    //==================================================================
    // UILongPressGestureRecognizerのdelegate：ロングタップを検出する
    @IBAction func mapViewDidLongPress(_ sender: UILongPressGestureRecognizer) {
        // ロングタップ開始
        if sender.state == .began {
            // ロングタップした住所と距離の初期化
            tapPointTitle = "タップした地点"
            tapStreetAddr = ""
            tapDistance = 0
            
            // タップした位置（CGPoint）を指定してMkMapView上の緯度経度を取得する
            let tapPoint = sender.location(in: view)
            let center = mapView.convert(tapPoint, toCoordinateFrom: mapView)
            tapRoutePoint = mapView.convert(tapPoint, toCoordinateFrom: mapView)

            let location = CLLocation(latitude: center.latitude, longitude: center.longitude)

            // 地図上のルートを削除
// 地点タッチするたびにルートを消すと面倒なので、ルート探索時に消去する
//          if nil != self.routePolyLine {
//              self.mapView.removeOverlay(self.routePolyLine)
//              self.routePolyLine = nil
//          }
            
            // ロングタップした位置にピンを立てる
            mapView.removeAnnotation(pointAno)
            pointAno.coordinate = center
            mapView.addAnnotation(pointAno)
            
            // 現在位置とタップした位置の距離(m)を算出する
            tapDistance = calcDistance(mapView.userLocation.coordinate, center)
            
            // タップした地点の住所を取得する
            let geocoder = CLGeocoder()
            geocoder.reverseGeocodeLocation(location) { (placemarks, error) in
                if let placemarks = placemarks {
                    if let pm = placemarks.first {
                        // mainスレッドで処理する
                        DispatchQueue.main.async {
                            self.tapPointTitle = pm.name
                            self.tapStreetAddr = "〒\(pm.postalCode ?? "")\n\(pm.administrativeArea ?? "")\(pm.locality ?? "")\n\(pm.name ?? "")"
                            // ピンのタイトルを設定する
                            self.pointAno.title = pm.name
                            self.pointAno.subtitle = self.tapStreetAddr
                            
                            // ロングタップした地点のViewをPopup表示する
                            self.showPointPopupView()
                        }
                    }
                }
            }
        }
        // ロングタップ終了（手を離した）
        else if sender.state == .ended {

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
    
    // タップした地点の名称を取得する
    public func getTapPointTitle() -> String {
        return tapPointTitle
    }
    
    // ロングタップした住所を取得する
    public func getTapStreetAddr() -> String {
        return tapStreetAddr
    }
    
    // ロングタップした位置までの距離を取得する
    public func getTapDistance() -> String {
        var retVal: String!
        let dist = Int(tapDistance)
        if (1000 > dist) {
            retVal = dist.description + " m"
        }
        else {
            let dDist: Double = floor((Double(dist)/1000)*100)/100
            retVal = dDist.description + " km"
        }
        
        return retVal
    }
    
    // ルート探索
    public func routeSearch() {
        let sourcePlaceMark = MKPlacemark(coordinate: mapView.userLocation.coordinate)
        let destinationPlaceMark = MKPlacemark(coordinate: tapRoutePoint)
        
        let directionRequest = MKDirections.Request()
        directionRequest.source = MKMapItem(placemark: sourcePlaceMark)
        directionRequest.destination = MKMapItem(placemark: destinationPlaceMark)
        directionRequest.transportType = .walking
        
        let directions = MKDirections(request: directionRequest)
        directions.calculate { (response, error) in
            guard let directionResonse = response else {
                if let error = error {
                    print("we have error getting directions==\(error.localizedDescription)")
                }
                return
            }
            // mainスレッドで処理する
            DispatchQueue.main.async {
                // 目的地のアノテーションを別に立てる
                self.destinationAno.coordinate = CLLocationCoordinate2DMake(self.tapRoutePoint.latitude, self.tapRoutePoint.longitude)
                self.destinationAno.title = "目的地" + "\n" + self.tapPointTitle
                self.destinationAno.subtitle = self.tapStreetAddr
                self.destinationAno.setPinColor(.blue)
                self.mapView.addAnnotation(self.destinationAno)
                
                // 地図上のオーバーレイを削除
                if nil != self.routePolyLine {
                    self.mapView.removeOverlay(self.routePolyLine)
                    self.routePolyLine = nil
                }
                
                // ルートを表示
                let route = directionResonse.routes[0]
                self.routePolyLine = route.polyline
                self.routePolyLine.subtitle = "route"
                self.mapView.addOverlay(self.routePolyLine)
                
                //　縮尺を設定
                let rect = route.polyline.boundingMapRect
                self.mapView.setRegion(MKCoordinateRegion(rect), animated: true)
            }
        }
    }
    

    //==================================================================
    // WatchOSとのデータ通信
    //==================================================================
    // WCSessionDelegateを継承した場合に定義しないととエラーになる
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
    
    // WCSessionDelegateを継承した場合に定義しないととエラーになる
    public func sessionDidBecomeInactive(_ session: WCSession){
        print("sessionDidBecomeInactive")
    }
    
    // WCSessionDelegateを継承した場合に定義しないととエラーになる
    public func sessionDidDeactivate(_ session: WCSession){
        print("sessionDidDeactivate")
    }
    
    // watchOSにモードを送信する
    func sendMessageMode() {
        let contents =  ["RESP":"MODE", "title":"サイクルモード"] as [String : Any]
        self.session.sendMessage(contents, replyHandler: { (replyMessage) -> Void in
            print ("receive from apple watch");
        }) { (error) -> Void in
            print(error)
        }
    }
    
    // watchOSにモード別に表示するデータを送信する
    func sendMessageModeData() {
        var modeData: String!
        
        // 送信データ作成
        if isStarting {
            // 計測中は計測中のデータを送信
            modeData =  "走行中" + "\n"
            modeData += "安全な走行を"
        }
        else {
            // 計測中でなければ累計データを送信
            let appDelegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate
            // 累計最高速度
            let speed = appDelegate.userDataManager.getTotalMaxSpeed()
            // 累計走行距離
            let dist = appDelegate.userDataManager.getTotalDrivingDist()
            let tmpDist = floor((dist / 1000) * 100) / 100
            // 累計走行時間
            let time = appDelegate.userDataManager.getTotalDrivingTime()
            let hour = Int(time) / 3600
            let min = (Int(time) - (hour * 3600)) / 60
            let sec = Int(time) - ((hour * 3600) + (min * 60))
            
            modeData =  "累計データ" + "\n"
            modeData += "最高速度 " + speed.description + "\n"
            modeData += "距離 " + tmpDist.description + "\n"
            modeData += "時間 " + String(format: "%02d", hour) + ":" +  String(format: "%02d", min) + ":" +  String(format: "%02d", sec)
        }
        
        // データ送信
        let contents =  ["RESP":"WALK", "data":modeData] as [String : Any]
        self.session.sendMessage(contents, replyHandler: { (replyMessage) -> Void in
            print ("receive from apple watch");
        }) { (error) -> Void in
            print(error)
        }
    }

    // watchOSからMessage受信
    public func session(_ session: WCSession, didReceiveMessage message: [String : Any], replyHandler: @escaping ([String : Any]) -> Swift.Void) {
        print("receiveMessage[iOS]::\(message)")
        replyHandler(["message" : "received message."])

        // String型以外は処理しない
        guard let getType = message["GET"] as? String else {
            return
        }

        switch getType {
        case "MODE":
            sendMessageMode()
        case "MODEDATA":
            sendMessageModeData()
        default:
            print("not exist type.")
        }
    }
}


// MKMapViewDelegate
extension CycleViewController : MKMapViewDelegate {
    // 読み込み開始
    func mapViewWillStartRenderingMap(_ mapView: MKMapView) {
        print("map load start")
    }
    
    // 読み込み終了時
    func mapViewDidFinishLoadingMap(_ mapView: MKMapView) {
        print("map load ended")
    }
    
    // addOverlayした際に呼ばれるデリゲートメソッド
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        // rendererを生成.
        let myPolyLineRendere: MKPolylineRenderer = MKPolylineRenderer(overlay: overlay)
        
        if ("route" == overlay.subtitle) {
            // 線の太さを指定.
            myPolyLineRendere.lineWidth = 6
            // 線の色を指定.
            myPolyLineRendere.strokeColor = UIColor.green
        }
        else {
            // 線の太さを指定.
            myPolyLineRendere.lineWidth = 5
            // 線の色を指定.
            myPolyLineRendere.strokeColor = UIColor.blue
        }
        return myPolyLineRendere
    }
    
    // アノテーションを選択した際に呼ばれるデリゲート
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        // 現在位置とタップした位置の距離(m)を算出する
        let annotation = view.annotation
        
        if (nil == annotation?.subtitle!) {
            tapPointTitle = "タップした地点"
        }
        else {
            // POP UP画面に表示する住所
            tapPointTitle = annotation?.title ?? ""
            tapStreetAddr = annotation?.subtitle ?? ""
        }
        // POP UP画面に表示する距離
        let coordinate = CLLocationCoordinate2D(latitude: (annotation?.coordinate.latitude)!, longitude: (annotation?.coordinate.longitude)!)
        tapDistance = calcDistance(mapView.userLocation.coordinate, coordinate)
        // POP UP画面で探索する地点
        tapRoutePoint = coordinate

        showPointPopupView()
    }
    
    // ロングタップしてアノテーションを設定した時、アノテーションビューを返すメソッド
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        // 現在位置の点滅がピンにならないように、アノテーションがUserLocationの場合は何もしないようにする。
        if( annotation is MKUserLocation ) {
            return nil
        }
        
        return nil

        // 色を変えたいが、ピンが細いタイプで、選択しないとTitleが出ないため今回のVersionでは見送る
        let identifier = "pinAnnotation"
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier) as? MKPinAnnotationView

        if annotationView == nil {
            annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            annotationView?.canShowCallout = true
            let colorPointAnnotation = annotation as! MapAnnotationCycle
            annotationView?.pinTintColor = colorPointAnnotation.pinColor
            annotationView?.isHighlighted = true
        }
        
        return annotationView
    }
}

// FloatingPanelControllerDelegate を実装してカスタマイズしたレイアウトを返す
extension CycleViewController : FloatingPanelControllerDelegate {
    // モーダル表示
    func floatingPanel(_ vc: FloatingPanelController, layoutFor newCollection: UITraitCollection) -> FloatingPanelLayout? {
        return CustomFloatingPanelLayout()
    }
    
    // サイズを変更した後に実施する処理
    func floatingPanelDidEndDragging(_ vc: FloatingPanelController, withVelocity velocity: CGPoint, targetPosition: FloatingPanelPosition) {
        
        let appDelegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.pointPopupViewController.resize(targetPosition)
    }
}


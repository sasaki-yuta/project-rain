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
                            UIGestureRecognizerDelegate {

    @IBOutlet var mapView: MKMapView!
    @IBOutlet var mapViewTypeOver: UIButton!
    @IBOutlet var longPressGesRec: UILongPressGestureRecognizer!
    
    var locManager: CLLocationManager!
    var mapViewType: UIButton!
    var isStarting: Bool! = false
    var session: WCSession!
    
    // UserDefaults(データバックアップ用)オブジェクト
    var userDataManager:UserDataManager!
    
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
    @IBOutlet var lbar4: UILabel!
    
    // GPS誤差補正
    var timeInterval: Int = 0
    var accuracy: Int = 0
    
    // アノテーション
    var pointAno: MapAnnotationCycle = MapAnnotationCycle()
    
    // ロングタップした地点の情報
    var tapStreetAddr: String!                  // 住所
    var tapDistance: CLLocationDistance!        // 距離
    var tapRoutePoint: CLLocationCoordinate2D!  // ルート探索用のタッチポイント
    
        
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
        locManager.allowsBackgroundLocationUpdates = true
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
            // CLLocationManagerのdelegateを登録する
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
        
        // WatchOSにモードを通知する
        sendMessageMode()
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
        
        // 全開のMapTypeをUserDataから取得してMapViewに設定する
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
        mapView.frame.size = CGSize(width: width, height: (height/3)*2) // 高さ2/3を地図にする

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

        // 各種情報表示位置の係数
        let infoTopPos = (height/3)*2
        let labelHeight = ((height/3)*1)/2/2 // 画面の1/3を情報表示エリアにする
        
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
        lblDrivingTime.frame = CGRect(x: 0, y: infoTopPos+(labelHeight*2), width: width, height: labelHeight/2)
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
        lbar1.frame = CGRect(x: 0, y: infoTopPos, width: width, height: 2)
        self.view.addSubview(lbar1)
        
        // bar2
        lbar2.frame = CGRect(x: 0, y: infoTopPos+(labelHeight*2), width: width, height: 2)
        self.view.addSubview(lbar2)

        // bar4
        lbar4.frame = CGRect(x: width/2, y: infoTopPos, width: 2, height: labelHeight*2)
        self.view.addSubview(lbar4)

        let appDelegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate
        // GPS誤差補正
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
            // GPS時間鮮度
            isBreak = true
        }
        if 0 > locations.last!.horizontalAccuracy {
            // GPS取得の諸条件のどれかが致命的に悪い場合
            isBreak = true
        }
        if accuracy < Int(locations.last!.horizontalAccuracy) {
            // m誤差
            isBreak = true
        }
        
        if (isBreak) {
            // GPSが精度が許容範囲外なら表示速度を0、前回の計測位置を初期化する
            self.speed.text = "0.0"
            self.beforLon = 0
            self.beforLat = 0
            // 中断していないので走行時間だけは加算するため初期化しない
//            self.beforSinRef = 0
            return
        }
        
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
        else {
            // 走行速度の更新
            self.speed.text = "0.0"
            // 前回値として2001年1月1日の00:00:00 UTCと現在の日時の間の秒間隔:ex 587280439.457562)を保持
            self.beforSinRef = locations.last!.timestamp.timeIntervalSinceReferenceDate
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
    }
    
    // 計測を再開する
    func cycleReStart() {
        self.isStarting = true
    }
    
    // 計測を中断する
    func cycleStop() {
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
    }

    // 計測を終了する
    func cycleEnd() {
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
    }
    
    // 計測中断、終了したデータをViewを切り替えても表示できる様に保存する
    func saveCulcData() {
        let appDelegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.userDataManager.setAvgSumSpeed(avgSumSpeed, avgSumCount)
        appDelegate.userDataManager.setDrivingDist(dDrivingDist)
        appDelegate.userDataManager.setDrivingTime(dDrivingTime)
        appDelegate.userDataManager.setMaxSpeed(dMaxSpeed)
    }

    // 計測中断、終了したデータをViewを切り替えても表示できる様にLoradする
    func loadCulcData() {
        let appDelegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate
        avgSumSpeed = appDelegate.userDataManager.getAvgSumSpeed()
        avgSumCount = appDelegate.userDataManager.getAvgSumCount()
        dDrivingDist = appDelegate.userDataManager.getDrivingDist()
        dDrivingTime = appDelegate.userDataManager.getDrivingTime()
        dMaxSpeed = appDelegate.userDataManager.getMaxSpeed()
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

   //==================================================================
   // ロングタップ
   //==================================================================
   // UILongPressGestureRecognizerのdelegate：ロングタップを検出する
   @IBAction func mapViewDidLongPress(_ sender: UILongPressGestureRecognizer) {
        // ロングタップ開始
        if sender.state == .began {
            // ロングタップした住所と距離の初期化
            tapStreetAddr = ""
            tapDistance = 0
            
            // タップした位置（CGPoint）を指定してMkMapView上の緯度経度を取得する
            let tapPoint = sender.location(in: view)
            let center = mapView.convert(tapPoint, toCoordinateFrom: mapView)
            tapRoutePoint = mapView.convert(tapPoint, toCoordinateFrom: mapView)

            let location = CLLocation(latitude: center.latitude, longitude: center.longitude)

            // ロングタップした位置にピンを立てる
            mapView.removeAnnotation(pointAno)
            pointAno.coordinate = center
            mapView.addAnnotation(pointAno)
            
            //ピンを作成してマップビューに登録する。
//            let annotation = MKPointAnnotation()
//            annotation.coordinate = center
//            annotation.title = "目的地候補"
//            annotation.subtitle = "ボタンタップで経路を表示"
//            mapView.addAnnotation(annotation)
            
            // 現在位置とタップした位置の距離(m)を算出する
            tapDistance = calcDistance(mapView.userLocation.coordinate, center)
            
            // タップした地点の住所を取得する
            let geocoder = CLGeocoder()
            geocoder.reverseGeocodeLocation(location) { (placemarks, error) in
                if let placemarks = placemarks {
                    if let pm = placemarks.first {
                        self.tapStreetAddr = "〒\(pm.postalCode ?? "")\n\(pm.administrativeArea ?? "")\(pm.locality ?? "") \n\(pm.name ?? "")"
                        // ピンのタイトルを設定する
                        self.pointAno.title = pm.name
                        
                        // mainスレッドで処理する
                        DispatchQueue.main.async {
                            // ViewをPopUp表示する
                            let storyboard: UIStoryboard = self.storyboard!
                            let second = storyboard.instantiateViewController(withIdentifier: "PointPopupViewController")
                            // modalPresentationStyleを指定する
                            second.modalPresentationStyle = .popover
                            self.present(second, animated: true, completion: nil)
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
            //　ルートを追加
            let route = directionResonse.routes[0]
            self.mapView.addOverlay(route.polyline, level: .aboveRoads)
            //　縮尺を設定
            let rect = route.polyline.boundingMapRect
            self.mapView.setRegion(MKCoordinateRegion(rect), animated: true)
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
        
        // 線の太さを指定.
        myPolyLineRendere.lineWidth = 5
        
        // 線の色を指定.
        myPolyLineRendere.strokeColor = UIColor.blue
        
        return myPolyLineRendere
    }
    
    // ロングタップしてアノテーションを設定した時、アノテーションビューを返すメソッド
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        // 現在位置の点滅がピンにならないように、アノテーションがUserLocationの場合は何もしないようにする。
        if( annotation is MKUserLocation ) {
            return nil
        }

        // ボタンや画像など独自のピンを作成する場合は、下記を有効にして更新する
        return nil
                
        // アノテーションビューを生成する。
        let testView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: nil)
        // 吹き出しを表示可能にする。
        testView.canShowCallout = true

        // 経路ボタンをアノテーションビューに追加する。
        let button = UIButton()
        button.frame = CGRect(x: 0,y: 0,width: 40,height: 30)
        button.setTitle("経路", for: .normal)
        button.backgroundColor = UIColor.blue
        button.setTitleColor(UIColor.white, for:.highlighted)
        testView.rightCalloutAccessoryView = button
        
        return testView
    }

}

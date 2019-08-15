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

class CycleViewController:  UIViewController,
                            CLLocationManagerDelegate {

    @IBOutlet var mapView: MKMapView!
    @IBOutlet var mapViewTypeOver: UIButton!
    var locManager: CLLocationManager!
    var mapViewType: UIButton!
    var isStarting: Bool! = false
    
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
    // 走行距離
    var beforLon: Double! = 0.0
    var beforLat: Double! = 0.0
    var dDrivingDist: Double! = 0.0
    @IBOutlet var drivingDist: UILabel!
    @IBOutlet var lblDrivingDist: UILabel!
    // 走行時間
    var beforSinRef: Double! = 0.0
    var dDrivingTime: Double! = 0.0
    @IBOutlet var drivingTime: UILabel!
    @IBOutlet var lblDrivingTime: UILabel!

    // MAX速度
    var dMaxSpeed: Double! = 0.0
    @IBOutlet var maxSpeed: UILabel!
    @IBOutlet var lblMaxSpeed: UILabel!
    // 累計MAX速度
    var dTotalMaxSpeed: Double! = 0.0
    @IBOutlet var totalMaxSpeed: UILabel!
    @IBOutlet var lblTotalMaxSpeed: UILabel!
    // 累計走行距離
    var dTotalDrivingDist: Double! = 0.0
    @IBOutlet var totalDrivingDist: UILabel!
    @IBOutlet var lblTotalDrivingDist: UILabel!
    // 累計走行時間
    var dTotalDrivingTime: Double! = 0.0
    @IBOutlet var totalDrivingTime: UILabel!
    @IBOutlet var lblTotalDrivingTime: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        // AppDelegateに追加したCycleViewControllerに自身を設定
        let appDelegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.cycleViewController = self

        // UserDefaults(データバックアップ用)オブジェクト
        userDataManager = appDelegate.userDataManager
        
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
        mapView.frame.size = CGSize(width: width, height: height-270)

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

        // UserDefaultsの初期化
        userDataManager.roadData()
        dTotalMaxSpeed = userDataManager.getTotalMaxSpeed()
        dTotalDrivingDist = userDataManager.getTotalDrivingDist()
        dTotalDrivingTime = userDataManager.getTotalDrivingTime()
        
        // 速度
        speed.frame = CGRect(x: 190, y: height-230, width: 190, height: 40)
        speed.text = "-"
        self.view.addSubview(speed)
        lblSpeed.frame = CGRect(x: 190, y: height-250, width: 190, height: 20)
        self.view.addSubview(lblSpeed)
        // 平均速度
        avgSpeed.frame = CGRect(x: 190, y: height-170, width: 190, height: 40)
        avgSpeed.text = "-"
        self.view.addSubview(avgSpeed)
        lblAvgSpeed.frame = CGRect(x: 190, y: height-190, width: 190, height: 20)
        self.view.addSubview(lblAvgSpeed)
        // 走行距離
        drivingDist.frame = CGRect(x: 190, y: height-110, width: 190, height: 40)
        drivingDist.text = "-"
        self.view.addSubview(drivingDist)
        lblDrivingDist.frame = CGRect(x: 190, y: height-130, width: 190, height: 20)
        self.view.addSubview(lblDrivingDist)
        // 走行時間
        drivingTime.frame = CGRect(x: 190, y: height-50, width: 190, height: 40)
        drivingTime.text = "-"
        self.view.addSubview(drivingTime)
        lblDrivingTime.frame = CGRect(x: 190, y: height-70, width: 190, height: 20)
        self.view.addSubview(lblDrivingTime)
        
        // MAX速度
        maxSpeed.frame = CGRect(x: 0, y: height-230, width: 190, height: 40)
        maxSpeed.text = "-"
        self.view.addSubview(maxSpeed)
        lblMaxSpeed.frame = CGRect(x: 0, y: height-250, width: 190, height: 20)
        self.view.addSubview(lblMaxSpeed)
        // 累計MAX速度
        totalMaxSpeed.frame = CGRect(x: 0, y: height-170, width: 190, height: 40)
        totalMaxSpeed.text = dTotalMaxSpeed.description
        self.view.addSubview(totalMaxSpeed)
        lblTotalMaxSpeed.frame = CGRect(x: 0, y: height-190, width: 190, height: 20)
        self.view.addSubview(lblTotalMaxSpeed)
        // 累計走行距離
        totalDrivingDist.frame = CGRect(x: 0, y: height-110, width: 190, height: 40)
        let tmpDist = floor((self.dTotalDrivingDist / 1000) * 100) / 100
        totalDrivingDist.text = tmpDist.description
        self.view.addSubview(totalDrivingDist)
        lblTotalDrivingDist.frame = CGRect(x: 0, y: height-130, width: 190, height: 20)
        self.view.addSubview(lblTotalDrivingDist)
        // 累計走行時間
        totalDrivingTime.frame = CGRect(x: 0, y: height-50, width: 190, height: 40)
        let hour = Int(dTotalDrivingTime) / 3600
        let min = (Int(dTotalDrivingTime) - (hour * 3600)) / 60
        let sec = Int(dTotalDrivingTime) - ((hour * 3600) + (min * 60))
        totalDrivingTime.text = String(format: "%02d", hour) + ":" +  String(format: "%02d", min) + ":" +  String(format: "%02d", sec)

        self.view.addSubview(totalDrivingTime)
        lblTotalDrivingTime.frame = CGRect(x: 0, y: height-70, width: 190, height: 20)
        self.view.addSubview(lblTotalDrivingTime)
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
        
        // 精度の悪い位置情報を捨てる
        print("timeIntervalSinceNow = " + abs(locations.last!.timestamp.timeIntervalSinceNow).description)
        print("horizontalAccuracy = " + locations.last!.horizontalAccuracy.description)
        if 5.0 <= abs(locations.last!.timestamp.timeIntervalSinceNow) {
            // 5以上経過した位置情報
            return
        }
        if 0 > locations.last!.horizontalAccuracy {
            // GPS取得の諸条件のどれかが致命的に悪い場合
            return
        }
        if 20 < locations.last!.horizontalAccuracy {
            // 20m以上の誤差
            return
        }

        // 秒速を少数第2位の時速に変換
        let speed: Double = floor((locations.last!.speed * 3.6)*100)/100
        
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
                totalMaxSpeed.text = dTotalMaxSpeed.description
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
                var hour = Int(self.dDrivingTime) / 3600
                var min = (Int(self.dDrivingTime) - (hour * 3600)) / 60
                var sec = Int(self.dDrivingTime) - ((hour * 3600) + (min * 60))
                self.drivingTime.text = String(format: "%02d", hour) + ":" +  String(format: "%02d", min) + ":" +  String(format: "%02d", sec)
                
                // 累計の走行時間の更新
                self.dTotalDrivingTime += dTime
                hour = Int(self.dTotalDrivingTime) / 3600
                min = (Int(self.dTotalDrivingTime) - (hour * 3600)) / 60
                sec = Int(self.dTotalDrivingTime) - ((hour * 3600) + (min * 60))
                self.totalDrivingTime.text = String(format: "%02d", hour) + ":" +  String(format: "%02d", min) + ":" +  String(format: "%02d", sec)
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
                var tmpDist = floor((self.dDrivingDist / 1000) * 100) / 100
                self.drivingDist.text = tmpDist.description

                // 累計走行距離の更新
                self.dTotalDrivingDist += dist
                tmpDist = floor((self.dTotalDrivingDist / 1000) * 100) / 100
                self.totalDrivingDist.text = tmpDist.description
                // UserDefaultsにバックアップする
                userDataManager.setTotalDrivingDist(dTotalDrivingDist)

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
            self.speed.text = "0"
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
    func toCycleView() {
        // CycleViewControllerを表示する
        self.performSegue(withIdentifier: "toGolfView", sender: nil)
        // 累計データを画面遷移時に保存する
        userDataManager.saveCycleData()
    }
    
    // 累計データを消去する
    func deleteData() {
        self.userDataManager.deleteCycleData()
        dTotalMaxSpeed = 0.0
        dTotalDrivingDist = 0.0
        dTotalDrivingTime = 0.0
        totalMaxSpeed.text = "0.0"
        totalDrivingDist.text = "0.0"
        totalDrivingTime.text = "00:00:00"
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
        speed.text = "-"
        // 平均速度
        avgSpeed.text = "-"
        // 走行距離
        drivingDist.text = "-"
        // 走行時間
        drivingTime.text = "-"
        // MAX速度
        maxSpeed.text = "-"

        self.isStarting = true
    }
    
    // 計測を再開する
    func cycleReStart() {
        self.isStarting = true
    }
    
    // 計測を中断する
    func cycleStop() {
        self.isStarting = false
        
        // 累計データを画面遷移時に保存する
        userDataManager.saveCycleData()
    }

    // 計測を終了する
    func cycleEnd() {
        self.isStarting = false
        
        // 累計データを画面遷移時に保存する
        userDataManager.saveCycleData()
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
}

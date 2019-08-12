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

    // 走行時間
    @IBOutlet var drivingTime: UILabel!
    @IBOutlet var lblDrivingTime: UILabel!
    // 累計走行時間
    @IBOutlet var totalDrivingTime: UILabel!
    @IBOutlet var lblTotalDrivingTime: UILabel!
    // 走行距離
    @IBOutlet var drivingDist: UILabel!
    @IBOutlet var lblDrivingDist: UILabel!
    // 累計走行距離
    @IBOutlet var totalDrivingDist: UILabel!
    @IBOutlet var lblTotalDrivingDist: UILabel!
    // 平均速度
    @IBOutlet var avgSpeed: UILabel!
    @IBOutlet var lblAvgSpeed: UILabel!
    // 累計平均速度
    @IBOutlet var totalAvgSpeed: UILabel!
    @IBOutlet var lblTotalAvgSpeed: UILabel!
    // 速度
    @IBOutlet var speed: UILabel!
    @IBOutlet var lblSpeed: UILabel!
    // MAX速度
    var dMaxSpeed: Double! = 0.0
    @IBOutlet var maxSpeed: UILabel!
    @IBOutlet var lblMaxSpeed: UILabel!

    var mapViewType: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        // AppDelegateに追加したCycleViewControllerに自身を設定
        let appDelegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.cycleViewController = self

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
        
        // 走行時間
        drivingTime.frame = CGRect(x: 190, y: height-50, width: 190, height: 40)
        self.view.addSubview(drivingTime)
        lblDrivingTime.frame = CGRect(x: 190, y: height-70, width: 190, height: 20)
        self.view.addSubview(lblDrivingTime)
        // 累計走行時間
        totalDrivingTime.frame = CGRect(x: 0, y: height-50, width: 190, height: 40)
        self.view.addSubview(totalDrivingTime)
        lblTotalDrivingTime.frame = CGRect(x: 0, y: height-70, width: 190, height: 20)
        self.view.addSubview(lblTotalDrivingTime)
        // 走行距離
        drivingDist.frame = CGRect(x: 190, y: height-110, width: 190, height: 40)
        self.view.addSubview(drivingDist)
        lblDrivingDist.frame = CGRect(x: 190, y: height-130, width: 190, height: 20)
        self.view.addSubview(lblDrivingDist)
        // 累計走行距離
        totalDrivingDist.frame = CGRect(x: 0, y: height-110, width: 190, height: 40)
        self.view.addSubview(totalDrivingDist)
        lblTotalDrivingDist.frame = CGRect(x: 0, y: height-130, width: 190, height: 20)
        self.view.addSubview(lblTotalDrivingDist)
        // 平均速度
        avgSpeed.frame = CGRect(x: 190, y: height-170, width: 190, height: 40)
        self.view.addSubview(avgSpeed)
        lblAvgSpeed.frame = CGRect(x: 190, y: height-190, width: 190, height: 20)
        self.view.addSubview(lblAvgSpeed)
        // 累計平均速度
        totalAvgSpeed.frame = CGRect(x: 0, y: height-170, width: 190, height: 40)
        self.view.addSubview(totalAvgSpeed)
        lblTotalAvgSpeed.frame = CGRect(x: 0, y: height-190, width: 190, height: 20)
        self.view.addSubview(lblTotalAvgSpeed)
        // 速度
        speed.frame = CGRect(x: 190, y: height-230, width: 190, height: 40)
        self.view.addSubview(speed)
        lblSpeed.frame = CGRect(x: 190, y: height-250, width: 190, height: 20)
        self.view.addSubview(lblSpeed)
        // MAX速度
        maxSpeed.frame = CGRect(x: 0, y: height-230, width: 190, height: 40)
        self.view.addSubview(maxSpeed)
        lblMaxSpeed.frame = CGRect(x: 0, y: height-250, width: 190, height: 20)
        self.view.addSubview(lblTotalAvgSpeed)
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
        let lonStr = (locations.last?.coordinate.longitude.description)!
        let latStr = (locations.last?.coordinate.latitude.description)!
        
        // 時速表示
        let speed: Double = floor((locations.last!.speed * 3.6)*100)/100
        if (0.0 < speed) {
            self.speed.text = speed.description
        }
        else {
            self.speed.text = "0"
        }
        // 過去最高速度の更新
        if speed > dMaxSpeed {
            dMaxSpeed = speed
            maxSpeed.text = dMaxSpeed.description
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

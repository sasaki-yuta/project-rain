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

class ViewController:   UIViewController,
                        CLLocationManagerDelegate,
                        UIGestureRecognizerDelegate {

    @IBOutlet var mapView: MKMapView!
    @IBOutlet var longPressGesRec: UILongPressGestureRecognizer!
    var locManager: CLLocationManager!
    var pointAno: MKPointAnnotation = MKPointAnnotation()
    var mapViewType: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

        // CLLocationManagerのdelegateを登録する
        locManager = CLLocationManager()
        locManager.delegate = self

        // 位置情報の使用の許可を得る
        locManager.requestWhenInUseAuthorization()
        if CLLocationManager.locationServicesEnabled() {
            switch CLLocationManager.authorizationStatus() {
            case .authorizedWhenInUse:
                // 座標の表示
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
        
        // 地図表示タイプを切り替えるボタン
        mapViewType = UIButton(type: UIButton.ButtonType.detailDisclosure)
        mapViewType.frame = CGRect(x:width - 50, y:60, width:40, height:40)
        mapViewType.layer.backgroundColor = UIColor(white: 1, alpha: 0.8).cgColor // 背景色
        mapViewType.layer.borderWidth = 0.5 // 枠線の幅
        mapViewType.layer.borderColor = UIColor.blue.cgColor // 枠線の色
//      mapViewType.layer.cornerRadius = 10.0 // 角丸のサイズ
//      mapViewType.layer.shadowRadius = 5 // ぼかし
        self.view.addSubview(mapViewType)
        mapViewType.addTarget(self, action: #selector(ViewController.mapViewTypeBtnThouchDown(_:)), for: .touchDown)
        // トラッキングボタン表示
        let trakingBtn = MKUserTrackingButton(mapView: mapView)
        trakingBtn.layer.backgroundColor = UIColor(white: 1, alpha: 0.8).cgColor
        trakingBtn.frame = CGRect(x:width - 50, y:100, width:40, height:40)
        trakingBtn.layer.borderWidth = 0.5 // 枠線の幅
        trakingBtn.layer.borderColor = UIColor.blue.cgColor // 枠線の色
        self.view.addSubview(trakingBtn)
        
        // スケールバーの表示
        let scale = MKScaleView(mapView: mapView)
        scale.frame.origin.x = 15
        scale.frame.origin.y = 45
        scale.legendAlignment = .leading
        self.view.addSubview(scale)
        
        // コンパスの表示
        let compass = MKCompassButton(mapView: mapView)
        compass.compassVisibility = .adaptive
        compass.frame = CGRect(x: width - 50, y: 150, width: 40, height: 40)
        self.view.addSubview(compass)
        // デフォルトのコンパスを非表示にする
        mapView.showsCompass = false
    }

    // CLLocationManagerのdelegate：現在位置取得
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations:[CLLocation]) {
        let lonStr = (locations.last?.coordinate.longitude.description)!
        let latStr = (locations.last?.coordinate.latitude.description)!
        
        print("lon : " + lonStr)
        print("lat : " + latStr)


//-----------------------------------------------------------------------------------
//      トラッキングモードボタンを自作する場合の処理

        //【パターン1】スクロールモード以外であれば現在位置を地図の中心に更新する(カクカク表示されてしまう)
//      updateCurrentPos((locations.last?.coordinate)!)

        //【パターン2】カクカクしない様に対応した
//      switch mapView.userTrackingMode {
//      case .followWithHeading:
//          mapView.userTrackingMode = .followWithHeading
//          break
//      case .follow:
//          mapView.userTrackingMode = .follow
//          break
//      default:
//          break
//      }
//-----------------------------------------------------------------------------------

        // 現在位置とタッウプした位置の距離(m)を算出する
        let distance = calcDistance(mapView.userLocation.coordinate, pointAno.coordinate)
        
        if (0 != distance) {
            // ピンに設定する文字列を生成する
            var str:String = Int(distance).description
            str = str + " m"
            
            // yard
            let yardStr = Int(distance * 1.09361)
            str = str + " / " + yardStr.description + " yard"
            
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
            mapView.removeAnnotation(pointAno)
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
            str = str + " / " + yardStr.description + " yard"
            
            // ロングタップを検出した位置にピンを立てる
            pointAno.coordinate = center
            pointAno.title = str
            mapView.addAnnotation(pointAno)
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
    
    // トラッキングボタンタッチダウン
    @IBAction func trackingBtnThouchDown(_ sender: AnyObject) {
//-----------------------------------------------------------------------------------
//      トラッキングモードボタンを自作する場合の処理
//
//      switch mapView.userTrackingMode {
//      case .follow:
//          mapView.userTrackingMode = .followWithHeading
//          break
//      case .followWithHeading:
//          mapView.userTrackingMode = .none
//          break
//      default:
//          mapView.userTrackingMode = .follow
//          break
//      }
//-----------------------------------------------------------------------------------
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
    
}

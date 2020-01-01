//
//  WalkViewController.swift
//  MapApp
//
//  Created by yuta sasaki on 2019/12/29.
//  Copyright © 2019 rain-00-00-09. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation
import WatchConnectivity

// MKPointAnnotation拡張用クラス
class MapAnnotationWalk: MKPointAnnotation {
    var pinColor: UIColor = .red
    
    func setPinColor(_ color: UIColor) {
        pinColor = color
    }
}

class WalkViewController:   UIViewController,
                            CLLocationManagerDelegate,
                            MKMapViewDelegate,
                            UIGestureRecognizerDelegate,
                            UISearchBarDelegate {

    @IBOutlet var mapView: MKMapView!
    @IBOutlet var mapViewTypeOver: UIButton!
    @IBOutlet var longPressGesRec: UILongPressGestureRecognizer!
    
    var mapViewType: UIButton!              // mapViewTypeOverのボタン本体
    var userDataManager:UserDataManager!    // UserDefaults(データバックアップ用)オブジェクト
    var locManager: CLLocationManager!      // 位置情報
    
    // アノテーション
    var pointAno: MapAnnotationWalk = MapAnnotationWalk()
    
    // タップした地点の情報
    var tapPointTitle: String! = ""                 // タップした地点のタイトル
    var tapStreetAddr: String! = ""                 // 住所
    var tapDistance: CLLocationDistance! = 0        // 距離
    var tapRoutePoint: CLLocationCoordinate2D!      // ルート探索用のタッチポイント
    
    // 表示したルート
    var routePolyLine: MKPolyline!

    // 検索
    @IBOutlet var searchBar: UISearchBar!
    var annotationList = [MapAnnotationCycle]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        // AppDelegateに追加したviewControllerに自身を設定
        let appDelegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.walkViewController = self
        
        // UserDefaults(データバックアップ用)オブジェクト
        userDataManager = appDelegate.userDataManager
        
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
        notification.addObserver(self, selector: #selector(keyboardWillShow(_:)),
                                 name: UIResponder.keyboardWillShowNotification, object: nil)
        notification.addObserver(self, selector: #selector(keyboardWillHide(_:)),
                                 name: UIResponder.keyboardWillHideNotification, object: nil)

        
        initMap()
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
        
        // 前回のMapTypeをUserDataから取得してMapViewに設定する
        setMapType(userDataManager.getWalkMapType())

        // デバイスの画面サイズを取得する
        let dispSize: CGSize = UIScreen.main.bounds.size
        let width = Int(dispSize.width)
        let height = Int(dispSize.height)

        // 地図のサイズを画面サイズに設定する
        mapView.frame.size = CGSize(width: width, height: height)
        
        // 縮尺を設定
        var region:MKCoordinateRegion = mapView.region
        region.span.latitudeDelta = 0.02
        region.span.longitudeDelta = 0.02
        mapView.setRegion(region,animated:true)
        
        // 現在位置表示の有効化
        mapView.showsUserLocation = true
        // 現在位置設定
        mapView.userTrackingMode = .follow


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
        
        // 検索フィールドの位置
        searchBar.frame = CGRect(x: 0, y: height-50, width: width, height: 50)
        self.view.addSubview(searchBar)
        
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
    
    
    // 地図の表示タイプを切り替える
    func setMapType(_ mapType: MKMapType) {
        mapView.mapType = mapType
        
        // ステータスバーのスタイル変更を促す
        self.setNeedsStatusBarAppearanceUpdate();
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
            view.backgroundColor = .white
        }
        else {
            view.backgroundColor = .black
        }
    }

    // ViewControllerに遷移する
    func toGolfView() {
        // ViewControllerを表示する
        self.performSegue(withIdentifier: "toGolfViewFromWalk", sender: nil)
    }
    
    // WalkViewに遷移する
    func toCycleView() {
        // CycleViewControllerを表示する
        self.performSegue(withIdentifier: "toCycleViewFromWalk", sender: nil)
    }
    
    // CycleSettingViewControllerに遷移する
    func toSettingView() {
        // CycleSettingViewControllerを表示する
        self.performSegue(withIdentifier: "toCycleSettingFromWalk", sender: nil)
    }
    
/// 未実装↓
    // 累計データを消去する
    func deleteData() {
        self.userDataManager.deleteWalkData()



    }
    
    // 計測を開始する
    func walkStart() {
        // 計測中にだけバックグラウンドでの位置情報更新を許可する
        locManager.allowsBackgroundLocationUpdates = true
        
        
        
    }
    
    // 計測を再開する
    func walkReStart() {
        // 計測中にだけバックグラウンドでの位置情報更新を許可する
        locManager.allowsBackgroundLocationUpdates = true
        
        
    }
    
    // 計測を中断する
    func walkStop() {
        // 計測中にだけバックグラウンドでの位置情報更新を許可する
        locManager.allowsBackgroundLocationUpdates = false
        
        
    }

    // 計測を終了する
    func walkEnd() {
        // 計測中にだけバックグラウンドでの位置情報更新を許可する
        locManager.allowsBackgroundLocationUpdates = false

        
    }
/// 未実装↑

    
    //==================================================================
    // MKMapViewDelegate
    //==================================================================
    // 読み込み開始
    func mapViewWillStartRenderingMap(_ mapView: MKMapView) {
        print("map load start")
    }
    
    // 読み込み終了時
    func mapViewDidFinishLoadingMap(_ mapView: MKMapView) {
        print("map load ended")
    }

    // ロングタップしてアノテーションを設定した時、アノテーションビューを返すメソッド
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        // 現在位置の点滅がピンにならないように、アノテーションがUserLocationの場合は何もしないようにする。
        if( annotation is MKUserLocation ) {
            return nil
        }
        // ボタンや画像など独自のピンを作成する場合は、下記を有効にして更新する
        return nil
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
            tapStreetAddr = annotation?.title ?? ""
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
            if nil != self.routePolyLine {
                self.mapView.removeOverlay(self.routePolyLine)
                self.routePolyLine = nil
            }
            
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
                            self.tapStreetAddr = "〒\(pm.postalCode ?? "")\n\(pm.administrativeArea ?? "")\(pm.locality ?? "") \n\(pm.name ?? "")"
                            // ピンのタイトルを設定する
                            self.pointAno.title = pm.name
                            
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
    
    // ロングタップした地点のViewをPopup表示する
    func showPointPopupView() {
        // ViewをPopUp表示する
        let storyboard: UIStoryboard = self.storyboard!
        let second = storyboard.instantiateViewController(withIdentifier: "PointPopupViewController")
        // modalPresentationStyleを指定する
        second.modalPresentationStyle = .popover
        self.present(second, animated: true, completion: nil)
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

            // 地図上のオーバーレイを削除
            if nil != self.routePolyLine {
                self.mapView.removeOverlay(self.routePolyLine)
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
    
    // 地点の有無を確認する
    func isExistPoint() -> Bool {
        var retVal: Bool = false
        if (0 != pointAno.coordinate.latitude) && (0 != pointAno.coordinate.longitude) {
            retVal = true
        }
        return retVal
    }
    
    // 地点を削除する
    func deletePoint() {
        // 地図上のオーバーレイを削除
        if nil != routePolyLine {
            mapView.removeOverlay(self.routePolyLine)
            routePolyLine = nil
        }
        mapView.removeAnnotation(pointAno)
        pointAno.coordinate.longitude = 0
        pointAno.coordinate.latitude = 0
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
        
        if 0 < annotationList.count {
            // 前回検索したアノテーションを削除する
            mapView.removeAnnotations(annotationList)
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
                        annotation.subtitle = placemark.placemark.title
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
    }

    
    //==================================================================
    // WatchOSとのデータ通信
    //==================================================================
}

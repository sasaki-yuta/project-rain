//
//  GolfInputScore.swift
//  MapApp
//
//  Created by 佐々木勇太 on 2021/08/13.
//  Copyright © 2021 rain-00-00-09. All rights reserved.
//

import UIKit
import GoogleMobileAds
import MapKit
import FloatingPanel

class GolfInputScore: UIViewController,
                      GADBannerViewDelegate,
                      MKMapViewDelegate,
                      UISearchBarDelegate{

    @IBOutlet weak var btnBack: UIButton!
    // Google AddMod広告
    var bannerView: GADBannerView!
    var defineClass:Define = Define()

    // 地図
    @IBOutlet var mapView: MKMapView!
    // 検索
    @IBOutlet var searchBar: UISearchBar!
    var annotationList = [MapAnnotationCycle]()
    var tapPointTitle: String! = ""                     // 検索した地点のタイトル
    var tapStreetAddr: String! = ""                     // 住所
    var tapRoutePoint = CLLocationCoordinate2D()        // 地点登録用の緯度軽度
    var tapRoutePoint_fix = CLLocationCoordinate2D()    // 地点登録用の緯度軽度(保存用)
    // ボタン 開始
    var startBtn = UIButton(type: UIButton.ButtonType.system)//: UIButton!
    // Popup画面
    var floatingPanelController: FloatingPanelController!
    // ラベル
    @IBOutlet var lbl_1: UILabel!
    @IBOutlet var lbl_2: UILabel!
    @IBOutlet var lbl_3: UILabel!
    @IBOutlet var lbllonlat: UILabel!
    // ラウンド開始日時
    @IBOutlet var roundDate: UIDatePicker!


    // 戻るボタンを押下した時の処理
    @IBAction func btnBackThouchDown(_ sender: Any)
    {
        // ViewControllerを表示する
        self.performSegue(withIdentifier: "toViewController", sender: nil)
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        // MapViewのdelegateを登録する
        mapView.delegate = self
        
        // KeyBordのdelegateを登録する
        searchBar.delegate = self
        
        // Google AddMod広告
        bannerView = GADBannerView(adSize: kGADAdSizeBanner) //320×50
        addBannerViewToView(bannerView)
        bannerView.adUnitID = defineClass.getAddModUnitID()
        bannerView.rootViewController = self
        bannerView.load(GADRequest())
        bannerView.delegate = self
        
        // AppDelegateに追加したviewControllerに自身を設定
        let appDelegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.golfInputScore = self
        
        // モーダルビュー
        floatingPanelController = FloatingPanelController()
        floatingPanelController.delegate = self
        
        // 画面の初期描画
        initView()
    }
    
    // Google AddMod広告
    func addBannerViewToView(_ bannerView: GADBannerView) {
        bannerView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(bannerView)
        view.addConstraints(
        [NSLayoutConstraint(item: bannerView,
                           attribute: .bottom,
                           relatedBy: .equal,
                           toItem: view.safeAreaLayoutGuide,
                           attribute: .bottomMargin,
                           multiplier: 1,
                           constant: -20),
        NSLayoutConstraint(item: bannerView,
                           attribute: .centerX,
                           relatedBy: .equal,
                           toItem: view,
                           attribute: .centerX,
                           multiplier: 1,
                           constant: 0)
        ])
    }

    // 画面の初期描画
    func initView() {
        let dispSize: CGSize = UIScreen.main.bounds.size
        let width = Int(dispSize.width)
        let height = Int(dispSize.height)
        
        // 開始ボタン表示
        startBtn.addTarget(self, action: #selector(btnStart(_:)), for: UIControl.Event.touchUpInside)
        startBtn.setTitle("開始", for: UIControl.State.normal)
        startBtn.frame = CGRect(x:width - 60, y:44, width:30, height:30)
        startBtn.sizeToFit() // サイズを決める(自動調整)
        startBtn.isEnabled = false
        self.view.addSubview(startBtn)

        // 縮尺を設定
        var region:MKCoordinateRegion = mapView.region
        region.span.latitudeDelta = 0.10
        region.span.longitudeDelta = 0.10
        mapView.setRegion(region,animated:true)
        
        // 現在位置表示の有効化
        mapView.showsUserLocation = true
        // 現在位置設定
        mapView.userTrackingMode = .follow

        // 地図のサイズを画面サイズに設定する
        mapView.frame.size = CGSize(width: width, height: height-200) // heightの開始位置分をマイナス
        
        // realmからラウンド中データを取得
        let appDelegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate
        if appDelegate.golfRealmData.isRound() {
            startBtn.isEnabled = true
            startBtn.setTitle("スコア", for: UIControl.State.normal)
            startBtn.sizeToFit() // サイズを決める(自動調整)
            let roundData = appDelegate.golfRealmData.getRoundData()
            searchBar.text = roundData.courseName
            // 地点登録のラベルに緯度軽度を表示する
            tapRoutePoint_fix.longitude = roundData.lon
            tapRoutePoint_fix.latitude = roundData.lat
            let addr = "完了: " + tapRoutePoint_fix.latitude.description + "," + tapRoutePoint_fix.longitude.description
            lbllonlat.text = addr
            // 日時を表示する
            roundDate.date = convertDateToString(roundData.roundDate!)
        }
    }
    
    // 開始 ボタンを押下した時の処理
    @IBAction func btnStart(_ sender: Any)
    {
        // 現在のLocaleの取得
        let locale = Locale.current
        let localeId = locale.identifier
        // ラウンド開始日時
        let dateformatter = DateFormatter()
        dateformatter.dateFormat = "yyyy/MM/dd HH:mm"   // HH:0-23時間表記 hh:0-11時間表記
        dateformatter.locale = Locale(identifier: localeId)
        let strDate = dateformatter.string(from: roundDate.date)
        print(strDate.description)
        
        // スコア入力中？、ラウンド開始日時、ゴルフ場名を保存する
        let appDelegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.golfRealmData.setGolfCource(searchBar.text!.description, strDate, tapRoutePoint_fix.longitude, tapRoutePoint_fix.latitude)
        
        // スコア入力画面表示
        self.performSegue(withIdentifier: "toGolfInputScore2", sender: nil)
    }
    
    // 文字列をDate型に変換する
    func convertDateToString(_ strDate: String) -> Date {
        /// 現在のLocaleの取得
        let locale = Locale.current
        let localeId = locale.identifier
        
        // 文字列をDate型に変換する
        let dateformatter = DateFormatter()
        dateformatter.dateFormat = "yyyy/MM/dd HH:mm"   // HH:0-23時間表記 hh:0-11時間表記
        dateformatter.locale = Locale(identifier: localeId)
        let date = dateformatter.date(from: strDate)!
        return date
    }
    
    //検索ボタンのXでキャンセルした時の呼び出しメソッド
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
            // 開始ボタンを無効化
            startBtn.isEnabled = false
            // 地点画面を消去する
            ExitPointPopupView()

            if 0 < annotationList.count {
                // 前回検索したアノテーションを削除する
                mapView.removeAnnotations(annotationList)
                annotationList.removeAll()
            }

            // 地点登録のラベルにデフォルト文言を設定する
            lbllonlat.text = "地図からゴルフ場を確定してください"
        }
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
        
        // 地点登録のラベルにデフォルト文言を設定する
        //lbllonlat.text = "地図からゴルフ場を確定してください"

        if "" == searchBar.text {
            startBtn.isEnabled = false
            return
        }
        startBtn.isEnabled = true

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
                        annotation.subtitle = "〒\(placemark.placemark.postalCode ?? "")\n\(placemark.placemark.administrativeArea ?? "")\(placemark.placemark.locality ?? "")\n\(placemark.placemark.name ?? "")" //placemark.placemark.title
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
    
    // アノテーションを選択した際に呼ばれるデリゲート
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        let annotation = view.annotation
        // POP UP画面に表示する住所
        tapPointTitle = annotation?.title ?? ""
        tapStreetAddr = annotation?.subtitle ?? ""
        
        // POP UP画面に表示する距離
        let coordinate = CLLocationCoordinate2D(latitude: (annotation?.coordinate.latitude)!, longitude: (annotation?.coordinate.longitude)!)
        // POP UP画面で探索する地点
        tapRoutePoint = coordinate
        
        showPointPopupView()
    }
    
    // タップした地点の名称を取得する
    public func getTapPointTitle() -> String {
        return tapPointTitle
    }
    
    // ロングタップした住所を取得する
    public func getTapStreetAddr() -> String {
        return tapStreetAddr
    }
    
    // PopUp画面表示
    func showPointPopupView() {
        // Google AdMod広告を非表示にする
        bannerView.removeFromSuperview()
        // セミモーダルビューを表示する
        let appearance = SurfaceAppearance()
        appearance.cornerRadius = 24.0  // かどを丸くする
        floatingPanelController.surfaceView.appearance = appearance
        let viewCnt = PointPopupViewController()
        floatingPanelController.set(contentViewController: viewCnt)
        // セミモーダルビューを表示する
        floatingPanelController.addPanel(toParent: self, animated: true)
        floatingPanelController.move(to: .half, animated: true)
    }

    // PopUp画面の消去
    func ExitPointPopupView() {
        // Google AdMod広告を表示する
        addBannerViewToView(bannerView)
        // セミモーダルビューを非表示にする
        floatingPanelController.removePanelFromParent(animated: true)
    }
    
    // セミモーダルビューからゴルフ場を確定した時にゴルフ場名をセットする
    func setGolfCourseName() {
        searchBar.text = tapPointTitle
        
        // 確定時に保存する地点を更新する
        tapRoutePoint_fix.longitude = tapRoutePoint.longitude
        tapRoutePoint_fix.latitude = tapRoutePoint.latitude
        
        // 地点登録のラベルに緯度軽度を表示する
        let addr = "完了: " + tapRoutePoint_fix.latitude.description + "," + tapRoutePoint_fix.longitude.description
        lbllonlat.text = addr
    }
}

// FloatingPanelControllerDelegate を実装してカスタマイズしたレイアウトを返す
extension GolfInputScore : FloatingPanelControllerDelegate {
    // モーダル表示
    func floatingPanel(_ vc: FloatingPanelController, layoutFor newCollection: UITraitCollection) -> FloatingPanelLayout {
        return CustomFloatingPanelLayout()
    }
}

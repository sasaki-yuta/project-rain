//
//  PointPopupViewController.swift
//  MapApp
//
//  Created by yuta sasaki on 2019/12/01.
//  Copyright © 2019 rain-00-00-09. All rights reserved.
//

import UIKit
import FloatingPanel
import WebKit

class PointPopupViewController: UIViewController,WKNavigationDelegate, WKUIDelegate {
    
    var exitBtn: UIButton!
    var routeBtn: UIButton!
    var lblDistance: UILabel!
    var lblTitle: UILabel!
    var lblStreetAddr: UILabel!
    var webView: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // AppDelegateに追加したviewControllerに自身を設定
        let appDelegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.pointPopupViewController = self
        
        initView()
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    // Viewの初期化
    func initView() {
        // Voewのサイズを画面サイズに設定する
        let dispSize: CGSize = UIScreen.main.bounds.size
        let width = Int(dispSize.width)
        let height = Int(dispSize.height)
        
        // exitボタン表示
        exitBtn = UIButton(type: UIButton.ButtonType.system)
        exitBtn.addTarget(self, action: #selector(btnExit(_:)), for: UIControl.Event.touchUpInside)
        exitBtn.frame = CGRect(x:width-40, y:15, width:25, height:25)
        let picture = UIImage(named: "Exit")
        exitBtn.setImage(picture, for: .normal)
        exitBtn.tintColor = .gray
        // サイズを決める(自動調整)
        exitBtn.sizeToFit()
        
        // タイトル表示
        lblTitle = UILabel()
        lblTitle.frame = CGRect(x:20, y:5, width:355, height:40)
        lblTitle.font = UIFont.systemFont(ofSize: 20.0)
        
        // 距離表示
        lblDistance = UILabel()
        lblDistance.frame = CGRect(x:20, y:40, width:355, height:25)
        lblDistance.font = UIFont.systemFont(ofSize: 17.0)
        
        // 住所表示
        lblStreetAddr = UILabel()
        lblStreetAddr.frame = CGRect(x:20, y:65, width:355, height:120)
        lblStreetAddr.font = UIFont.systemFont(ofSize: 17.0)
        lblStreetAddr.numberOfLines = 4
        
        // カスタムの文字色で初期化
        let g = CGFloat(0x94) / 255
        let b = CGFloat(0xFE) / 255
        let strColor: UIColor = UIColor(red: 0, green: g, blue: b, alpha: 1.0)

        // 探索ボタン表示
        routeBtn = UIButton(type: UIButton.ButtonType.system)
        routeBtn.addTarget(self, action: #selector(btnRouteSearch(_:)), for: UIControl.Event.touchUpInside)
        routeBtn.setTitle("経路探索", for: UIControl.State.normal)
        routeBtn.setTitleColor(strColor, for: .normal)
        routeBtn.frame = CGRect(x:20, y:190, width:62, height:30)
        // サイズを決める(自動調整)
        routeBtn.sizeToFit()
        
        // タップした地点の名称を表示する
        let appDelegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate
        if .MODE_CYCLE == appDelegate.nowMapMode {
            lblTitle.text = appDelegate.cycleViewController.getTapPointTitle().description
            lblDistance.text = appDelegate.cycleViewController.getTapDistance().description
            lblStreetAddr.text = "住所 \n" + appDelegate.cycleViewController.getTapStreetAddr().description
        }
        else if .MODE_WALK == appDelegate.nowMapMode {
            lblTitle.text = appDelegate.walkViewController.getTapPointTitle().description
            lblDistance.text = appDelegate.walkViewController.getTapDistance().description
            lblStreetAddr.text = "住所 \n" + appDelegate.walkViewController.getTapStreetAddr().description
        }
        else {
            lblTitle.text = "地点"
            lblDistance.text = "距離 - "
            lblStreetAddr.text = "住所 \n"
        }
        
        // 目的地の場合に経路探索ボタンを非アクティブにする
        let str = lblTitle.text
        let firstStr = String((str?.prefix(4))!)
        if "目的地\n" == firstStr {
            routeBtn.isEnabled = false
            routeBtn.setTitleColor(.gray, for: .normal)
        }
        
        self.view.addSubview(exitBtn)
        self.view.addSubview(routeBtn)
        self.view.addSubview(lblTitle)
        self.view.addSubview(lblDistance)
        self.view.addSubview(lblStreetAddr)

        // ブラウザ表示
        let rect = CGRect(x:0, y:230, width:width, height:height-230)
        let webConfiguration = WKWebViewConfiguration()
        webView = WKWebView(frame: rect, configuration: webConfiguration)

        webView.uiDelegate = self
        webView.navigationDelegate = self
        // スワイプで戻る、進むを有効にする
        webView.allowsBackForwardNavigationGestures = true
        
        var url: String = "https://www.google.co.jp"
        if .MODE_CYCLE == appDelegate.nowMapMode {
            url += "/search?q="
            url += appDelegate.cycleViewController.getTapStreetAddr()
            url += "+"
            url += appDelegate.cycleViewController.getTapPointTitle()
        }
        else if .MODE_WALK == appDelegate.nowMapMode {
            url += "/search?q="
            url += appDelegate.walkViewController.getTapStreetAddr()
            url += "+"
            url += appDelegate.walkViewController.getTapPointTitle()
        }
        else {
        }
        
        // 日本語を含んだ文字列をURLやNSURLにするとnilになる対策
        let encodeUrl: String = url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        let webUrl = URL(string: encodeUrl)
        let myRequest = URLRequest(url: webUrl!)
        webView.load(myRequest)
        // インスタンスをビューに追加する
        self.view.addSubview(webView)
    }
    
    // Closeボタンを押下した時の処理
    @IBAction func btnExit(_ sender: Any)
    {
        let appDelegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate
        if .MODE_CYCLE == appDelegate.nowMapMode {
            appDelegate.cycleViewController.ExitPointPopupView()
        }
        else if .MODE_WALK == appDelegate.nowMapMode {
            appDelegate.walkViewController.ExitPointPopupView()
        }
        else {
            // 処理なし
        }
    }

    // 探索ボタンを押下した時の処理
    @IBAction func btnRouteSearch(_ sender: Any)
    {
        let appDelegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate
        if .MODE_CYCLE == appDelegate.nowMapMode {
            appDelegate.cycleViewController.routeSearch()
        }
        else if .MODE_WALK == appDelegate.nowMapMode {
            appDelegate.walkViewController.routeSearch()
        }
        else {
            // 処理なし
        }
    }
    
    // サイズ変更時の画面際描画
    func resize(_ targetPosition: FloatingPanelPosition) {
        // セミモーダルビューの各表示パターンの高さに応じて表示/非表示を切り替える
        switch targetPosition {
        case .full:
            lblTitle.isHidden = false
            lblDistance.isHidden = false
            lblStreetAddr.isHidden = false
            routeBtn.isHidden = false
        case .half:
            lblTitle.isHidden = false
            lblDistance.isHidden = false
            lblStreetAddr.isHidden = false
            routeBtn.isHidden = false
        case .tip:
            lblTitle.isHidden = false
            lblDistance.isHidden = false
            lblStreetAddr.isHidden = true
            routeBtn.isHidden = true
        default:
            break
        }
    }
    
    func setDistance(_ text: String) {
        lblDistance.text = text
    }
}

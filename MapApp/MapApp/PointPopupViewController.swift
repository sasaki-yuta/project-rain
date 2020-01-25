//
//  PointPopupViewController.swift
//  MapApp
//
//  Created by yuta sasaki on 2019/12/01.
//  Copyright © 2019 rain-00-00-09. All rights reserved.
//

import UIKit
import FloatingPanel

class PointPopupViewController: UIViewController {
    
    var routeBtn: UIButton!
    var lblDistance: UILabel!
    var lblTitle: UILabel!
    var lblStreetAddr: UILabel!
    
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
        // カスタムの文字色で初期化
        let g = CGFloat(0x94) / 255
        let b = CGFloat(0xFE) / 255
        let strColor: UIColor = UIColor(red: 0, green: g, blue: b, alpha: 1.0)
        
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
        
        self.view.addSubview(routeBtn)
        self.view.addSubview(lblTitle)
        self.view.addSubview(lblDistance)
        self.view.addSubview(lblStreetAddr)
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
}

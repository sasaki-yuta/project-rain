//
//  MenuCycleViewController.swift
//  MapApp
//
//  Created by yuta sasaki on 2019/08/11.
//  Copyright © 2019 rain-00-00-09. All rights reserved.
//

import UIKit
import MapKit

class MenuCycleViewController: UIViewController {

    @IBOutlet weak var menuView:UIView!

    @IBOutlet weak var lblMapType: UILabel!
    @IBOutlet weak var btnStandard: UIButton!
    @IBOutlet weak var btnSatellite: UIButton!
    @IBOutlet weak var btnHybrid: UIButton!
    @IBOutlet weak var btnMutedStandard: UIButton!

    @IBOutlet weak var lblMapMode: UILabel!
    @IBOutlet weak var btnGolfMode: UIButton!
    @IBOutlet weak var btnCycleMode: UIButton!

    @IBOutlet weak var lblFunk: UILabel!
    @IBOutlet weak var btnStart: UIButton!
    @IBOutlet weak var btnStop: UIButton!
    @IBOutlet weak var btnEnd: UIButton!
    @IBOutlet weak var btnDelete: UIButton!


    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.

        // AppDelegateに追加したMenuViewControllerに自身を設定
        let appDelegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.menuCycleViewController = self
        
        updateBtn();
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
        
        // Voewのサイズを画面サイズに設定する
        let dispSize: CGSize = UIScreen.main.bounds.size
        //        let width = Int(dispSize.width)
        let height = Int(dispSize.height)
        menuView.frame.size = CGSize(width: 150, height: height)
        
        // メニューの位置を取得する
        let menuPos = self.menuView.layer.position
        // 初期位置を画面の外側にするため、メニューの幅の分だけマイナスする
        self.menuView.layer.position.x = -self.menuView.frame.width
        // 表示時のアニメーションを作成する
        UIView.animate(
            withDuration: 0.5,
            delay: 0,
            options: .curveEaseOut,
            animations: {self.menuView.layer.position.x = menuPos.x},
            completion: {bool in}
        )
        
        // ボタンのアニメーション
        let btnStaPos = btnStandard.layer.position
        btnStandard.layer.position.x = -self.menuView.frame.width
        UIView.animate(
            withDuration: 0.5,
            delay: 0,
            options: .curveEaseOut,
            animations: {self.btnStandard.layer.position.x = btnStaPos.x},
            completion: {bool in}
        )
        
        let btnSatePos = btnSatellite.layer.position
        btnSatellite.layer.position.x = -self.menuView.frame.width
        UIView.animate(
            withDuration: 0.5,
            delay: 0,
            options: .curveEaseOut,
            animations: {self.btnSatellite.layer.position.x = btnSatePos.x},
            completion: {bool in}
        )
        
        let btnHyPos = btnHybrid.layer.position
        btnHybrid.layer.position.x = -self.menuView.frame.width
        UIView.animate(
            withDuration: 0.5,
            delay: 0,
            options: .curveEaseOut,
            animations: {self.btnHybrid.layer.position.x = btnHyPos.x},
            completion: {bool in}
        )
        
        let btnMutePos = btnMutedStandard.layer.position
        btnMutedStandard.layer.position.x = -self.menuView.frame.width
        UIView.animate(
            withDuration: 0.5,
            delay: 0,
            options: .curveEaseOut,
            animations: {self.btnMutedStandard.layer.position.x = btnMutePos.x},
            completion: {bool in}
        )

        let btnGolfModePos = btnGolfMode.layer.position
        btnGolfMode.layer.position.x = -self.menuView.frame.width
        UIView.animate(
            withDuration: 0.5,
            delay: 0,
            options: .curveEaseOut,
            animations: {self.btnGolfMode.layer.position.x = btnGolfModePos.x},
            completion: {bool in}
        )
        
        let btnCycleModePos = btnCycleMode.layer.position
        btnCycleMode.layer.position.x = -self.menuView.frame.width
        UIView.animate(
            withDuration: 0.5,
            delay: 0,
            options: .curveEaseOut,
            animations: {self.btnCycleMode.layer.position.x = btnCycleModePos.x},
            completion: {bool in}
        )
        
        let btnStartPos = btnStart.layer.position
        btnStart.layer.position.x = -self.menuView.frame.width
        UIView.animate(
            withDuration: 0.5,
            delay: 0,
            options: .curveEaseOut,
            animations: {self.btnStart.layer.position.x = btnStartPos.x},
            completion: {bool in}
        )
        
        let btnStopPos = btnStop.layer.position
        btnStop.layer.position.x = -self.menuView.frame.width
        UIView.animate(
            withDuration: 0.5,
            delay: 0,
            options: .curveEaseOut,
            animations: {self.btnStop.layer.position.x = btnStopPos.x},
            completion: {bool in}
        )
        
        let btnEndPos = btnEnd.layer.position
        btnEnd.layer.position.x = -self.menuView.frame.width
        UIView.animate(
            withDuration: 0.5,
            delay: 0,
            options: .curveEaseOut,
            animations: {self.btnEnd.layer.position.x = btnEndPos.x},
            completion: {bool in}
        )

        let btnDelPos = btnDelete.layer.position
        btnDelete.layer.position.x = -self.menuView.frame.width
        UIView.animate(
            withDuration: 0.5,
            delay: 0,
            options: .curveEaseOut,
            animations: {self.btnDelete.layer.position.x = btnDelPos.x},
            completion: {bool in}
        )

    }
    
    // メニューエリア以外タップ時の処理
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        for touch in touches {
            if touch.view?.tag == 1 {
                // View、ボタンのアニメーション
                UIView.animate(
                    withDuration: 0.2,
                    delay: 0,
                    options: .curveEaseIn,
                    animations: {
                        self.menuView.layer.position.x = -self.menuView.frame.width
                        self.btnStandard.layer.position.x = -self.menuView.frame.width
                        self.btnSatellite.layer.position.x = -self.menuView.frame.width
                        self.btnHybrid.layer.position.x = -self.menuView.frame.width
                        self.btnMutedStandard.layer.position.x = -self.menuView.frame.width
                        self.btnGolfMode.layer.position.x = -self.menuView.frame.width
                        self.btnCycleMode.layer.position.x = -self.menuView.frame.width
                        self.btnStart.layer.position.x = -self.menuView.frame.width
                        self.btnStop.layer.position.x = -self.menuView.frame.width
                        self.btnEnd.layer.position.x = -self.menuView.frame.width
                        self.btnDelete.layer.position.x = -self.menuView.frame.width
                    },
                    completion: {
                        bool in
                        self.dismiss(animated: true, completion: nil)
                    }
                )
            }
        }
    }
    // 地図の表示タイプを切り替える（標準）
    @IBAction func btnStandardThouchDown(_ sender: Any) {
        print("btnSatelliteBtnThouchDown")
        
        let appDelegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.cycleViewController.setMapType(.standard)
        
        // メニューの背景色とタイトルの文字色を地図Typeに合わせて変える
        menuView.backgroundColor = .white
        lblMapType.textColor = .black
        lblMapMode.textColor = .black
        lblFunk.textColor = .black
        
        updateBtn()
    }
    
    // 地図の表示タイプを切り替える（航空写真）
    @IBAction func btnSatelliteThouchDown(_ sender: Any) {
        print("btnSatelliteBtnThouchDown")
        
        let appDelegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.cycleViewController.setMapType(.satellite)
        
        // メニューの背景色とタイトルの文字色を地図Typeに合わせて変える
        menuView.backgroundColor = .black
        lblMapType.textColor = .white
        lblMapMode.textColor = .white
        lblFunk.textColor = .white
        
        updateBtn()
    }
    
    // 地図の表示タイプを切り替える（標準＋航空）
    @IBAction func btnHybridThouchDown(_ sender: Any) {
        print("btnSatelliteBtnThouchDown")
        
        let appDelegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.cycleViewController.setMapType(.hybrid)
        
        // メニューの背景色とタイトルの文字色を地図Typeに合わせて変える
        menuView.backgroundColor = .black
        lblMapType.textColor = .white
        lblMapMode.textColor = .white
        lblFunk.textColor = .white
        
        updateBtn()
    }
    
    // 地図の表示タイプを切り替える（データ強調）
    @IBAction func btnMutedStandardThouchDown(_ sender: Any) {
        print("btnSatelliteBtnThouchDown")
        
        let appDelegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.cycleViewController.setMapType(.mutedStandard)
        
        // メニューの背景色とタイトルの文字色を地図Typeに合わせて変える
        menuView.backgroundColor = .white
        lblMapType.textColor = .black
        lblMapMode.textColor = .black
        lblFunk.textColor = .black
        
        updateBtn()
    }

    // MapMode（ゴルフ）を押下した時の処理
    @IBAction func btnGolfModeThouchDown(_ sender: Any) {
        // Menu画面の消去
        self.dismiss(animated: true, completion: nil)
        // MapModeを更新して、viewController画面を消去
        let appDelegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.nowMapMode = .MODE_GOLF
        appDelegate.cycleViewController.toCycleView()
    }
    
    // MapMode（サイクル）を押下した時の処理
    @IBAction func btnCycleModeThouchDown(_ sender: Any) {
        // CycleModeのメニューなので押せない
    }
    
    // 計測開始を押下した時の処理
    @IBAction func btnCycleStartThouchDown(_ sender: Any) {
        // 計測状態を更新する
        let appDelegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.nowCycleState = .STATE_STARTING
        // ボタン状態の更新
        updateBtn()

    }
    
    // 計測中断を押下した時の処理
    @IBAction func btnCycleStopThouchDown(_ sender: Any) {
        // 計測状態を更新する
        let appDelegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.nowCycleState = .STATE_SUSPENDED
        // ボタン状態の更新
        updateBtn()

    }
    
    // 計測終了を押下した時の処理
    @IBAction func btnCycleEndThouchDown(_ sender: Any) {
        // 計測状態を更新する
        let appDelegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.nowCycleState = .STATE_CLOSING
        // ボタン状態の更新
        updateBtn()

    }
    
    // データ消去を押下した時の処理
    @IBAction func btnCycleDeleteThouchDown(_ sender: Any) {
        
    }
    
    // 地図タイプボタンのアクティブ状態を更新
    func updateBtn() {
        // カスタムの文字色で初期化
        let g = CGFloat(0x94) / 255
        let b = CGFloat(0xFE) / 255
        let strColor: UIColor = UIColor(red: 0, green: g, blue: b, alpha: 1.0)

        // MapType
        btnStandard.setTitleColor(strColor, for: .normal)
        btnStandard.isEnabled = true
        btnSatellite.setTitleColor(strColor, for: .normal)
        btnSatellite.isEnabled = true
        btnHybrid.setTitleColor(strColor, for: .normal)
        btnHybrid.isEnabled = true
        btnMutedStandard.setTitleColor(strColor, for: .normal)
        btnMutedStandard.isEnabled = true
        // MapMode
        btnGolfMode.setTitleColor(strColor, for: .normal)
        btnGolfMode.isEnabled = true
        btnCycleMode.setTitleColor(strColor, for: .normal)
        btnCycleMode.isEnabled = true
        // Func
        btnStart.setTitleColor(strColor, for: .normal)
        btnStart.isEnabled = true
        btnStop.setTitleColor(strColor, for: .normal)
        btnStop.isEnabled = true
        btnEnd.setTitleColor(strColor, for: .normal)
        btnEnd.isEnabled = true
        btnDelete.setTitleColor(strColor, for: .normal)
        btnDelete.isEnabled = true

        let appDelegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate
        
        // 選択されているMapTypeボタンの状態を変更する
        switch appDelegate.cycleViewController.mapView.mapType {
        case .standard:
            btnStandard.setTitleColor(UIColor.gray, for: .normal)
            btnStandard.isEnabled = false
            // メニューの背景色とタイトルの文字色を地図Typeに合わせて変える
            menuView.backgroundColor = .white
            lblMapType.textColor = .black
            lblMapMode.textColor = .black
            lblFunk.textColor = .black
        case .satellite:
            btnSatellite.setTitleColor(UIColor.gray, for: .normal)
            btnSatellite.isEnabled = false
            // メニューの背景色とタイトルの文字色を地図Typeに合わせて変える
            menuView.backgroundColor = .black
            lblMapType.textColor = .white
            lblMapMode.textColor = .white
            lblFunk.textColor = .white
        case .hybrid:
            btnHybrid.setTitleColor(UIColor.gray, for: .normal)
            btnHybrid.isEnabled = false
            // メニューの背景色とタイトルの文字色を地図Typeに合わせて変える
            menuView.backgroundColor = .black
            lblMapType.textColor = .white
            lblMapMode.textColor = .white
            lblFunk.textColor = .white
        case .mutedStandard:
            btnMutedStandard.setTitleColor(UIColor.gray, for: .normal)
            btnMutedStandard.isEnabled = false
            // メニューの背景色とタイトルの文字色を地図Typeに合わせて変える
            menuView.backgroundColor = .white
            lblMapType.textColor = .black
            lblMapMode.textColor = .black
            lblFunk.textColor = .black
        default:
            break
        }
        
        // 選択されているMapTypeボタンの状態を変更する
        switch appDelegate.nowMapMode {
        case .MODE_GOLF?:
            btnGolfMode.setTitleColor(UIColor.gray, for: .normal)
            btnGolfMode.isEnabled = false
        case .MODE_CYCLE?:
            btnCycleMode.setTitleColor(UIColor.gray, for: .normal)
            btnCycleMode.isEnabled = false
        case .none:
            break
        }
        
        // 計測状態によりFuncボタンの状態を変更する
        switch appDelegate.nowCycleState {
        case .STATE_CLOSING?:
            btnEnd.setTitleColor(UIColor.gray, for: .normal)
            btnEnd.isEnabled = false
        case .STATE_STARTING?:
            btnStart.setTitleColor(UIColor.gray, for: .normal)
            btnStart.isEnabled = false
        case .STATE_SUSPENDED?:
            btnStop.setTitleColor(UIColor.gray, for: .normal)
            btnStop.isEnabled = false
        default:
            break
        }

        // MapType
        self.view.addSubview(btnStandard)
        self.view.addSubview(btnSatellite)
        self.view.addSubview(btnHybrid)
        self.view.addSubview(btnMutedStandard)
        // MapMode
        self.view.addSubview(btnGolfMode)
        self.view.addSubview(btnCycleMode)
        // Func
        self.view.addSubview(btnStart)
        self.view.addSubview(btnStop)
        self.view.addSubview(btnEnd)
        self.view.addSubview(btnDelete)
    }
}


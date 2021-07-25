//
//  MenuWalkViewController.swift
//  MapApp
//
//  Created by yuta sasaki on 2019/12/29.
//  Copyright © 2019 rain-00-00-09. All rights reserved.
//

import UIKit

class MenuWalkViewController: UIViewController {
    
    @IBOutlet weak var menuView:UIView!

    @IBOutlet weak var lblMapType: UILabel!
    @IBOutlet weak var btnStandard: UIButton!
    @IBOutlet weak var btnSatellite: UIButton!
    @IBOutlet weak var btnHybrid: UIButton!
    @IBOutlet weak var btnMutedStandard: UIButton!

    @IBOutlet weak var lblMapMode: UILabel!
    @IBOutlet weak var btnGolfMode: UIButton!
    @IBOutlet weak var btnCycleMode: UIButton!
    @IBOutlet weak var btnWalkMode: UIButton!

    @IBOutlet weak var lblFunk: UILabel!
    @IBOutlet weak var btnDelPnt: UIButton!
    @IBOutlet weak var btnSetting: UIButton!
    @IBOutlet weak var btnStart: UIButton!
    @IBOutlet weak var btnStop: UIButton!
    @IBOutlet weak var btnEnd: UIButton!

    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        // AppDelegateに追加したMenuViewControllerに自身を設定
        let appDelegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.menuWalkViewController = self
        
        updateBtn();
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
        btnWalkMode.setTitleColor(strColor, for: .normal)
        btnWalkMode.isEnabled = true
        // Func
        btnDelPnt.setTitleColor(strColor, for: .normal)
        btnDelPnt.isEnabled = true
        btnSetting.setTitleColor(strColor, for: .normal)
        btnSetting.isEnabled = true
        btnStart.setTitleColor(strColor, for: .normal)
        btnStart.isEnabled = true
        btnStop.setTitleColor(strColor, for: .normal)
        btnStop.isEnabled = true
        btnEnd.setTitleColor(strColor, for: .normal)
        btnEnd.isEnabled = true

        let appDelegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate
        
        // 選択されているMapTypeボタンの状態を変更する
        switch appDelegate.walkViewController.mapView.mapType {
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
        case .MODE_WALK?:
            btnWalkMode.setTitleColor(UIColor.gray, for: .normal)
            btnWalkMode.isEnabled = false
        case .none:
            break
        }
        
        // 計測状態によりFuncボタンの状態を変更する
        switch appDelegate.nowWalkState {
        case .STATE_CLOSING?:
            btnEnd.setTitleColor(UIColor.gray, for: .normal)
            btnEnd.isEnabled = false
            btnStop.setTitleColor(UIColor.gray, for: .normal)
            btnStop.isEnabled = false
        case .STATE_STARTING?:
            btnGolfMode.setTitleColor(UIColor.gray, for: .normal)
            btnGolfMode.isEnabled = false
            btnCycleMode.setTitleColor(UIColor.gray, for: .normal)
            btnCycleMode.isEnabled = false
            btnStart.setTitleColor(UIColor.gray, for: .normal)
            btnStart.isEnabled = false
            btnSetting.setTitleColor(UIColor.gray, for: .normal)
            btnSetting.isEnabled = false
        case .STATE_SUSPENDED?:
            btnStop.setTitleColor(UIColor.gray, for: .normal)
            btnStop.isEnabled = false
        default:
            break
        }
        
        if !appDelegate.walkViewController.isExistPoint() {
            btnDelPnt.setTitleColor(UIColor.gray, for: .normal)
            btnDelPnt.isEnabled = false
        }

        // MapType
        self.view.addSubview(btnStandard)
        self.view.addSubview(btnSatellite)
        self.view.addSubview(btnHybrid)
        self.view.addSubview(btnMutedStandard)
        // MapMode
        self.view.addSubview(btnGolfMode)
        self.view.addSubview(btnCycleMode)
        self.view.addSubview(btnWalkMode)
        // Func
        self.view.addSubview(btnDelPnt)
        self.view.addSubview(btnSetting)
        self.view.addSubview(btnStart)
        self.view.addSubview(btnStop)
        self.view.addSubview(btnEnd)
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
        
        // adMobClose
        let appDelegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.walkViewController.adMobClose()
        
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
        let lblMapTypePos = lblMapType.layer.position
        lblMapType.layer.position.x = -self.menuView.frame.width
        UIView.animate(
            withDuration: 0.5,
            delay: 0,
            options: .curveEaseOut,
            animations: {self.lblMapType.layer.position.x = lblMapTypePos.x},
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

        let lblMapModePos = lblMapMode.layer.position
        lblMapMode.layer.position.x = -self.menuView.frame.width
        UIView.animate(
            withDuration: 0.5,
            delay: 0,
            options: .curveEaseOut,
            animations: {self.lblMapMode.layer.position.x = lblMapModePos.x},
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
        
        let btnWalkModePos = btnWalkMode.layer.position
        btnWalkMode.layer.position.x = -self.menuView.frame.width
        UIView.animate(
            withDuration: 0.5,
            delay: 0,
            options: .curveEaseOut,
            animations: {self.btnWalkMode.layer.position.x = btnWalkModePos.x},
            completion: {bool in}
        )
        
        let lblFunkPos = lblFunk.layer.position
        lblFunk.layer.position.x = -self.menuView.frame.width
        UIView.animate(
            withDuration: 0.5,
            delay: 0,
            options: .curveEaseOut,
            animations: {self.lblFunk.layer.position.x = lblFunkPos.x},
            completion: {bool in}
        )
        
        let btnDelPst = btnDelPnt.layer.position
        btnDelPnt.layer.position.x = -self.menuView.frame.width
        UIView.animate(
            withDuration: 0.5,
            delay: 0,
            options: .curveEaseOut,
            animations: {self.btnDelPnt.layer.position.x = btnDelPst.x},
            completion: {bool in}
        )
        
        let btnSettingPst = btnSetting.layer.position
        btnSetting.layer.position.x = -self.menuView.frame.width
        UIView.animate(
            withDuration: 0.5,
            delay: 0,
            options: .curveEaseOut,
            animations: {self.btnSetting.layer.position.x = btnSettingPst.x},
            completion: {bool in}
        )
        
        let btnStartPst = btnStart.layer.position
        btnStart.layer.position.x = -self.menuView.frame.width
        UIView.animate(
            withDuration: 0.5,
            delay: 0,
            options: .curveEaseOut,
            animations: {self.btnStart.layer.position.x = btnStartPst.x},
            completion: {bool in}
        )
        
        let btnStopPst = btnStop.layer.position
        btnStop.layer.position.x = -self.menuView.frame.width
        UIView.animate(
            withDuration: 0.5,
            delay: 0,
            options: .curveEaseOut,
            animations: {self.btnStop.layer.position.x = btnStopPst.x},
            completion: {bool in}
        )
        
        let btnEndPst = btnEnd.layer.position
        btnEnd.layer.position.x = -self.menuView.frame.width
        UIView.animate(
            withDuration: 0.5,
            delay: 0,
            options: .curveEaseOut,
            animations: {self.btnEnd.layer.position.x = btnEndPst.x},
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
                        self.lblMapType.layer.position.x = -self.menuView.frame.width
                        self.btnStandard.layer.position.x = -self.menuView.frame.width
                        self.btnSatellite.layer.position.x = -self.menuView.frame.width
                        self.btnHybrid.layer.position.x = -self.menuView.frame.width
                        self.btnMutedStandard.layer.position.x = -self.menuView.frame.width
                        self.lblMapMode.layer.position.x = -self.menuView.frame.width
                        self.btnGolfMode.layer.position.x = -self.menuView.frame.width
                        self.btnCycleMode.layer.position.x = -self.menuView.frame.width
                        self.btnWalkMode.layer.position.x = -self.menuView.frame.width
                        self.lblFunk.layer.position.x = -self.menuView.frame.width
                        self.btnDelPnt.layer.position.x = -self.menuView.frame.width
                        self.btnSetting.layer.position.x = -self.menuView.frame.width
                        self.btnStart.layer.position.x = -self.menuView.frame.width
                        self.btnStop.layer.position.x = -self.menuView.frame.width
                        self.btnEnd.layer.position.x = -self.menuView.frame.width
                    },
                    completion: {
                        bool in
                        self.dismiss(animated: true, completion: nil)
                    }
                )

                // adMob表示
                let appDelegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate
                appDelegate.walkViewController.adMobView()
            }
        }
    }

    // 地図の表示タイプを切り替える（標準）
    @IBAction func btnStandardThouchDown(_ sender: Any) {
        print("btnSatelliteBtnThouchDown")
        
        let appDelegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.walkViewController.setMapType(.standard)
        appDelegate.walkViewController.changeMapType()
        // 地図TypeをUserDataに保存する
        appDelegate.userDataManager.saveWalkMapType(.standard)

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
        appDelegate.walkViewController.setMapType(.satellite)
        appDelegate.walkViewController.changeMapType()
        // 地図TypeをUserDataに保存する
        appDelegate.userDataManager.saveWalkMapType(.satellite)

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
        appDelegate.walkViewController.setMapType(.hybrid)
        appDelegate.walkViewController.changeMapType()
        // 地図TypeをUserDataに保存する
        appDelegate.userDataManager.saveWalkMapType(.hybrid)
        
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
        appDelegate.walkViewController.setMapType(.mutedStandard)
        appDelegate.walkViewController.changeMapType()
        // 地図TypeをUserDataに保存する
        appDelegate.userDataManager.saveWalkMapType(.mutedStandard)
        
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
        appDelegate.walkViewController.toGolfView()
    }
    
    // MapMode（サイクル）を押下した時の処理
    @IBAction func btnCycleModeThouchDown(_ sender: Any) {
        // Menu画面の消去
        self.dismiss(animated: true, completion: nil)
        // MapModeを更新して、viewController画面を消去
        let appDelegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.nowMapMode = .MODE_CYCLE
        appDelegate.walkViewController.toCycleView()
    }
    
    // MapMode（ウォーク）を押下した時の処理
    @IBAction func btnWalkModeThouchDown(_ sender: Any) {
        // WalkModeのメニューなので押せない
    }
    
    // 地点削除を押下した時の処理
    @IBAction func btnDelPointThouchDown(_ sender: Any) {
        let appDelegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.walkViewController.deletePoint()
        // ボタン状態の更新
        updateBtn()
    }
    
    // MenuCycleViewControllerに遷移する
    @IBAction func btnSettingThouchDown(_ sender: Any) {
        // Menu画面の消去
        self.dismiss(animated: true, completion: nil)
        // Setting画面を表示
        let appDelegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.walkViewController.toSettingView()
    }

    // 計測開始を押下した時の処理
    @IBAction func btnStartThouchDown(_ sender: Any) {
        let appDelegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate

        if .STATE_SUSPENDED == appDelegate.nowWalkState {
            // 計測再開
            appDelegate.walkViewController.walkReStart()
        }
        else {
            // 計測開始
            appDelegate.walkViewController.walkStart()
        }

        // 計測状態を更新する
        appDelegate.nowWalkState = .STATE_STARTING
        // ボタン状態の更新
        updateBtn()
    }

    // 計測中断を押下した時の処理
    @IBAction func btnStopThouchDown(_ sender: Any) {
        // 計測状態を更新する
        let appDelegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.nowWalkState = .STATE_SUSPENDED
        // ボタン状態の更新
        updateBtn()

        // 計測を中断する
        appDelegate.walkViewController.walkStop()
    }
    
    // 計測終了を押下した時の処理
    @IBAction func btnEndThouchDown(_ sender: Any) {
        // 計測状態を更新する
        let appDelegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.nowWalkState = .STATE_CLOSING
        // ボタン状態の更新
        updateBtn()

        // 計測を終了する
        appDelegate.walkViewController.walkEnd()
    }
}

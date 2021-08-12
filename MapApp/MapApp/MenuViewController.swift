//
//  MenuViewController.swift
//  MapApp
//
//  Created by yuta sasaki on 2019/03/22.
//  Copyright © 2019 rain-00-00-09. All rights reserved.
//

import UIKit
import MapKit

class MenuViewController: UIViewController {

    @IBOutlet weak var menuView:UIView!
    @IBOutlet weak var btnStandard: UIButton!
    @IBOutlet weak var btnSatellite: UIButton!
    @IBOutlet weak var btnHybrid: UIButton!
    @IBOutlet weak var btnMutedStandard: UIButton!
    @IBOutlet weak var btnDelTapPoint: UIButton!
    @IBOutlet weak var btnGetElevation: UIButton!
    @IBOutlet weak var btnGolfMode: UIButton!
    @IBOutlet weak var btnCycleMode: UIButton!
    @IBOutlet weak var btnWalkMode: UIButton!
    @IBOutlet weak var btnMngScore: UIButton!
    @IBOutlet weak var btnInputScore: UIButton!
    @IBOutlet weak var lblMapType: UILabel!
    @IBOutlet weak var lblMapMode: UILabel!
    @IBOutlet weak var lblFunk: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        // AppDelegateに追加したMenuViewControllerに自身を設定
        let appDelegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.menuViewController = self
        
        updateBtn()
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
        appDelegate.viewController.adMobClose()
        
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
        
        let btnDelTapPointPos = btnDelTapPoint.layer.position
        btnDelTapPoint.layer.position.x = -self.menuView.frame.width
        UIView.animate(
            withDuration: 0.5,
            delay: 0,
            options: .curveEaseOut,
            animations: {self.btnDelTapPoint.layer.position.x = btnDelTapPointPos.x},
            completion: {bool in}
        )
        
        let btnGetElevationPos = btnGetElevation.layer.position
        btnGetElevation.layer.position.x = -self.menuView.frame.width
        UIView.animate(
            withDuration: 0.5,
            delay: 0,
            options: .curveEaseOut,
            animations: {self.btnGetElevation.layer.position.x = btnGetElevationPos.x},
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
        
        let btnMngScorePos = btnMngScore.layer.position
        btnMngScore.layer.position.x = -self.menuView.frame.width
        UIView.animate(
            withDuration: 0.5,
            delay: 0,
            options: .curveEaseOut,
            animations: {self.btnMngScore.layer.position.x = btnMngScorePos.x},
            completion: {bool in}
        )
        
        let btnInputScorePos = btnInputScore.layer.position
        btnInputScore.layer.position.x = -self.menuView.frame.width
        UIView.animate(
            withDuration: 0.5,
            delay: 0,
            options: .curveEaseOut,
            animations: {self.btnInputScore.layer.position.x = btnInputScorePos.x},
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
                        self.btnDelTapPoint.layer.position.x = -self.menuView.frame.width
                        self.btnGetElevation.layer.position.x = -self.menuView.frame.width
                        self.btnGolfMode.layer.position.x = -self.menuView.frame.width
                        self.btnCycleMode.layer.position.x = -self.menuView.frame.width
                        self.btnWalkMode.layer.position.x = -self.menuView.frame.width
                        self.btnMngScore.layer.position.x = -self.menuView.frame.width
                        self.btnInputScore.layer.position.x = -self.menuView.frame.width
                    },
                    completion: { bool in
                        self.dismiss(animated: true, completion: nil)
                    }
                )

                // adMob表示
                let appDelegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate
                appDelegate.viewController.adMobView()
            }
        }
    }

    // 地図の表示タイプを切り替える（標準）
    @IBAction func btnStandardThouchDown(_ sender: Any) {
        print("btnSatelliteBtnThouchDown")
        
        let appDelegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.viewController.setMapType(.standard)
        // 地図TypeをUserDataに保存する
        appDelegate.userDataManager.saveGolfMapType(.standard)

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
        appDelegate.viewController.setMapType(.satellite)
        // 地図TypeをUserDataに保存する
        appDelegate.userDataManager.saveGolfMapType(.satellite)

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
        appDelegate.viewController.setMapType(.hybrid)
        // 地図TypeをUserDataに保存する
        appDelegate.userDataManager.saveGolfMapType(.hybrid)
        
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
        appDelegate.viewController.setMapType(.mutedStandard)
        // 地図TypeをUserDataに保存する
        appDelegate.userDataManager.saveGolfMapType(.mutedStandard)

        // メニューの背景色とタイトルの文字色を地図Typeに合わせて変える
        menuView.backgroundColor = .white
        lblMapType.textColor = .black
        lblMapMode.textColor = .black
        lblFunk.textColor = .black

        updateBtn()
    }
    
    // ロングタップした地点を削除する
    @IBAction func btnDelTapPointThouchDown(_ sender: Any) {
        print("btnDelTapPointThouchDown")

        let appDelegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.viewController.delLongTapPoint()
        
        updateBtn()
    }
    
    // ロングタップした地点との標高差を取得する
    @IBAction func btnGetElevationThouchDown(_ sender: Any) {
        print("btnGetElevationThouchDown")
        
        let appDelegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.viewController.showElevation()
    }
    
    // MapMode（ゴルフ）を押下した時の処理
    @IBAction func btnGolfModeThouchDown(_ sender: Any) {
        // GolfModeのメニューなので押せない
    }
    
    // MapMode（サイクル）を押下した時の処理
    @IBAction func btnCycleModeThouchDown(_ sender: Any) {
        // Menu画面の消去
        self.dismiss(animated: true, completion: nil)
        // MapModeを更新して、viewController画面を消去
        let appDelegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.nowMapMode = .MODE_CYCLE
        appDelegate.viewController.toCycleView()
    }
    
    // MapMode（ウォーク）を押下した時の処理
    @IBAction func btnWalkModeThouchDown(_ sender: Any) {
        // Menu画面の消去
        self.dismiss(animated: true, completion: nil)
        // MapModeを更新して、viewController画面を消去
        let appDelegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.nowMapMode = .MODE_WALK
        appDelegate.viewController.toWalkView()
    }
    
    // ゴルフスコア分析に遷移する
    @IBAction func btnScoreManageThouchDown(_ sender: Any) {
        // Menu画面の消去
        self.dismiss(animated: true, completion: nil)
        // MenuCycleViewController画面を消去
        let appDelegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.viewController.toGolfManageScoreViewController()
    }
    
    // ゴルフスコア分析に遷移する
    @IBAction func btnInputScoreThouchDown(_ sender: Any) {
        // Menu画面の消去
        self.dismiss(animated: true, completion: nil)
        // MenuCycleViewController画面を消去
        let appDelegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.viewController.toGolfInputScoreViewController()
    }
    
    // 地図タイプボタンのアクティブ状態を更新
    func updateBtn() {
        // カスタムの文字色で初期化
        let g = CGFloat(0x94) / 255
        let b = CGFloat(0xFE) / 255
        let strColor: UIColor = UIColor(red: 0, green: g, blue: b, alpha: 1.0)

        btnStandard.setTitleColor(strColor, for: .normal)
        btnStandard.isEnabled = true
        btnSatellite.setTitleColor(strColor, for: .normal)
        btnSatellite.isEnabled = true
        btnHybrid.setTitleColor(strColor, for: .normal)
        btnHybrid.isEnabled = true
        btnMutedStandard.setTitleColor(strColor, for: .normal)
        btnMutedStandard.isEnabled = true
        btnDelTapPoint.setTitleColor(strColor, for: .normal)
        btnDelTapPoint.isEnabled = true
        btnGetElevation.setTitleColor(strColor, for: .normal)
        btnGetElevation.isEnabled = true
        btnGolfMode.setTitleColor(strColor, for: .normal)
        btnGolfMode.isEnabled = true
        btnCycleMode.setTitleColor(strColor, for: .normal)
        btnCycleMode.isEnabled = true
        btnWalkMode.setTitleColor(strColor, for: .normal)
        btnWalkMode.isEnabled = true
        btnMngScore.setTitleColor(strColor, for: .normal)
        btnMngScore.isEnabled = true
        btnInputScore.setTitleColor(strColor, for: .normal)
        btnInputScore.isEnabled = true

        let appDelegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate

        // 選択されているMapTypeボタンの文字をグレーにする
        switch appDelegate.viewController.mapView.mapType {
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
        
        // 選択されているMapTypeボタンの文字をグレーにする
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
        
        // ロングタップした地点がなければ文字をグレーにする
        if false == appDelegate.viewController.isExistLongTapPoint() {
            btnDelTapPoint.setTitleColor(UIColor.gray, for: .normal)
            btnDelTapPoint.isEnabled = false
            btnGetElevation.setTitleColor(UIColor.gray, for: .normal)
            btnGetElevation.isEnabled = false
        }
        
        // ボタンの再描画
        self.view.addSubview(btnStandard)
        self.view.addSubview(btnSatellite)
        self.view.addSubview(btnHybrid)
        self.view.addSubview(btnMutedStandard)
        self.view.addSubview(btnDelTapPoint)
        self.view.addSubview(btnGetElevation)
        self.view.addSubview(btnGolfMode)
        self.view.addSubview(btnCycleMode)
        self.view.addSubview(btnWalkMode)
        self.view.addSubview(btnMngScore)
        self.view.addSubview(btnInputScore)
    }
}

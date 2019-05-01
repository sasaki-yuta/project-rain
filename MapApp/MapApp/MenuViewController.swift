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
    @IBOutlet weak var btnModeGolf: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
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
        
        let btnModeGolfPos = btnModeGolf.layer.position
        btnModeGolf.layer.position.x = -self.menuView.frame.width
        UIView.animate(
            withDuration: 0.5,
            delay: 0,
            options: .curveEaseOut,
            animations: {self.btnModeGolf.layer.position.x = btnModeGolfPos.x},
            completion: {bool in}
        )

    }
    
    // メニューエリア以外タップ時の処理
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        for touch in touches {
            if touch.view?.tag == 1 {
                // Viewのアニメーション
                UIView.animate(
                    withDuration: 0.2,
                    delay: 0,
                    options: .curveEaseIn,
                    animations: {
                        self.menuView.layer.position.x = -self.menuView.frame.width
                    },
                    completion: { bool in
                        self.dismiss(animated: true, completion: nil)
                    }
                )
                
                // ボタンのアニメーション
                UIView.animate(
                    withDuration: 0.2,
                    delay: 0,
                    options: .curveEaseIn,
                    animations: {
                        self.btnStandard.layer.position.x = -self.menuView.frame.width
                    },
                    completion: { bool in
                        self.dismiss(animated: true, completion: nil)
                    }
                )
                
                UIView.animate(
                    withDuration: 0.2,
                    delay: 0,
                    options: .curveEaseIn,
                    animations: {
                        self.btnSatellite.layer.position.x = -self.menuView.frame.width
                    },
                    completion: { bool in
                        self.dismiss(animated: true, completion: nil)
                    }
                )
                
                UIView.animate(
                    withDuration: 0.2,
                    delay: 0,
                    options: .curveEaseIn,
                    animations: {
                        self.btnHybrid.layer.position.x = -self.menuView.frame.width
                    },
                    completion: { bool in
                        self.dismiss(animated: true, completion: nil)
                    }
                )
                
                UIView.animate(
                    withDuration: 0.2,
                    delay: 0,
                    options: .curveEaseIn,
                    animations: {
                        self.btnMutedStandard.layer.position.x = -self.menuView.frame.width
                    },
                    completion: { bool in
                        self.dismiss(animated: true, completion: nil)
                    }
                )
                
                UIView.animate(
                    withDuration: 0.2,
                    delay: 0,
                    options: .curveEaseIn,
                    animations: {
                        self.btnModeGolf.layer.position.x = -self.menuView.frame.width
                    },
                    completion: { bool in
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
        appDelegate.viewController.setMapType(.standard)
        
        updateBtn()
    }
    
    // 地図の表示タイプを切り替える（航空写真）
    @IBAction func btnSatelliteThouchDown(_ sender: Any) {
        print("btnSatelliteBtnThouchDown")
        
        let appDelegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.viewController.setMapType(.satellite)
        
        updateBtn()
    }

    // 地図の表示タイプを切り替える（標準＋航空）
    @IBAction func btnHybridThouchDown(_ sender: Any) {
        print("btnSatelliteBtnThouchDown")
        
        let appDelegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.viewController.setMapType(.hybrid)
        
        updateBtn()
    }

    // 地図の表示タイプを切り替える（データ強調）
    @IBAction func btnMutedStandardThouchDown(_ sender: Any) {
        print("btnSatelliteBtnThouchDown")
        
        let appDelegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.viewController.setMapType(.mutedStandard)
        
        updateBtn()
    }
    
    // 地図タイプボタンのアクティブ状態を更新
    func updateBtn() {
        // カスタムの文字色で初期化
        let g = CGFloat(0x94) / 255
        let b = CGFloat(0xFE) / 255
        let strColor: UIColor = UIColor(red: 0, green: g, blue: b, alpha: 1.0)

        btnStandard.setTitleColor(strColor, for: .normal)
        btnSatellite.setTitleColor(strColor, for: .normal)
        btnHybrid.setTitleColor(strColor, for: .normal)
        btnMutedStandard.setTitleColor(strColor, for: .normal)
        
        // 選択されているボタンの文字をグレーにする
        let appDelegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate

        switch appDelegate.viewController.mapView.mapType {
        case .standard:
            btnStandard.setTitleColor(UIColor.gray, for: .normal)
        case .satellite:
            btnSatellite.setTitleColor(UIColor.gray, for: .normal)
        case .hybrid:
            btnHybrid.setTitleColor(UIColor.gray, for: .normal)
        case .mutedStandard:
            btnMutedStandard.setTitleColor(UIColor.gray, for: .normal)
        default:
            break;
        }
        
        btnModeGolf.setTitleColor(UIColor.gray, for: .normal)
        
        // ボタンの再描画
        self.view.addSubview(btnStandard)
        self.view.addSubview(btnSatellite)
        self.view.addSubview(btnHybrid)
        self.view.addSubview(btnMutedStandard)
        self.view.addSubview(btnModeGolf)
    }
}

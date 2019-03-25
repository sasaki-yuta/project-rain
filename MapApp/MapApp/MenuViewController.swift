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

    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
    }
    
    // メニューエリア以外タップ時の処理
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        for touch in touches {
            if touch.view?.tag == 1 {
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
            }
        }
    }

    // 地図の表示タイプを切り替える（標準）
    @IBAction func btnStandardThouchDown(_ sender: Any) {
        print("btnSatelliteBtnThouchDown")
        
        let appDelegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.viewController.setMapType(.standard)
    }
    
    // 地図の表示タイプを切り替える（航空写真）
    @IBAction func btnSatelliteThouchDown(_ sender: Any) {
        print("btnSatelliteBtnThouchDown")
        
        let appDelegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.viewController.setMapType(.satellite)
    }

    // 地図の表示タイプを切り替える（標準＋航空）
    @IBAction func btnHybridThouchDown(_ sender: Any) {
        print("btnSatelliteBtnThouchDown")
        
        let appDelegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.viewController.setMapType(.hybrid)
    }

    // 地図の表示タイプを切り替える（データ強調）
    @IBAction func btnMutedStandardThouchDown(_ sender: Any) {
        print("btnSatelliteBtnThouchDown")
        
        let appDelegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.viewController.setMapType(.mutedStandard)
    }
}

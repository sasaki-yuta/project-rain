//
//  PointPopupViewController.swift
//  MapApp
//
//  Created by yuta sasaki on 2019/12/01.
//  Copyright © 2019 rain-00-00-09. All rights reserved.
//

import UIKit

class PointPopupViewController: UIViewController {
    
    @IBOutlet weak var lblDistance: UILabel!
    @IBOutlet weak var lblStreetAddr: UILabel!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var btnRoute: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
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

    // Viewの初期化
    func initView() {
        // デバイスの画面サイズを取得する
        let dispSize: CGSize = UIScreen.main.bounds.size
        let height = Int(dispSize.height)
        
        // Viewの表示位置をしたにずらす　→ずれなかったので検討
        let transform = CGAffineTransform(translationX: 0, y: CGFloat(height/2))
        self.view.transform = transform

        // カスタムの文字色で初期化
        let g = CGFloat(0x94) / 255
        let b = CGFloat(0xFE) / 255
        let strColor: UIColor = UIColor(red: 0, green: g, blue: b, alpha: 1.0)
        btnRoute.setTitleColor(strColor, for: .normal)
        self.view.addSubview(btnRoute)

        // タップした地点の名称を表示する
        let appDelegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate
        lblTitle.text = appDelegate.cycleViewController.getTapPointTitle().description
        self.view.addSubview(lblTitle)

        // 距離、住所を表示する
        lblDistance.text = appDelegate.cycleViewController.getTapDistance().description
        self.view.addSubview(lblDistance)

        lblStreetAddr.text = "住所 \n" + appDelegate.cycleViewController.getTapStreetAddr().description
        self.view.addSubview(lblStreetAddr)
    }
    
    // 探索ボタンを押下した時の処理
    @IBAction func btnRouteSearch(_ sender: Any)
    {
        let appDelegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.cycleViewController.routeSearch()
    }
}

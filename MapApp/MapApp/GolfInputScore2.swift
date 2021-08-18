//
//  GolfInputScore2.swift
//  MapApp
//
//  Created by 佐々木勇太 on 2021/08/18.
//  Copyright © 2021 rain-00-00-09. All rights reserved.
//

import UIKit
import GoogleMobileAds


class GolfInputScore2: UIViewController,
                      GADBannerViewDelegate{
    
    @IBOutlet weak var btnBack: UIButton!
    var bannerView: GADBannerView!
    var defineClass:Define = Define()
    // ボタン < と >
    var backBtn: UIButton!
    var forwardBtn: UIButton!

    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        // Google AddMod広告
        bannerView = GADBannerView(adSize: kGADAdSizeBanner) //320×50
        addBannerViewToView(bannerView)
        bannerView.adUnitID = defineClass.getAddModUnitID()
        bannerView.rootViewController = self
        bannerView.load(GADRequest())
        bannerView.delegate = self
        
        // 画面表示
        initView()
    }

    // スコア入力中画面の初期描画
    func initView() {
        let dispSize: CGSize = UIScreen.main.bounds.size
        let width = Int(dispSize.width)

        // prevボタン表示
        backBtn = UIButton(type: UIButton.ButtonType.system)
        backBtn.addTarget(self, action: #selector(btnBack(_:)), for: UIControl.Event.touchUpInside)
        backBtn.setTitle("＜", for: UIControl.State.normal)
        backBtn.frame = CGRect(x:width - 100, y:44, width:30, height:30)
        backBtn.sizeToFit() // サイズを決める(自動調整)
        self.view.addSubview(backBtn)
        
        // nextボタン表示
        forwardBtn = UIButton(type: UIButton.ButtonType.system)
        forwardBtn.addTarget(self, action: #selector(btnForward(_:)), for: UIControl.Event.touchUpInside)
        forwardBtn.setTitle("＞", for: UIControl.State.normal)
        forwardBtn.frame = CGRect(x:width - 50, y:44, width:30, height:30)
        forwardBtn.sizeToFit() // サイズを決める(自動調整)
        self.view.addSubview(forwardBtn)
    }
    
    // < ボタンを押下した時の処理
    @IBAction func btnBack(_ sender: Any)
    {
        
    }

    // > ボタンを押下した時の処理
    @IBAction func btnForward(_ sender: Any)
    {
        
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
    
    // 戻るボタンを押下した時の処理
    @IBAction func btnBackThouchDown(_ sender: Any)
    {
        // ViewControllerを表示する
        self.performSegue(withIdentifier: "toViewController", sender: nil)
    }
}

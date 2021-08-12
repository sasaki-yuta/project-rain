//
//  GolfManageScore.swift
//  MapApp
//
//  Created by 佐々木勇太 on 2021/08/12.
//  Copyright © 2021 rain-00-00-09. All rights reserved.
//

import UIKit
import GoogleMobileAds


class GolfManageScore: UIViewController,
                       GADBannerViewDelegate{
    
    @IBOutlet weak var btnBack: UIButton!
    // Google AddMod広告
    var bannerView: GADBannerView!
    var defineClass:Define = Define()
    
    // 戻るボタンを押下した時の処理
    @IBAction func btnBackThouchDown(_ sender: Any)
    {
        // ViewControllerを表示する
        self.performSegue(withIdentifier: "toViewController", sender: nil)
    }
    
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
        
    }
}

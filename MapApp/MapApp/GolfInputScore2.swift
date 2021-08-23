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
    // スコア入力 Line0
    var lblHole = UILabel()
    var lblPar = UILabel()
    var lblName1 = UITextField()
    var lblName2 = UITextField()
    var lblName3 = UITextField()
    var lblName4 = UITextField()
    // スコア入力 Line1
    var lblHole1 = UILabel()
    var txtPar1 = UITextField()
    var txtP1P1 = UITextField()
    var txtP1P1_1 = UITextField()
    var txtP1P1_2 = UITextField()
    var txtP1P2 = UITextField()
    var txtP1P2_1 = UITextField()
    var txtP1P2_2 = UITextField()
    
    // スコア入力 Line2
    var lblHole2 = UILabel()
    var txtPar2 = UITextField()
    // スコア入力 Line3
    var lblHole3 = UILabel()
    var txtPar3 = UITextField()
    // スコア入力 Line4
    var lblHole4 = UILabel()
    var txtPar4 = UITextField()
    // スコア入力 Line5
    var lblHole5 = UILabel()
    var txtPar5 = UITextField()
    // スコア入力 Line6
    var lblHole6 = UILabel()
    var txtPar6 = UITextField()
    // スコア入力 Line7
    var lblHole7 = UILabel()
    var txtPar7 = UITextField()
    // スコア入力 Line8
    var lblHole8 = UILabel()
    var txtPar8 = UITextField()
    // スコア入力 Line9
    var lblHole9 = UILabel()
    var txtPar9 = UITextField()
    // スコア入力 LineOut
    var lblHole10 = UILabel()
    var txtPar10 = UITextField()



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
        let height = Int(dispSize.height)

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
        
        let itemWidth = width / 6
        let itemHeight = (height - 90 - 120) / 11 // 名前＋9ホール＋合計=12分割
        // スコア入力 Line0 ==============================
        lblHole.text = "H"
        lblHole.frame = CGRect(x:(itemWidth/2), y:90, width:(itemWidth/2), height:itemHeight)
        lblHole.layer.borderWidth = 1
        lblHole.textAlignment = NSTextAlignment.center
        self.view.addSubview(lblHole)
        
        lblPar.text = "P"
        lblPar.frame = CGRect(x:(itemWidth*1), y:90, width:(itemWidth/2), height:itemHeight)
        lblPar.layer.borderWidth = 1
        lblPar.textAlignment = NSTextAlignment.center
        self.view.addSubview(lblPar)
        
        lblName1.text = ""
        lblName1.frame = CGRect(x:(itemWidth*2)-(itemWidth/2), y:90, width:itemWidth, height:itemHeight)
        lblName1.layer.borderWidth = 1
        lblName1.textAlignment = NSTextAlignment.center
        self.view.addSubview(lblName1)
        
        lblName2.text = ""
        lblName2.frame = CGRect(x:(itemWidth*3)-(itemWidth/2), y:90, width:itemWidth, height:itemHeight)
        lblName2.layer.borderWidth = 1
        lblName2.textAlignment = NSTextAlignment.center
        self.view.addSubview(lblName2)
        
        lblName3.text = ""
        lblName3.frame = CGRect(x:(itemWidth*4)-(itemWidth/2), y:90, width:itemWidth, height:itemHeight)
        lblName3.layer.borderWidth = 1
        lblName3.textAlignment = NSTextAlignment.center
        self.view.addSubview(lblName3)
        
        lblName4.text = ""
        lblName4.frame = CGRect(x:(itemWidth*5)-(itemWidth/2), y:90, width:itemWidth, height:itemHeight)
        lblName4.layer.borderWidth = 1
        lblName4.textAlignment = NSTextAlignment.center
        self.view.addSubview(lblName4)

        // スコア入力 Line1 ==============================
        lblHole1.text = "1"
        lblHole1.frame = CGRect(x:(itemWidth/2), y:90+(itemHeight*1), width:(itemWidth/2), height:itemHeight)
        lblHole1.layer.borderWidth = 1
        lblHole1.textAlignment = NSTextAlignment.center
        self.view.addSubview(lblHole1)
        
        txtPar1.frame = CGRect(x:(itemWidth*1), y:90+(itemHeight*1), width:(itemWidth/2), height:itemHeight)
        txtPar1.layer.borderWidth = 1
        txtPar1.textAlignment = NSTextAlignment.center
        self.view.addSubview(txtPar1)
        
        txtP1P1.frame = CGRect(x:(itemWidth*2), y:90+(itemHeight*1), width:(itemWidth/2), height:itemHeight)
        txtP1P1.layer.borderWidth = 1
        txtP1P1.textAlignment = NSTextAlignment.center
        self.view.addSubview(txtP1P1)
        
        // スコア入力 Line2 ==============================
        lblHole2.text = "2"
        lblHole2.frame = CGRect(x:(itemWidth/2), y:90+(itemHeight*2), width:(itemWidth/2), height:itemHeight)
        lblHole2.layer.borderWidth = 1
        lblHole2.textAlignment = NSTextAlignment.center
        self.view.addSubview(lblHole2)
        
        txtPar2.frame = CGRect(x:(itemWidth*1), y:90+(itemHeight*2), width:(itemWidth/2), height:itemHeight)
        txtPar2.layer.borderWidth = 1
        txtPar2.textAlignment = NSTextAlignment.center
        self.view.addSubview(txtPar2)
        
        
        // スコア入力 Line3 ==============================
        lblHole3.text = "3"
        lblHole3.frame = CGRect(x:(itemWidth/2), y:90+(itemHeight*3), width:(itemWidth/2), height:itemHeight)
        lblHole3.layer.borderWidth = 1
        lblHole3.textAlignment = NSTextAlignment.center
        self.view.addSubview(lblHole3)
        
        txtPar3.frame = CGRect(x:(itemWidth*1), y:90+(itemHeight*3), width:(itemWidth/2), height:itemHeight)
        txtPar3.layer.borderWidth = 1
        txtPar3.textAlignment = NSTextAlignment.center
        self.view.addSubview(txtPar3)
        
        // スコア入力 Line4 ==============================
        lblHole4.text = "4"
        lblHole4.frame = CGRect(x:(itemWidth/2), y:90+(itemHeight*4), width:(itemWidth/2), height:itemHeight)
        lblHole4.layer.borderWidth = 1
        lblHole4.textAlignment = NSTextAlignment.center
        self.view.addSubview(lblHole4)

        txtPar4.frame = CGRect(x:(itemWidth*1), y:90+(itemHeight*4), width:(itemWidth/2), height:itemHeight)
        txtPar4.layer.borderWidth = 1
        txtPar4.textAlignment = NSTextAlignment.center
        self.view.addSubview(txtPar4)
        
        // スコア入力 Line5 ==============================
        lblHole5.text = "5"
        lblHole5.frame = CGRect(x:(itemWidth/2), y:90+(itemHeight*5), width:(itemWidth/2), height:itemHeight)
        lblHole5.layer.borderWidth = 1
        lblHole5.textAlignment = NSTextAlignment.center
        self.view.addSubview(lblHole5)
        
        txtPar5.frame = CGRect(x:(itemWidth*1), y:90+(itemHeight*5), width:(itemWidth/2), height:itemHeight)
        txtPar5.layer.borderWidth = 1
        txtPar5.textAlignment = NSTextAlignment.center
        self.view.addSubview(txtPar5)

        // スコア入力 Line6 ==============================
        lblHole6.text = "6"
        lblHole6.frame = CGRect(x:(itemWidth/2), y:90+(itemHeight*6), width:(itemWidth/2), height:itemHeight)
        lblHole6.layer.borderWidth = 1
        lblHole6.textAlignment = NSTextAlignment.center
        self.view.addSubview(lblHole6)
        
        txtPar6.frame = CGRect(x:(itemWidth*1), y:90+(itemHeight*6), width:(itemWidth/2), height:itemHeight)
        txtPar6.layer.borderWidth = 1
        txtPar6.textAlignment = NSTextAlignment.center
        self.view.addSubview(txtPar6)
        
        // スコア入力 Line7 ==============================
        lblHole7.text = "7"
        lblHole7.frame = CGRect(x:(itemWidth/2), y:90+(itemHeight*7), width:(itemWidth/2), height:itemHeight)
        lblHole7.layer.borderWidth = 1
        lblHole7.textAlignment = NSTextAlignment.center
        self.view.addSubview(lblHole7)
        
        txtPar7.frame = CGRect(x:(itemWidth*1), y:90+(itemHeight*7), width:(itemWidth/2), height:itemHeight)
        txtPar7.layer.borderWidth = 1
        txtPar7.textAlignment = NSTextAlignment.center
        self.view.addSubview(txtPar7)
        
        // スコア入力 Line8 ==============================
        lblHole8.text = "8"
        lblHole8.frame = CGRect(x:(itemWidth/2), y:90+(itemHeight*8), width:(itemWidth/2), height:itemHeight)
        lblHole8.layer.borderWidth = 1
        lblHole8.textAlignment = NSTextAlignment.center
        self.view.addSubview(lblHole8)
        
        txtPar8.frame = CGRect(x:(itemWidth*1), y:90+(itemHeight*8), width:(itemWidth/2), height:itemHeight)
        txtPar8.layer.borderWidth = 1
        txtPar8.textAlignment = NSTextAlignment.center
        self.view.addSubview(txtPar8)
        
        // スコア入力 Line9 ==============================
        lblHole9.text = "9"
        lblHole9.frame = CGRect(x:(itemWidth/2), y:90+(itemHeight*9), width:(itemWidth/2), height:itemHeight)
        lblHole9.layer.borderWidth = 1
        lblHole9.textAlignment = NSTextAlignment.center
        self.view.addSubview(lblHole9)

        txtPar9.frame = CGRect(x:(itemWidth*1), y:90+(itemHeight*9), width:(itemWidth/2), height:itemHeight)
        txtPar9.layer.borderWidth = 1
        txtPar9.textAlignment = NSTextAlignment.center
        self.view.addSubview(txtPar9)

        // スコア入力 LineOut ============================
        lblHole10.text = "T"
        lblHole10.frame = CGRect(x:(itemWidth/2), y:90+(itemHeight*10), width:(itemWidth/2), height:itemHeight)
        lblHole10.layer.borderWidth = 1
        lblHole10.textAlignment = NSTextAlignment.center
        self.view.addSubview(lblHole10)

        txtPar10.frame = CGRect(x:(itemWidth*1), y:90+(itemHeight*10), width:(itemWidth/2), height:itemHeight)
        txtPar10.layer.borderWidth = 1
        txtPar10.textAlignment = NSTextAlignment.center
        self.view.addSubview(txtPar10)
        
    }
    
    // < ボタンを押下した時の処理
    @IBAction func btnBack(_ sender: Any)
    {
        self.performSegue(withIdentifier: "toGolfInputScore", sender: nil)
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

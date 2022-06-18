//
//  GolfInputScore2.swift
//  MapApp
//
//  Created by 佐々木勇太 on 2021/08/18.
//  Copyright © 2021 rain-00-00-09. All rights reserved.
//

import UIKit
import GoogleMobileAds
import Foundation


class GolfInputScore2: UIViewController,
                      GADBannerViewDelegate,
                      UITextFieldDelegate{
    
    @IBOutlet weak var btnBack: UIButton!
    var bannerView: GADBannerView!
    var defineClass:Define = Define()
    // IN、Out
    var m_isOut: Bool = true
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
//    var txtP1P1_2 = UITextField()
    var txtP1P2 = UITextField()
    var txtP1P2_1 = UITextField()
//    var txtP1P2_2 = UITextField()
    var txtP1P3 = UITextField()
    var txtP1P3_1 = UITextField()
//    var txtP1P3_2 = UITextField()
    var txtP1P4 = UITextField()
    var txtP1P4_1 = UITextField()
//    var txtP1P4_2 = UITextField()
    
    // スコア入力 Line2
    var lblHole2 = UILabel()
    var txtPar2 = UITextField()
    var txtP2P1 = UITextField()
    var txtP2P1_1 = UITextField()
//    var txtP2P1_2 = UITextField()
    var txtP2P2 = UITextField()
    var txtP2P2_1 = UITextField()
//    var txtP2P2_2 = UITextField()
    var txtP2P3 = UITextField()
    var txtP2P3_1 = UITextField()
//    var txtP2P3_2 = UITextField()
    var txtP2P4 = UITextField()
    var txtP2P4_1 = UITextField()
//    var txtP2P4_2 = UITextField()
    
    // スコア入力 Line3
    var lblHole3 = UILabel()
    var txtPar3 = UITextField()
    var txtP3P1 = UITextField()
    var txtP3P1_1 = UITextField()
//    var txtP3P1_2 = UITextField()
    var txtP3P2 = UITextField()
    var txtP3P2_1 = UITextField()
//    var txtP3P2_2 = UITextField()
    var txtP3P3 = UITextField()
    var txtP3P3_1 = UITextField()
//    var txtP3P3_2 = UITextField()
    var txtP3P4 = UITextField()
    var txtP3P4_1 = UITextField()
//    var txtP3P4_2 = UITextField()

    // スコア入力 Line4
    var lblHole4 = UILabel()
    var txtPar4 = UITextField()
    var txtP4P1 = UITextField()
    var txtP4P1_1 = UITextField()
//    var txtP4P1_2 = UITextField()
    var txtP4P2 = UITextField()
    var txtP4P2_1 = UITextField()
//    var txtP4P2_2 = UITextField()
    var txtP4P3 = UITextField()
    var txtP4P3_1 = UITextField()
//    var txtP4P3_2 = UITextField()
    var txtP4P4 = UITextField()
    var txtP4P4_1 = UITextField()
//    var txtP4P4_2 = UITextField()

    // スコア入力 Line5
    var lblHole5 = UILabel()
    var txtPar5 = UITextField()
    var txtP5P1 = UITextField()
    var txtP5P1_1 = UITextField()
//    var txtP5P1_2 = UITextField()
    var txtP5P2 = UITextField()
    var txtP5P2_1 = UITextField()
//    var txtP5P2_2 = UITextField()
    var txtP5P3 = UITextField()
    var txtP5P3_1 = UITextField()
//    var txtP5P3_2 = UITextField()
    var txtP5P4 = UITextField()
    var txtP5P4_1 = UITextField()
//    var txtP5P4_2 = UITextField()
    
    // スコア入力 Line6
    var lblHole6 = UILabel()
    var txtPar6 = UITextField()
    var txtP6P1 = UITextField()
    var txtP6P1_1 = UITextField()
//    var txtP6P1_2 = UITextField()
    var txtP6P2 = UITextField()
    var txtP6P2_1 = UITextField()
//    var txtP6P2_2 = UITextField()
    var txtP6P3 = UITextField()
    var txtP6P3_1 = UITextField()
//    var txtP6P3_2 = UITextField()
    var txtP6P4 = UITextField()
    var txtP6P4_1 = UITextField()
//    var txtP6P4_2 = UITextField()

    // スコア入力 Line7
    var lblHole7 = UILabel()
    var txtPar7 = UITextField()
    var txtP7P1 = UITextField()
    var txtP7P1_1 = UITextField()
//    var txtP7P1_2 = UITextField()
    var txtP7P2 = UITextField()
    var txtP7P2_1 = UITextField()
//    var txtP7P2_2 = UITextField()
    var txtP7P3 = UITextField()
    var txtP7P3_1 = UITextField()
//    var txtP7P3_2 = UITextField()
    var txtP7P4 = UITextField()
    var txtP7P4_1 = UITextField()
//    var txtP7P4_2 = UITextField()
    
    // スコア入力 Line8
    var lblHole8 = UILabel()
    var txtPar8 = UITextField()
    var txtP8P1 = UITextField()
    var txtP8P1_1 = UITextField()
//    var txtP8P1_2 = UITextField()
    var txtP8P2 = UITextField()
    var txtP8P2_1 = UITextField()
//    var txtP8P2_2 = UITextField()
    var txtP8P3 = UITextField()
    var txtP8P3_1 = UITextField()
//    var txtP8P3_2 = UITextField()
    var txtP8P4 = UITextField()
    var txtP8P4_1 = UITextField()
//    var txtP8P4_2 = UITextField()
    
    // スコア入力 Line9
    var lblHole9 = UILabel()
    var txtPar9 = UITextField()
    var txtP9P1 = UITextField()
    var txtP9P1_1 = UITextField()
//    var txtP9P1_2 = UITextField()
    var txtP9P2 = UITextField()
    var txtP9P2_1 = UITextField()
//    var txtP9P2_2 = UITextField()
    var txtP9P3 = UITextField()
    var txtP9P3_1 = UITextField()
//    var txtP9P3_2 = UITextField()
    var txtP9P4 = UITextField()
    var txtP9P4_1 = UITextField()
//    var txtP9P4_2 = UITextField()
    
    // スコア入力 LineOut
    var lblHole10 = UILabel()
    var txtPar10 = UILabel()
    var txtP10P1 = UILabel()
    var txtP10P1_1 = UILabel()
//    var txtP10P1_2 = UILabel()
    var txtP10P2 = UILabel()
    var txtP10P2_1 = UILabel()
//    var txtP10P2_2 = UILabel()
    var txtP10P3 = UILabel()
    var txtP10P3_1 = UILabel()
//    var txtP10P3_2 = UILabel()
    var txtP10P4 = UILabel()
    var txtP10P4_1 = UILabel()
//    var txtP10P4_2 = UILabel()

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
        
        // スコア更新
        let appDelegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate
        m_isOut = appDelegate.golfRealmData.getRoundData().isOut
        loadScore(m_isOut)
    }

    // スコア入力中画面の初期描画
    func initView() {
        lblName1.delegate = self
        lblName2.delegate = self
        lblName3.delegate = self
        lblName4.delegate = self
        txtPar1.delegate = self
        txtP1P1.delegate = self
        txtP1P1_1.delegate = self
//        txtP1P1_2.delegate = self
        txtP1P2.delegate = self
        txtP1P2_1.delegate = self
//        txtP1P2_2.delegate = self
        txtP1P3.delegate = self
        txtP1P3_1.delegate = self
//        txtP1P3_2.delegate = self
        txtP1P4.delegate = self
        txtP1P4_1.delegate = self
//        txtP1P4_2.delegate = self
        txtPar2.delegate = self
        txtP2P1.delegate = self
        txtP2P1_1.delegate = self
//        txtP2P1_2.delegate = self
        txtP2P2.delegate = self
        txtP2P2_1.delegate = self
//        txtP2P2_2.delegate = self
        txtP2P3.delegate = self
        txtP2P3_1.delegate = self
//        txtP2P3_2.delegate = self
        txtP2P4.delegate = self
        txtP2P4_1.delegate = self
//        txtP2P4_2.delegate = self
        txtPar3.delegate = self
        txtP3P1.delegate = self
        txtP3P1_1.delegate = self
//        txtP3P1_2.delegate = self
        txtP3P2.delegate = self
        txtP3P2_1.delegate = self
//        txtP3P2_2.delegate = self
        txtP3P3.delegate = self
        txtP3P3_1.delegate = self
//        txtP3P3_2.delegate = self
        txtP3P4.delegate = self
        txtP3P4_1.delegate = self
//        txtP3P4_2.delegate = self
        txtPar4.delegate = self
        txtP4P1.delegate = self
        txtP4P1_1.delegate = self
//        txtP4P1_2.delegate = self
        txtP4P2.delegate = self
        txtP4P2_1.delegate = self
//        txtP4P2_2.delegate = self
        txtP4P3.delegate = self
        txtP4P3_1.delegate = self
//        txtP4P3_2.delegate = self
        txtP4P4.delegate = self
        txtP4P4_1.delegate = self
//        txtP4P4_2.delegate = self
        txtPar5.delegate = self
        txtP5P1.delegate = self
        txtP5P1_1.delegate = self
//        txtP5P1_2.delegate = self
        txtP5P2.delegate = self
        txtP5P2_1.delegate = self
//        txtP5P2_2.delegate = self
        txtP5P3.delegate = self
        txtP5P3_1.delegate = self
//        txtP5P3_2.delegate = self
        txtP5P4.delegate = self
        txtP5P4_1.delegate = self
//        txtP5P4_2.delegate = self
        txtPar6.delegate = self
        txtP6P1.delegate = self
        txtP6P1_1.delegate = self
//        txtP6P1_2.delegate = self
        txtP6P2.delegate = self
        txtP6P2_1.delegate = self
//        txtP6P2_2.delegate = self
        txtP6P3.delegate = self
        txtP6P3_1.delegate = self
//        txtP6P3_2.delegate = self
        txtP6P4.delegate = self
        txtP6P4_1.delegate = self
//        txtP6P4_2.delegate = self
        txtPar7.delegate = self
        txtP7P1.delegate = self
        txtP7P1_1.delegate = self
//        txtP7P1_2.delegate = self
        txtP7P2.delegate = self
        txtP7P2_1.delegate = self
//        txtP7P2_2.delegate = self
        txtP7P3.delegate = self
        txtP7P3_1.delegate = self
//        txtP7P3_2.delegate = self
        txtP7P4.delegate = self
        txtP7P4_1.delegate = self
//        txtP7P4_2.delegate = self
        txtPar8.delegate = self
        txtP8P1.delegate = self
        txtP8P1_1.delegate = self
//        txtP8P1_2.delegate = self
        txtP8P2.delegate = self
        txtP8P2_1.delegate = self
//        txtP8P2_2.delegate = self
        txtP8P3.delegate = self
        txtP8P3_1.delegate = self
//        txtP8P3_2.delegate = self
        txtP8P4.delegate = self
        txtP8P4_1.delegate = self
//        txtP8P4_2.delegate = self
        txtPar9.delegate = self
        txtP9P1.delegate = self
        txtP9P1_1.delegate = self
//        txtP9P1_2.delegate = self
        txtP9P2.delegate = self
        txtP9P2_1.delegate = self
//        txtP9P2_2.delegate = self
        txtP9P3.delegate = self
        txtP9P3_1.delegate = self
//        txtP9P3_2.delegate = self
        txtP9P4.delegate = self
        txtP9P4_1.delegate = self
//        txtP9P4_2.delegate = self

        
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
        
        // Player1
        txtP1P1.frame = CGRect(x:(itemWidth*2)-(itemWidth/2), y:90+(itemHeight*1), width:(itemWidth/2), height:itemHeight)
        txtP1P1.layer.borderWidth = 1
        txtP1P1.textAlignment = NSTextAlignment.center
        self.view.addSubview(txtP1P1)

        txtP1P1_1.frame = CGRect(x:(itemWidth*2), y:90+(itemHeight*1), width:(itemWidth/2), height:itemHeight)
        txtP1P1_1.layer.borderWidth = 1
        txtP1P1_1.textAlignment = NSTextAlignment.center
        self.view.addSubview(txtP1P1_1)

//        txtP1P1_2.frame = CGRect(x:(itemWidth*2), y:90+(itemHeight*2)-(itemHeight/2), width:(itemWidth/2), height:itemHeight/2)
//        txtP1P1_2.layer.borderWidth = 1
//        txtP1P1_2.textAlignment = NSTextAlignment.center
//        self.view.addSubview(txtP1P1_2)

        // Player2
        txtP1P2.frame = CGRect(x:(itemWidth*3)-(itemWidth/2), y:90+(itemHeight*1), width:(itemWidth/2), height:itemHeight)
        txtP1P2.layer.borderWidth = 1
        txtP1P2.textAlignment = NSTextAlignment.center
        self.view.addSubview(txtP1P2)

        txtP1P2_1.frame = CGRect(x:(itemWidth*3), y:90+(itemHeight*1), width:(itemWidth/2), height:itemHeight)
        txtP1P2_1.layer.borderWidth = 1
        txtP1P2_1.textAlignment = NSTextAlignment.center
        self.view.addSubview(txtP1P2_1)

//        txtP1P2_2.frame = CGRect(x:(itemWidth*3), y:90+(itemHeight*2)-(itemHeight/2), width:(itemWidth/2), height:itemHeight/2)
//        txtP1P2_2.layer.borderWidth = 1
//        txtP1P2_2.textAlignment = NSTextAlignment.center
//        self.view.addSubview(txtP1P2_2)

        // Player3
        txtP1P3.frame = CGRect(x:(itemWidth*4)-(itemWidth/2), y:90+(itemHeight*1), width:(itemWidth/2), height:itemHeight)
        txtP1P3.layer.borderWidth = 1
        txtP1P3.textAlignment = NSTextAlignment.center
        self.view.addSubview(txtP1P3)

        txtP1P3_1.frame = CGRect(x:(itemWidth*4), y:90+(itemHeight*1), width:(itemWidth/2), height:itemHeight)
        txtP1P3_1.layer.borderWidth = 1
        txtP1P3_1.textAlignment = NSTextAlignment.center
        self.view.addSubview(txtP1P3_1)

//        txtP1P3_2.frame = CGRect(x:(itemWidth*4), y:90+(itemHeight*2)-(itemHeight/2), width:(itemWidth/2), height:itemHeight/2)
//        txtP1P3_2.layer.borderWidth = 1
//        txtP1P3_2.textAlignment = NSTextAlignment.center
//        self.view.addSubview(txtP1P3_2)

        // Player4
        txtP1P4.frame = CGRect(x:(itemWidth*5)-(itemWidth/2), y:90+(itemHeight*1), width:(itemWidth/2), height:itemHeight)
        txtP1P4.layer.borderWidth = 1
        txtP1P4.textAlignment = NSTextAlignment.center
        self.view.addSubview(txtP1P4)

        txtP1P4_1.frame = CGRect(x:(itemWidth*5), y:90+(itemHeight*1), width:(itemWidth/2), height:itemHeight)
        txtP1P4_1.layer.borderWidth = 1
        txtP1P4_1.textAlignment = NSTextAlignment.center
        self.view.addSubview(txtP1P4_1)

//        txtP1P4_2.frame = CGRect(x:(itemWidth*5), y:90+(itemHeight*2)-(itemHeight/2), width:(itemWidth/2), height:itemHeight/2)
//        txtP1P4_2.layer.borderWidth = 1
//        txtP1P4_2.textAlignment = NSTextAlignment.center
//        self.view.addSubview(txtP1P4_2)
        
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
        
        // Player1
        txtP2P1.frame = CGRect(x:(itemWidth*2)-(itemWidth/2), y:90+(itemHeight*2), width:(itemWidth/2), height:itemHeight)
        txtP2P1.layer.borderWidth = 1
        txtP2P1.textAlignment = NSTextAlignment.center
        self.view.addSubview(txtP2P1)

        txtP2P1_1.frame = CGRect(x:(itemWidth*2), y:90+(itemHeight*2), width:(itemWidth/2), height:itemHeight)
        txtP2P1_1.layer.borderWidth = 1
        txtP2P1_1.textAlignment = NSTextAlignment.center
        self.view.addSubview(txtP2P1_1)

//        txtP2P1_2.frame = CGRect(x:(itemWidth*2), y:90+(itemHeight*3)-(itemHeight/2), width:(itemWidth/2), height:itemHeight/2)
//        txtP2P1_2.layer.borderWidth = 1
//        txtP2P1_2.textAlignment = NSTextAlignment.center
//        self.view.addSubview(txtP2P1_2)

        // Player2
        txtP2P2.frame = CGRect(x:(itemWidth*3)-(itemWidth/2), y:90+(itemHeight*2), width:(itemWidth/2), height:itemHeight)
        txtP2P2.layer.borderWidth = 1
        txtP2P2.textAlignment = NSTextAlignment.center
        self.view.addSubview(txtP2P2)

        txtP2P2_1.frame = CGRect(x:(itemWidth*3), y:90+(itemHeight*2), width:(itemWidth/2), height:itemHeight)
        txtP2P2_1.layer.borderWidth = 1
        txtP2P2_1.textAlignment = NSTextAlignment.center
        self.view.addSubview(txtP2P2_1)

//        txtP2P2_2.frame = CGRect(x:(itemWidth*3), y:90+(itemHeight*3)-(itemHeight/2), width:(itemWidth/2), height:itemHeight/2)
//        txtP2P2_2.layer.borderWidth = 1
//        txtP2P2_2.textAlignment = NSTextAlignment.center
//        self.view.addSubview(txtP2P2_2)

        // Player3
        txtP2P3.frame = CGRect(x:(itemWidth*4)-(itemWidth/2), y:90+(itemHeight*2), width:(itemWidth/2), height:itemHeight)
        txtP2P3.layer.borderWidth = 1
        txtP2P3.textAlignment = NSTextAlignment.center
        self.view.addSubview(txtP2P3)

        txtP2P3_1.frame = CGRect(x:(itemWidth*4), y:90+(itemHeight*2), width:(itemWidth/2), height:itemHeight)
        txtP2P3_1.layer.borderWidth = 1
        txtP2P3_1.textAlignment = NSTextAlignment.center
        self.view.addSubview(txtP2P3_1)

//        txtP2P3_2.frame = CGRect(x:(itemWidth*4), y:90+(itemHeight*3)-(itemHeight/2), width:(itemWidth/2), height:itemHeight/2)
//        txtP2P3_2.layer.borderWidth = 1
//        txtP2P3_2.textAlignment = NSTextAlignment.center
//        self.view.addSubview(txtP2P3_2)

        // Player4
        txtP2P4.frame = CGRect(x:(itemWidth*5)-(itemWidth/2), y:90+(itemHeight*2), width:(itemWidth/2), height:itemHeight)
        txtP2P4.layer.borderWidth = 1
        txtP2P4.textAlignment = NSTextAlignment.center
        self.view.addSubview(txtP2P4)

        txtP2P4_1.frame = CGRect(x:(itemWidth*5), y:90+(itemHeight*2), width:(itemWidth/2), height:itemHeight)
        txtP2P4_1.layer.borderWidth = 1
        txtP2P4_1.textAlignment = NSTextAlignment.center
        self.view.addSubview(txtP2P4_1)

//        txtP2P4_2.frame = CGRect(x:(itemWidth*5), y:90+(itemHeight*3)-(itemHeight/2), width:(itemWidth/2), height:itemHeight/2)
//        txtP2P4_2.layer.borderWidth = 1
//        txtP2P4_2.textAlignment = NSTextAlignment.center
//        self.view.addSubview(txtP2P4_2)
        
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

        // Player1
        txtP3P1.frame = CGRect(x:(itemWidth*2)-(itemWidth/2), y:90+(itemHeight*3), width:(itemWidth/2), height:itemHeight)
        txtP3P1.layer.borderWidth = 1
        txtP3P1.textAlignment = NSTextAlignment.center
        self.view.addSubview(txtP3P1)

        txtP3P1_1.frame = CGRect(x:(itemWidth*2), y:90+(itemHeight*3), width:(itemWidth/2), height:itemHeight)
        txtP3P1_1.layer.borderWidth = 1
        txtP3P1_1.textAlignment = NSTextAlignment.center
        self.view.addSubview(txtP3P1_1)

//        txtP3P1_2.frame = CGRect(x:(itemWidth*2), y:90+(itemHeight*4)-(itemHeight/2), width:(itemWidth/2), height:itemHeight/2)
//        txtP3P1_2.layer.borderWidth = 1
//        txtP3P1_2.textAlignment = NSTextAlignment.center
//        self.view.addSubview(txtP3P1_2)
        
        // Player2
        txtP3P2.frame = CGRect(x:(itemWidth*3)-(itemWidth/2), y:90+(itemHeight*3), width:(itemWidth/2), height:itemHeight)
        txtP3P2.layer.borderWidth = 1
        txtP3P2.textAlignment = NSTextAlignment.center
        self.view.addSubview(txtP3P2)

        txtP3P2_1.frame = CGRect(x:(itemWidth*3), y:90+(itemHeight*3), width:(itemWidth/2), height:itemHeight)
        txtP3P2_1.layer.borderWidth = 1
        txtP3P2_1.textAlignment = NSTextAlignment.center
        self.view.addSubview(txtP3P2_1)

//        txtP3P2_2.frame = CGRect(x:(itemWidth*3), y:90+(itemHeight*4)-(itemHeight/2), width:(itemWidth/2), height:itemHeight/2)
//        txtP3P2_2.layer.borderWidth = 1
//        txtP3P2_2.textAlignment = NSTextAlignment.center
//        self.view.addSubview(txtP3P2_2)

        // Player3
        txtP3P3.frame = CGRect(x:(itemWidth*4)-(itemWidth/2), y:90+(itemHeight*3), width:(itemWidth/2), height:itemHeight)
        txtP3P3.layer.borderWidth = 1
        txtP3P3.textAlignment = NSTextAlignment.center
        self.view.addSubview(txtP3P3)

        txtP3P3_1.frame = CGRect(x:(itemWidth*4), y:90+(itemHeight*3), width:(itemWidth/2), height:itemHeight)
        txtP3P3_1.layer.borderWidth = 1
        txtP3P3_1.textAlignment = NSTextAlignment.center
        self.view.addSubview(txtP3P3_1)

//        txtP3P3_2.frame = CGRect(x:(itemWidth*4), y:90+(itemHeight*4)-(itemHeight/2), width:(itemWidth/2), height:itemHeight/2)
//        txtP3P3_2.layer.borderWidth = 1
//        txtP3P3_2.textAlignment = NSTextAlignment.center
//        self.view.addSubview(txtP3P3_2)

        // Player4
        txtP3P4.frame = CGRect(x:(itemWidth*5)-(itemWidth/2), y:90+(itemHeight*3), width:(itemWidth/2), height:itemHeight)
        txtP3P4.layer.borderWidth = 1
        txtP3P4.textAlignment = NSTextAlignment.center
        self.view.addSubview(txtP3P4)

        txtP3P4_1.frame = CGRect(x:(itemWidth*5), y:90+(itemHeight*3), width:(itemWidth/2), height:itemHeight)
        txtP3P4_1.layer.borderWidth = 1
        txtP3P4_1.textAlignment = NSTextAlignment.center
        self.view.addSubview(txtP3P4_1)

//        txtP3P4_2.frame = CGRect(x:(itemWidth*5), y:90+(itemHeight*4)-(itemHeight/2), width:(itemWidth/2), height:itemHeight/2)
//        txtP3P4_2.layer.borderWidth = 1
//        txtP3P4_2.textAlignment = NSTextAlignment.center
//        self.view.addSubview(txtP3P4_2)

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
        
        // Player1
        txtP4P1.frame = CGRect(x:(itemWidth*2)-(itemWidth/2), y:90+(itemHeight*4), width:(itemWidth/2), height:itemHeight)
        txtP4P1.layer.borderWidth = 1
        txtP4P1.textAlignment = NSTextAlignment.center
        self.view.addSubview(txtP4P1)

        txtP4P1_1.frame = CGRect(x:(itemWidth*2), y:90+(itemHeight*4), width:(itemWidth/2), height:itemHeight)
        txtP4P1_1.layer.borderWidth = 1
        txtP4P1_1.textAlignment = NSTextAlignment.center
        self.view.addSubview(txtP4P1_1)

//        txtP4P1_2.frame = CGRect(x:(itemWidth*2), y:90+(itemHeight*5)-(itemHeight/2), width:(itemWidth/2), height:itemHeight/2)
//        txtP4P1_2.layer.borderWidth = 1
//        txtP4P1_2.textAlignment = NSTextAlignment.center
//        self.view.addSubview(txtP4P1_2)
        
        // Player2
        txtP4P2.frame = CGRect(x:(itemWidth*3)-(itemWidth/2), y:90+(itemHeight*4), width:(itemWidth/2), height:itemHeight)
        txtP4P2.layer.borderWidth = 1
        txtP4P2.textAlignment = NSTextAlignment.center
        self.view.addSubview(txtP4P2)

        txtP4P2_1.frame = CGRect(x:(itemWidth*3), y:90+(itemHeight*4), width:(itemWidth/2), height:itemHeight)
        txtP4P2_1.layer.borderWidth = 1
        txtP4P2_1.textAlignment = NSTextAlignment.center
        self.view.addSubview(txtP4P2_1)

//        txtP4P2_2.frame = CGRect(x:(itemWidth*3), y:90+(itemHeight*5)-(itemHeight/2), width:(itemWidth/2), height:itemHeight/2)
//        txtP4P2_2.layer.borderWidth = 1
//        txtP4P2_2.textAlignment = NSTextAlignment.center
//        self.view.addSubview(txtP4P2_2)

        // Player3
        txtP4P3.frame = CGRect(x:(itemWidth*4)-(itemWidth/2), y:90+(itemHeight*4), width:(itemWidth/2), height:itemHeight)
        txtP4P3.layer.borderWidth = 1
        txtP4P3.textAlignment = NSTextAlignment.center
        self.view.addSubview(txtP4P3)

        txtP4P3_1.frame = CGRect(x:(itemWidth*4), y:90+(itemHeight*4), width:(itemWidth/2), height:itemHeight)
        txtP4P3_1.layer.borderWidth = 1
        txtP4P3_1.textAlignment = NSTextAlignment.center
        self.view.addSubview(txtP4P3_1)

//        txtP4P3_2.frame = CGRect(x:(itemWidth*4), y:90+(itemHeight*5)-(itemHeight/2), width:(itemWidth/2), height:itemHeight/2)
//        txtP4P3_2.layer.borderWidth = 1
//        txtP4P3_2.textAlignment = NSTextAlignment.center
//        self.view.addSubview(txtP4P3_2)
        
        // Player4
        txtP4P4.frame = CGRect(x:(itemWidth*5)-(itemWidth/2), y:90+(itemHeight*4), width:(itemWidth/2), height:itemHeight)
        txtP4P4.layer.borderWidth = 1
        txtP4P4.textAlignment = NSTextAlignment.center
        self.view.addSubview(txtP4P4)

        txtP4P4_1.frame = CGRect(x:(itemWidth*5), y:90+(itemHeight*4), width:(itemWidth/2), height:itemHeight)
        txtP4P4_1.layer.borderWidth = 1
        txtP4P4_1.textAlignment = NSTextAlignment.center
        self.view.addSubview(txtP4P4_1)

//        txtP4P4_2.frame = CGRect(x:(itemWidth*5), y:90+(itemHeight*5)-(itemHeight/2), width:(itemWidth/2), height:itemHeight/2)
//        txtP4P4_2.layer.borderWidth = 1
//        txtP4P4_2.textAlignment = NSTextAlignment.center
//        self.view.addSubview(txtP4P4_2)

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
        
        // Player1
        txtP5P1.frame = CGRect(x:(itemWidth*2)-(itemWidth/2), y:90+(itemHeight*5), width:(itemWidth/2), height:itemHeight)
        txtP5P1.layer.borderWidth = 1
        txtP5P1.textAlignment = NSTextAlignment.center
        self.view.addSubview(txtP5P1)

        txtP5P1_1.frame = CGRect(x:(itemWidth*2), y:90+(itemHeight*5), width:(itemWidth/2), height:itemHeight)
        txtP5P1_1.layer.borderWidth = 1
        txtP5P1_1.textAlignment = NSTextAlignment.center
        self.view.addSubview(txtP5P1_1)

//        txtP5P1_2.frame = CGRect(x:(itemWidth*2), y:90+(itemHeight*6)-(itemHeight/2), width:(itemWidth/2), height:itemHeight/2)
//        txtP5P1_2.layer.borderWidth = 1
//        txtP5P1_2.textAlignment = NSTextAlignment.center
//        self.view.addSubview(txtP5P1_2)
        
        // Player2
        txtP5P2.frame = CGRect(x:(itemWidth*3)-(itemWidth/2), y:90+(itemHeight*5), width:(itemWidth/2), height:itemHeight)
        txtP5P2.layer.borderWidth = 1
        txtP5P2.textAlignment = NSTextAlignment.center
        self.view.addSubview(txtP5P2)

        txtP5P2_1.frame = CGRect(x:(itemWidth*3), y:90+(itemHeight*5), width:(itemWidth/2), height:itemHeight)
        txtP5P2_1.layer.borderWidth = 1
        txtP5P2_1.textAlignment = NSTextAlignment.center
        self.view.addSubview(txtP5P2_1)

//        txtP5P2_2.frame = CGRect(x:(itemWidth*3), y:90+(itemHeight*6)-(itemHeight/2), width:(itemWidth/2), height:itemHeight/2)
//        txtP5P2_2.layer.borderWidth = 1
//        txtP5P2_2.textAlignment = NSTextAlignment.center
//        self.view.addSubview(txtP5P2_2)

        // Player3
        txtP5P3.frame = CGRect(x:(itemWidth*4)-(itemWidth/2), y:90+(itemHeight*5), width:(itemWidth/2), height:itemHeight)
        txtP5P3.layer.borderWidth = 1
        txtP5P3.textAlignment = NSTextAlignment.center
        self.view.addSubview(txtP5P3)

        txtP5P3_1.frame = CGRect(x:(itemWidth*4), y:90+(itemHeight*5), width:(itemWidth/2), height:itemHeight)
        txtP5P3_1.layer.borderWidth = 1
        txtP5P3_1.textAlignment = NSTextAlignment.center
        self.view.addSubview(txtP5P3_1)

//        txtP5P3_2.frame = CGRect(x:(itemWidth*4), y:90+(itemHeight*6)-(itemHeight/2), width:(itemWidth/2), height:itemHeight/2)
//        txtP5P3_2.layer.borderWidth = 1
//        txtP5P3_2.textAlignment = NSTextAlignment.center
//        self.view.addSubview(txtP5P3_2)
        
        // Player4
        txtP5P4.frame = CGRect(x:(itemWidth*5)-(itemWidth/2), y:90+(itemHeight*5), width:(itemWidth/2), height:itemHeight)
        txtP5P4.layer.borderWidth = 1
        txtP5P4.textAlignment = NSTextAlignment.center
        self.view.addSubview(txtP5P4)

        txtP5P4_1.frame = CGRect(x:(itemWidth*5), y:90+(itemHeight*5), width:(itemWidth/2), height:itemHeight)
        txtP5P4_1.layer.borderWidth = 1
        txtP5P4_1.textAlignment = NSTextAlignment.center
        self.view.addSubview(txtP5P4_1)

//        txtP5P4_2.frame = CGRect(x:(itemWidth*5), y:90+(itemHeight*6)-(itemHeight/2), width:(itemWidth/2), height:itemHeight/2)
//        txtP5P4_2.layer.borderWidth = 1
//        txtP5P4_2.textAlignment = NSTextAlignment.center
//        self.view.addSubview(txtP5P4_2)
        
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
        
        // Player1
        txtP6P1.frame = CGRect(x:(itemWidth*2)-(itemWidth/2), y:90+(itemHeight*6), width:(itemWidth/2), height:itemHeight)
        txtP6P1.layer.borderWidth = 1
        txtP6P1.textAlignment = NSTextAlignment.center
        self.view.addSubview(txtP6P1)

        txtP6P1_1.frame = CGRect(x:(itemWidth*2), y:90+(itemHeight*6), width:(itemWidth/2), height:itemHeight)
        txtP6P1_1.layer.borderWidth = 1
        txtP6P1_1.textAlignment = NSTextAlignment.center
        self.view.addSubview(txtP6P1_1)

//        txtP6P1_2.frame = CGRect(x:(itemWidth*2), y:90+(itemHeight*7)-(itemHeight/2), width:(itemWidth/2), height:itemHeight/2)
//        txtP6P1_2.layer.borderWidth = 1
//        txtP6P1_2.textAlignment = NSTextAlignment.center
//        self.view.addSubview(txtP6P1_2)
        
        // Player2
        txtP6P2.frame = CGRect(x:(itemWidth*3)-(itemWidth/2), y:90+(itemHeight*6), width:(itemWidth/2), height:itemHeight)
        txtP6P2.layer.borderWidth = 1
        txtP6P2.textAlignment = NSTextAlignment.center
        self.view.addSubview(txtP6P2)

        txtP6P2_1.frame = CGRect(x:(itemWidth*3), y:90+(itemHeight*6), width:(itemWidth/2), height:itemHeight)
        txtP6P2_1.layer.borderWidth = 1
        txtP6P2_1.textAlignment = NSTextAlignment.center
        self.view.addSubview(txtP6P2_1)

//        txtP6P2_2.frame = CGRect(x:(itemWidth*3), y:90+(itemHeight*7)-(itemHeight/2), width:(itemWidth/2), height:itemHeight/2)
//        txtP6P2_2.layer.borderWidth = 1
//        txtP6P2_2.textAlignment = NSTextAlignment.center
//        self.view.addSubview(txtP6P2_2)

        // Player3
        txtP6P3.frame = CGRect(x:(itemWidth*4)-(itemWidth/2), y:90+(itemHeight*6), width:(itemWidth/2), height:itemHeight)
        txtP6P3.layer.borderWidth = 1
        txtP6P3.textAlignment = NSTextAlignment.center
        self.view.addSubview(txtP6P3)

        txtP6P3_1.frame = CGRect(x:(itemWidth*4), y:90+(itemHeight*6), width:(itemWidth/2), height:itemHeight)
        txtP6P3_1.layer.borderWidth = 1
        txtP6P3_1.textAlignment = NSTextAlignment.center
        self.view.addSubview(txtP6P3_1)

//        txtP6P3_2.frame = CGRect(x:(itemWidth*4), y:90+(itemHeight*7)-(itemHeight/2), width:(itemWidth/2), height:itemHeight/2)
//        txtP6P3_2.layer.borderWidth = 1
//        txtP6P3_2.textAlignment = NSTextAlignment.center
//        self.view.addSubview(txtP6P3_2)
        
        // Player4
        txtP6P4.frame = CGRect(x:(itemWidth*5)-(itemWidth/2), y:90+(itemHeight*6), width:(itemWidth/2), height:itemHeight)
        txtP6P4.layer.borderWidth = 1
        txtP6P4.textAlignment = NSTextAlignment.center
        self.view.addSubview(txtP6P4)

        txtP6P4_1.frame = CGRect(x:(itemWidth*5), y:90+(itemHeight*6), width:(itemWidth/2), height:itemHeight)
        txtP6P4_1.layer.borderWidth = 1
        txtP6P4_1.textAlignment = NSTextAlignment.center
        self.view.addSubview(txtP6P4_1)

//        txtP6P4_2.frame = CGRect(x:(itemWidth*5), y:90+(itemHeight*7)-(itemHeight/2), width:(itemWidth/2), height:itemHeight/2)
//        txtP6P4_2.layer.borderWidth = 1
//        txtP6P4_2.textAlignment = NSTextAlignment.center
//        self.view.addSubview(txtP6P4_2)
        
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
        
        // Player1
        txtP7P1.frame = CGRect(x:(itemWidth*2)-(itemWidth/2), y:90+(itemHeight*7), width:(itemWidth/2), height:itemHeight)
        txtP7P1.layer.borderWidth = 1
        txtP7P1.textAlignment = NSTextAlignment.center
        self.view.addSubview(txtP7P1)

        txtP7P1_1.frame = CGRect(x:(itemWidth*2), y:90+(itemHeight*7), width:(itemWidth/2), height:itemHeight)
        txtP7P1_1.layer.borderWidth = 1
        txtP7P1_1.textAlignment = NSTextAlignment.center
        self.view.addSubview(txtP7P1_1)

//        txtP7P1_2.frame = CGRect(x:(itemWidth*2), y:90+(itemHeight*8)-(itemHeight/2), width:(itemWidth/2), height:itemHeight/2)
//        txtP7P1_2.layer.borderWidth = 1
//        txtP7P1_2.textAlignment = NSTextAlignment.center
//        self.view.addSubview(txtP7P1_2)
        
        // Player2
        txtP7P2.frame = CGRect(x:(itemWidth*3)-(itemWidth/2), y:90+(itemHeight*7), width:(itemWidth/2), height:itemHeight)
        txtP7P2.layer.borderWidth = 1
        txtP7P2.textAlignment = NSTextAlignment.center
        self.view.addSubview(txtP7P2)

        txtP7P2_1.frame = CGRect(x:(itemWidth*3), y:90+(itemHeight*7), width:(itemWidth/2), height:itemHeight)
        txtP7P2_1.layer.borderWidth = 1
        txtP7P2_1.textAlignment = NSTextAlignment.center
        self.view.addSubview(txtP7P2_1)

//        txtP7P2_2.frame = CGRect(x:(itemWidth*3), y:90+(itemHeight*8)-(itemHeight/2), width:(itemWidth/2), height:itemHeight/2)
//        txtP7P2_2.layer.borderWidth = 1
//        txtP7P2_2.textAlignment = NSTextAlignment.center
//        self.view.addSubview(txtP7P2_2)

        // Player3
        txtP7P3.frame = CGRect(x:(itemWidth*4)-(itemWidth/2), y:90+(itemHeight*7), width:(itemWidth/2), height:itemHeight)
        txtP7P3.layer.borderWidth = 1
        txtP7P3.textAlignment = NSTextAlignment.center
        self.view.addSubview(txtP7P3)

        txtP7P3_1.frame = CGRect(x:(itemWidth*4), y:90+(itemHeight*7), width:(itemWidth/2), height:itemHeight)
        txtP7P3_1.layer.borderWidth = 1
        txtP7P3_1.textAlignment = NSTextAlignment.center
        self.view.addSubview(txtP7P3_1)

//        txtP7P3_2.frame = CGRect(x:(itemWidth*4), y:90+(itemHeight*8)-(itemHeight/2), width:(itemWidth/2), height:itemHeight/2)
//        txtP7P3_2.layer.borderWidth = 1
//        txtP7P3_2.textAlignment = NSTextAlignment.center
//        self.view.addSubview(txtP7P3_2)
        
        // Player4
        txtP7P4.frame = CGRect(x:(itemWidth*5)-(itemWidth/2), y:90+(itemHeight*7), width:(itemWidth/2), height:itemHeight)
        txtP7P4.layer.borderWidth = 1
        txtP7P4.textAlignment = NSTextAlignment.center
        self.view.addSubview(txtP7P4)

        txtP7P4_1.frame = CGRect(x:(itemWidth*5), y:90+(itemHeight*7), width:(itemWidth/2), height:itemHeight)
        txtP7P4_1.layer.borderWidth = 1
        txtP7P4_1.textAlignment = NSTextAlignment.center
        self.view.addSubview(txtP7P4_1)

//        txtP7P4_2.frame = CGRect(x:(itemWidth*5), y:90+(itemHeight*8)-(itemHeight/2), width:(itemWidth/2), height:itemHeight/2)
//        txtP7P4_2.layer.borderWidth = 1
//        txtP7P4_2.textAlignment = NSTextAlignment.center
//        self.view.addSubview(txtP7P4_2)
        
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
        
        // Player1
        txtP8P1.frame = CGRect(x:(itemWidth*2)-(itemWidth/2), y:90+(itemHeight*8), width:(itemWidth/2), height:itemHeight)
        txtP8P1.layer.borderWidth = 1
        txtP8P1.textAlignment = NSTextAlignment.center
        self.view.addSubview(txtP8P1)

        txtP8P1_1.frame = CGRect(x:(itemWidth*2), y:90+(itemHeight*8), width:(itemWidth/2), height:itemHeight)
        txtP8P1_1.layer.borderWidth = 1
        txtP8P1_1.textAlignment = NSTextAlignment.center
        self.view.addSubview(txtP8P1_1)

//        txtP8P1_2.frame = CGRect(x:(itemWidth*2), y:90+(itemHeight*9)-(itemHeight/2), width:(itemWidth/2), height:itemHeight/2)
//        txtP8P1_2.layer.borderWidth = 1
//        txtP8P1_2.textAlignment = NSTextAlignment.center
//        self.view.addSubview(txtP8P1_2)
        
        // Player2
        txtP8P2.frame = CGRect(x:(itemWidth*3)-(itemWidth/2), y:90+(itemHeight*8), width:(itemWidth/2), height:itemHeight)
        txtP8P2.layer.borderWidth = 1
        txtP8P2.textAlignment = NSTextAlignment.center
        self.view.addSubview(txtP8P2)

        txtP8P2_1.frame = CGRect(x:(itemWidth*3), y:90+(itemHeight*8), width:(itemWidth/2), height:itemHeight)
        txtP8P2_1.layer.borderWidth = 1
        txtP8P2_1.textAlignment = NSTextAlignment.center
        self.view.addSubview(txtP8P2_1)

//        txtP8P2_2.frame = CGRect(x:(itemWidth*3), y:90+(itemHeight*9)-(itemHeight/2), width:(itemWidth/2), height:itemHeight/2)
//        txtP8P2_2.layer.borderWidth = 1
//        txtP8P2_2.textAlignment = NSTextAlignment.center
//        self.view.addSubview(txtP8P2_2)
        
        // Player3
        txtP8P3.frame = CGRect(x:(itemWidth*4)-(itemWidth/2), y:90+(itemHeight*8), width:(itemWidth/2), height:itemHeight)
        txtP8P3.layer.borderWidth = 1
        txtP8P3.textAlignment = NSTextAlignment.center
        self.view.addSubview(txtP8P3)

        txtP8P3_1.frame = CGRect(x:(itemWidth*4), y:90+(itemHeight*8), width:(itemWidth/2), height:itemHeight)
        txtP8P3_1.layer.borderWidth = 1
        txtP8P3_1.textAlignment = NSTextAlignment.center
        self.view.addSubview(txtP8P3_1)

//        txtP8P3_2.frame = CGRect(x:(itemWidth*4), y:90+(itemHeight*9)-(itemHeight/2), width:(itemWidth/2), height:itemHeight/2)
//        txtP8P3_2.layer.borderWidth = 1
//        txtP8P3_2.textAlignment = NSTextAlignment.center
//        self.view.addSubview(txtP8P3_2)
        
        // Player4
        txtP8P4.frame = CGRect(x:(itemWidth*5)-(itemWidth/2), y:90+(itemHeight*8), width:(itemWidth/2), height:itemHeight)
        txtP8P4.layer.borderWidth = 1
        txtP8P4.textAlignment = NSTextAlignment.center
        self.view.addSubview(txtP8P4)

        txtP8P4_1.frame = CGRect(x:(itemWidth*5), y:90+(itemHeight*8), width:(itemWidth/2), height:itemHeight)
        txtP8P4_1.layer.borderWidth = 1
        txtP8P4_1.textAlignment = NSTextAlignment.center
        self.view.addSubview(txtP8P4_1)

//        txtP8P4_2.frame = CGRect(x:(itemWidth*5), y:90+(itemHeight*9)-(itemHeight/2), width:(itemWidth/2), height:itemHeight/2)
//        txtP8P4_2.layer.borderWidth = 1
//        txtP8P4_2.textAlignment = NSTextAlignment.center
//        self.view.addSubview(txtP8P4_2)
        
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
        
        // Player1
        txtP9P1.frame = CGRect(x:(itemWidth*2)-(itemWidth/2), y:90+(itemHeight*9), width:(itemWidth/2), height:itemHeight)
        txtP9P1.layer.borderWidth = 1
        txtP9P1.textAlignment = NSTextAlignment.center
        self.view.addSubview(txtP9P1)

        txtP9P1_1.frame = CGRect(x:(itemWidth*2), y:90+(itemHeight*9), width:(itemWidth/2), height:itemHeight)
        txtP9P1_1.layer.borderWidth = 1
        txtP9P1_1.textAlignment = NSTextAlignment.center
        self.view.addSubview(txtP9P1_1)

//        txtP9P1_2.frame = CGRect(x:(itemWidth*2), y:90+(itemHeight*10)-(itemHeight/2), width:(itemWidth/2), height:itemHeight/2)
//        txtP9P1_2.layer.borderWidth = 1
//        txtP9P1_2.textAlignment = NSTextAlignment.center
//        self.view.addSubview(txtP9P1_2)
        
        // Player2
        txtP9P2.frame = CGRect(x:(itemWidth*3)-(itemWidth/2), y:90+(itemHeight*9), width:(itemWidth/2), height:itemHeight)
        txtP9P2.layer.borderWidth = 1
        txtP9P2.textAlignment = NSTextAlignment.center
        self.view.addSubview(txtP9P2)

        txtP9P2_1.frame = CGRect(x:(itemWidth*3), y:90+(itemHeight*9), width:(itemWidth/2), height:itemHeight)
        txtP9P2_1.layer.borderWidth = 1
        txtP9P2_1.textAlignment = NSTextAlignment.center
        self.view.addSubview(txtP9P2_1)

//        txtP9P2_2.frame = CGRect(x:(itemWidth*3), y:90+(itemHeight*10)-(itemHeight/2), width:(itemWidth/2), height:itemHeight/2)
//        txtP9P2_2.layer.borderWidth = 1
//        txtP9P2_2.textAlignment = NSTextAlignment.center
//        self.view.addSubview(txtP9P2_2)
        
        // Player3
        txtP9P3.frame = CGRect(x:(itemWidth*4)-(itemWidth/2), y:90+(itemHeight*9), width:(itemWidth/2), height:itemHeight)
        txtP9P3.layer.borderWidth = 1
        txtP9P3.textAlignment = NSTextAlignment.center
        self.view.addSubview(txtP9P3)

        txtP9P3_1.frame = CGRect(x:(itemWidth*4), y:90+(itemHeight*9), width:(itemWidth/2), height:itemHeight)
        txtP9P3_1.layer.borderWidth = 1
        txtP9P3_1.textAlignment = NSTextAlignment.center
        self.view.addSubview(txtP9P3_1)

//        txtP9P3_2.frame = CGRect(x:(itemWidth*4), y:90+(itemHeight*10)-(itemHeight/2), width:(itemWidth/2), height:itemHeight/2)
//        txtP9P3_2.layer.borderWidth = 1
//        txtP9P3_2.textAlignment = NSTextAlignment.center
//        self.view.addSubview(txtP9P3_2)
        
        // Player4
        txtP9P4.frame = CGRect(x:(itemWidth*5)-(itemWidth/2), y:90+(itemHeight*9), width:(itemWidth/2), height:itemHeight)
        txtP9P4.layer.borderWidth = 1
        txtP9P4.textAlignment = NSTextAlignment.center
        self.view.addSubview(txtP9P4)

        txtP9P4_1.frame = CGRect(x:(itemWidth*5), y:90+(itemHeight*9), width:(itemWidth/2), height:itemHeight)
        txtP9P4_1.layer.borderWidth = 1
        txtP9P4_1.textAlignment = NSTextAlignment.center
        self.view.addSubview(txtP9P4_1)

//        txtP9P4_2.frame = CGRect(x:(itemWidth*5), y:90+(itemHeight*10)-(itemHeight/2), width:(itemWidth/2), height:itemHeight/2)
//        txtP9P4_2.layer.borderWidth = 1
//        txtP9P4_2.textAlignment = NSTextAlignment.center
//        self.view.addSubview(txtP9P4_2)
        
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
        
        // Player1
        txtP10P1.frame = CGRect(x:(itemWidth*2)-(itemWidth/2), y:90+(itemHeight*10), width:(itemWidth/2), height:itemHeight)
        txtP10P1.layer.borderWidth = 1
        txtP10P1.textAlignment = NSTextAlignment.center
        self.view.addSubview(txtP10P1)

        txtP10P1_1.frame = CGRect(x:(itemWidth*2), y:90+(itemHeight*10), width:(itemWidth/2), height:itemHeight)
        txtP10P1_1.layer.borderWidth = 1
        txtP10P1_1.textAlignment = NSTextAlignment.center
        self.view.addSubview(txtP10P1_1)

//        txtP10P1_2.frame = CGRect(x:(itemWidth*2), y:90+(itemHeight*11)-(itemHeight/2), width:(itemWidth/2), height:itemHeight/2)
//        txtP10P1_2.layer.borderWidth = 1
//        txtP10P1_2.textAlignment = NSTextAlignment.center
//        self.view.addSubview(txtP10P1_2)
        
        // Player2
        txtP10P2.frame = CGRect(x:(itemWidth*3)-(itemWidth/2), y:90+(itemHeight*10), width:(itemWidth/2), height:itemHeight)
        txtP10P2.layer.borderWidth = 1
        txtP10P2.textAlignment = NSTextAlignment.center
        self.view.addSubview(txtP10P2)

        txtP10P2_1.frame = CGRect(x:(itemWidth*3), y:90+(itemHeight*10), width:(itemWidth/2), height:itemHeight)
        txtP10P2_1.layer.borderWidth = 1
        txtP10P2_1.textAlignment = NSTextAlignment.center
        self.view.addSubview(txtP10P2_1)

//        txtP10P2_2.frame = CGRect(x:(itemWidth*3), y:90+(itemHeight*11)-(itemHeight/2), width:(itemWidth/2), height:itemHeight/2)
//        txtP10P2_2.layer.borderWidth = 1
//        txtP10P2_2.textAlignment = NSTextAlignment.center
//        self.view.addSubview(txtP10P2_2)
        
        // Player3
        txtP10P3.frame = CGRect(x:(itemWidth*4)-(itemWidth/2), y:90+(itemHeight*10), width:(itemWidth/2), height:itemHeight)
        txtP10P3.layer.borderWidth = 1
        txtP10P3.textAlignment = NSTextAlignment.center
        self.view.addSubview(txtP10P3)

        txtP10P3_1.frame = CGRect(x:(itemWidth*4), y:90+(itemHeight*10), width:(itemWidth/2), height:itemHeight)
        txtP10P3_1.layer.borderWidth = 1
        txtP10P3_1.textAlignment = NSTextAlignment.center
        self.view.addSubview(txtP10P3_1)

//        txtP10P3_2.frame = CGRect(x:(itemWidth*4), y:90+(itemHeight*11)-(itemHeight/2), width:(itemWidth/2), height:itemHeight/2)
//        txtP10P3_2.layer.borderWidth = 1
//        txtP10P3_2.textAlignment = NSTextAlignment.center
//        self.view.addSubview(txtP10P3_2)
        
        // Player4
        txtP10P4.frame = CGRect(x:(itemWidth*5)-(itemWidth/2), y:90+(itemHeight*10), width:(itemWidth/2), height:itemHeight)
        txtP10P4.layer.borderWidth = 1
        txtP10P4.textAlignment = NSTextAlignment.center
        self.view.addSubview(txtP10P4)

        txtP10P4_1.frame = CGRect(x:(itemWidth*5), y:90+(itemHeight*10), width:(itemWidth/2), height:itemHeight)
        txtP10P4_1.layer.borderWidth = 1
        txtP10P4_1.textAlignment = NSTextAlignment.center
        self.view.addSubview(txtP10P4_1)

//        txtP10P4_2.frame = CGRect(x:(itemWidth*5), y:90+(itemHeight*11)-(itemHeight/2), width:(itemWidth/2), height:itemHeight/2)
//        txtP10P4_2.layer.borderWidth = 1
//        txtP10P4_2.textAlignment = NSTextAlignment.center
//        self.view.addSubview(txtP10P4_2)
        
    }
    
    // < ボタンを押下した時の処理
    @IBAction func btnBack(_ sender: Any)
    {
        if m_isOut {
            saveScore(m_isOut)
            // Out表示中ならコース画面へ遷移
            self.performSegue(withIdentifier: "toGolfInputScore", sender: nil)
        }
        else {
            saveScore(m_isOut)
            m_isOut = true
            loadScore(m_isOut)
        }
    }

    // > ボタンを押下した時の処理
    @IBAction func btnForward(_ sender: Any)
    {
        if m_isOut {
            saveScore(m_isOut)
            m_isOut = false
            loadScore(m_isOut)
        }
        else {
            saveScore(m_isOut)
            // In表示中なら合計画面へ遷移
            self.performSegue(withIdentifier: "toGolfInputScore3", sender: nil)
        }
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
        saveScore(m_isOut)
        // ViewControllerを表示する
        self.performSegue(withIdentifier: "toViewController", sender: nil)
    }
    
    // Enter実施時にキーボードを閉じる
    func textFieldShouldReturn(_ textField: UITextField) -> Bool
    {
        // キーボードを閉じる
        textField.resignFirstResponder()
        // 合計値を更新する
        updateTotal()
        return true
    }
    
    // TextField以外の部分をタッチ時にキーボードを閉じる
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?)
    {
        // 合計値を更新する
        updateTotal()
        self.view.endEditing(true)
    }

    // 合計値を更新する
    func updateTotal() {
        // パー
        var total: Int = 0
        var input = Int(txtPar1.text!.description)
        if (nil != input) {
            total = total + input!
        }
        input = Int(txtPar2.text!.description)
        if (nil != input) {
            total = total + input!
        }
        input = Int(txtPar3.text!.description)
        if (nil != input) {
            total = total + input!
        }
        input = Int(txtPar4.text!.description)
        if (nil != input) {
            total = total + input!
        }
        input = Int(txtPar5.text!.description)
        if (nil != input) {
            total = total + input!
        }
        input = Int(txtPar6.text!.description)
        if (nil != input) {
            total = total + input!
        }
        input = Int(txtPar7.text!.description)
        if (nil != input) {
            total = total + input!
        }
        input = Int(txtPar8.text!.description)
        if (nil != input) {
            total = total + input!
        }
        input = Int(txtPar9.text!.description)
        if (nil != input) {
            total = total + input!
        }
        txtPar10.text = total.description
        
        // 本人のスコア=================================
        total = 0
        input = Int(txtP1P1.text!.description)
        if (nil != input) {
            total = total + input!
        }
        input = Int(txtP2P1.text!.description)
        if (nil != input) {
            total = total + input!
        }
        input = Int(txtP3P1.text!.description)
        if (nil != input) {
            total = total + input!
        }
        input = Int(txtP4P1.text!.description)
        if (nil != input) {
            total = total + input!
        }
        input = Int(txtP5P1.text!.description)
        if (nil != input) {
            total = total + input!
        }
        input = Int(txtP6P1.text!.description)
        if (nil != input) {
            total = total + input!
        }
        input = Int(txtP7P1.text!.description)
        if (nil != input) {
            total = total + input!
        }
        input = Int(txtP8P1.text!.description)
        if (nil != input) {
            total = total + input!
        }
        input = Int(txtP9P1.text!.description)
        if (nil != input) {
            total = total + input!
        }
        txtP10P1.text = total.description

        // 本人のスコア（PAD）
        total = 0
        input = Int(txtP1P1_1.text!.description)
        if (nil != input) {
            total = total + input!
        }
        input = Int(txtP2P1_1.text!.description)
        if (nil != input) {
            total = total + input!
        }
        input = Int(txtP3P1_1.text!.description)
        if (nil != input) {
            total = total + input!
        }
        input = Int(txtP4P1_1.text!.description)
        if (nil != input) {
            total = total + input!
        }
        input = Int(txtP5P1_1.text!.description)
        if (nil != input) {
            total = total + input!
        }
        input = Int(txtP6P1_1.text!.description)
        if (nil != input) {
            total = total + input!
        }
        input = Int(txtP7P1_1.text!.description)
        if (nil != input) {
            total = total + input!
        }
        input = Int(txtP8P1_1.text!.description)
        if (nil != input) {
            total = total + input!
        }
        input = Int(txtP9P1_1.text!.description)
        if (nil != input) {
            total = total + input!
        }
        txtP10P1_1.text = total.description

#if false
        // 本人のスコア(ACT)
        total = 0
        input = Int(txtP1P1_2.text!.description)
        if (nil != input) {
            total = total + input!
        }
        input = Int(txtP2P1_2.text!.description)
        if (nil != input) {
            total = total + input!
        }
        input = Int(txtP3P1_2.text!.description)
        if (nil != input) {
            total = total + input!
        }
        input = Int(txtP4P1_2.text!.description)
        if (nil != input) {
            total = total + input!
        }
        input = Int(txtP5P1_2.text!.description)
        if (nil != input) {
            total = total + input!
        }
        input = Int(txtP6P1_2.text!.description)
        if (nil != input) {
            total = total + input!
        }
        input = Int(txtP7P1_2.text!.description)
        if (nil != input) {
            total = total + input!
        }
        input = Int(txtP8P1_2.text!.description)
        if (nil != input) {
            total = total + input!
        }
        input = Int(txtP9P1_2.text!.description)
        if (nil != input) {
            total = total + input!
        }
        txtP10P1_2.text = total.description
#endif

        // 二人目のスコア=================================
        total = 0
        input = Int(txtP1P2.text!.description)
        if (nil != input) {
            total = total + input!
        }
        input = Int(txtP2P2.text!.description)
        if (nil != input) {
            total = total + input!
        }
        input = Int(txtP3P2.text!.description)
        if (nil != input) {
            total = total + input!
        }
        input = Int(txtP4P2.text!.description)
        if (nil != input) {
            total = total + input!
        }
        input = Int(txtP5P2.text!.description)
        if (nil != input) {
            total = total + input!
        }
        input = Int(txtP6P2.text!.description)
        if (nil != input) {
            total = total + input!
        }
        input = Int(txtP7P2.text!.description)
        if (nil != input) {
            total = total + input!
        }
        input = Int(txtP8P2.text!.description)
        if (nil != input) {
            total = total + input!
        }
        input = Int(txtP9P2.text!.description)
        if (nil != input) {
            total = total + input!
        }
        txtP10P2.text = total.description

        // 二人目のスコア（PAD）
        total = 0
        input = Int(txtP1P2_1.text!.description)
        if (nil != input) {
            total = total + input!
        }
        input = Int(txtP2P2_1.text!.description)
        if (nil != input) {
            total = total + input!
        }
        input = Int(txtP3P2_1.text!.description)
        if (nil != input) {
            total = total + input!
        }
        input = Int(txtP4P2_1.text!.description)
        if (nil != input) {
            total = total + input!
        }
        input = Int(txtP5P2_1.text!.description)
        if (nil != input) {
            total = total + input!
        }
        input = Int(txtP6P2_1.text!.description)
        if (nil != input) {
            total = total + input!
        }
        input = Int(txtP7P2_1.text!.description)
        if (nil != input) {
            total = total + input!
        }
        input = Int(txtP8P2_1.text!.description)
        if (nil != input) {
            total = total + input!
        }
        input = Int(txtP9P2_1.text!.description)
        if (nil != input) {
            total = total + input!
        }
        txtP10P2_1.text = total.description

#if false
        // 二人目のスコア(ACT)
        total = 0
        input = Int(txtP1P2_2.text!.description)
        if (nil != input) {
            total = total + input!
        }
        input = Int(txtP2P2_2.text!.description)
        if (nil != input) {
            total = total + input!
        }
        input = Int(txtP3P2_2.text!.description)
        if (nil != input) {
            total = total + input!
        }
        input = Int(txtP4P2_2.text!.description)
        if (nil != input) {
            total = total + input!
        }
        input = Int(txtP5P2_2.text!.description)
        if (nil != input) {
            total = total + input!
        }
        input = Int(txtP6P2_2.text!.description)
        if (nil != input) {
            total = total + input!
        }
        input = Int(txtP7P2_2.text!.description)
        if (nil != input) {
            total = total + input!
        }
        input = Int(txtP8P2_2.text!.description)
        if (nil != input) {
            total = total + input!
        }
        input = Int(txtP9P2_2.text!.description)
        if (nil != input) {
            total = total + input!
        }
        txtP10P2_2.text = total.description
#endif

        // 三人目のスコア=================================
        total = 0
        input = Int(txtP1P3.text!.description)
        if (nil != input) {
            total = total + input!
        }
        input = Int(txtP2P3.text!.description)
        if (nil != input) {
            total = total + input!
        }
        input = Int(txtP3P3.text!.description)
        if (nil != input) {
            total = total + input!
        }
        input = Int(txtP4P3.text!.description)
        if (nil != input) {
            total = total + input!
        }
        input = Int(txtP5P3.text!.description)
        if (nil != input) {
            total = total + input!
        }
        input = Int(txtP6P3.text!.description)
        if (nil != input) {
            total = total + input!
        }
        input = Int(txtP7P3.text!.description)
        if (nil != input) {
            total = total + input!
        }
        input = Int(txtP8P3.text!.description)
        if (nil != input) {
            total = total + input!
        }
        input = Int(txtP9P3.text!.description)
        if (nil != input) {
            total = total + input!
        }
        txtP10P3.text = total.description

        // 三人目のスコア（PAD）
        total = 0
        input = Int(txtP1P3_1.text!.description)
        if (nil != input) {
            total = total + input!
        }
        input = Int(txtP2P3_1.text!.description)
        if (nil != input) {
            total = total + input!
        }
        input = Int(txtP3P3_1.text!.description)
        if (nil != input) {
            total = total + input!
        }
        input = Int(txtP4P3_1.text!.description)
        if (nil != input) {
            total = total + input!
        }
        input = Int(txtP5P3_1.text!.description)
        if (nil != input) {
            total = total + input!
        }
        input = Int(txtP6P3_1.text!.description)
        if (nil != input) {
            total = total + input!
        }
        input = Int(txtP7P3_1.text!.description)
        if (nil != input) {
            total = total + input!
        }
        input = Int(txtP8P3_1.text!.description)
        if (nil != input) {
            total = total + input!
        }
        input = Int(txtP9P3_1.text!.description)
        if (nil != input) {
            total = total + input!
        }
        txtP10P3_1.text = total.description

#if false
        // 三人目のスコア(ACT)
        total = 0
        input = Int(txtP1P3_2.text!.description)
        if (nil != input) {
            total = total + input!
        }
        input = Int(txtP2P3_2.text!.description)
        if (nil != input) {
            total = total + input!
        }
        input = Int(txtP3P3_2.text!.description)
        if (nil != input) {
            total = total + input!
        }
        input = Int(txtP4P3_2.text!.description)
        if (nil != input) {
            total = total + input!
        }
        input = Int(txtP5P3_2.text!.description)
        if (nil != input) {
            total = total + input!
        }
        input = Int(txtP6P3_2.text!.description)
        if (nil != input) {
            total = total + input!
        }
        input = Int(txtP7P3_2.text!.description)
        if (nil != input) {
            total = total + input!
        }
        input = Int(txtP8P3_2.text!.description)
        if (nil != input) {
            total = total + input!
        }
        input = Int(txtP9P3_2.text!.description)
        if (nil != input) {
            total = total + input!
        }
        txtP10P3_2.text = total.description
#endif

        // 四人目のスコア=================================
        total = 0
        input = Int(txtP1P4.text!.description)
        if (nil != input) {
            total = total + input!
        }
        input = Int(txtP2P4.text!.description)
        if (nil != input) {
            total = total + input!
        }
        input = Int(txtP3P4.text!.description)
        if (nil != input) {
            total = total + input!
        }
        input = Int(txtP4P4.text!.description)
        if (nil != input) {
            total = total + input!
        }
        input = Int(txtP5P4.text!.description)
        if (nil != input) {
            total = total + input!
        }
        input = Int(txtP6P4.text!.description)
        if (nil != input) {
            total = total + input!
        }
        input = Int(txtP7P4.text!.description)
        if (nil != input) {
            total = total + input!
        }
        input = Int(txtP8P4.text!.description)
        if (nil != input) {
            total = total + input!
        }
        input = Int(txtP9P4.text!.description)
        if (nil != input) {
            total = total + input!
        }
        txtP10P4.text = total.description

        // 四人目のスコア（PAD）
        total = 0
        input = Int(txtP1P4_1.text!.description)
        if (nil != input) {
            total = total + input!
        }
        input = Int(txtP2P4_1.text!.description)
        if (nil != input) {
            total = total + input!
        }
        input = Int(txtP3P4_1.text!.description)
        if (nil != input) {
            total = total + input!
        }
        input = Int(txtP4P4_1.text!.description)
        if (nil != input) {
            total = total + input!
        }
        input = Int(txtP5P4_1.text!.description)
        if (nil != input) {
            total = total + input!
        }
        input = Int(txtP6P4_1.text!.description)
        if (nil != input) {
            total = total + input!
        }
        input = Int(txtP7P4_1.text!.description)
        if (nil != input) {
            total = total + input!
        }
        input = Int(txtP8P4_1.text!.description)
        if (nil != input) {
            total = total + input!
        }
        input = Int(txtP9P4_1.text!.description)
        if (nil != input) {
            total = total + input!
        }
        txtP10P4_1.text = total.description

#if false
        // 四人目のスコア(ACT)
        total = 0
        input = Int(txtP1P4_2.text!.description)
        if (nil != input) {
            total = total + input!
        }
        input = Int(txtP2P4_2.text!.description)
        if (nil != input) {
            total = total + input!
        }
        input = Int(txtP3P4_2.text!.description)
        if (nil != input) {
            total = total + input!
        }
        input = Int(txtP4P4_2.text!.description)
        if (nil != input) {
            total = total + input!
        }
        input = Int(txtP5P4_2.text!.description)
        if (nil != input) {
            total = total + input!
        }
        input = Int(txtP6P4_2.text!.description)
        if (nil != input) {
            total = total + input!
        }
        input = Int(txtP7P4_2.text!.description)
        if (nil != input) {
            total = total + input!
        }
        input = Int(txtP8P4_2.text!.description)
        if (nil != input) {
            total = total + input!
        }
        input = Int(txtP9P4_2.text!.description)
        if (nil != input) {
            total = total + input!
        }
        txtP10P4_2.text = total.description
#endif
    }

    // テキストフィールドの初期化
    func clearTextFiled() {
        // スコア入力 Line1
        txtPar1.text = ""
        txtP1P1.text = ""
        txtP1P1_1.text = ""
//        txtP1P1_2.text = ""
        txtP1P2.text = ""
        txtP1P2_1.text = ""
//        txtP1P2_2.text = ""
        txtP1P3.text = ""
        txtP1P3_1.text = ""
//        txtP1P3_2.text = ""
        txtP1P4.text = ""
        txtP1P4_1.text = ""
//        txtP1P4_2.text = ""
        
        // スコア入力 Line2
        txtPar2.text = ""
        txtP2P1.text = ""
        txtP2P1_1.text = ""
//        txtP2P1_2.text = ""
        txtP2P2.text = ""
        txtP2P2_1.text = ""
//        txtP2P2_2.text = ""
        txtP2P3.text = ""
        txtP2P3_1.text = ""
//        txtP2P3_2.text = ""
        txtP2P4.text = ""
        txtP2P4_1.text = ""
//        txtP2P4_2.text = ""
        
        // スコア入力 Line3
        txtPar3.text = ""
        txtP3P1.text = ""
        txtP3P1_1.text = ""
//        txtP3P1_2.text = ""
        txtP3P2.text = ""
        txtP3P2_1.text = ""
//        txtP3P2_2.text = ""
        txtP3P3.text = ""
        txtP3P3_1.text = ""
//        txtP3P3_2.text = ""
        txtP3P4.text = ""
        txtP3P4_1.text = ""
//        txtP3P4_2.text = ""

        // スコア入力 Line4
        txtPar4.text = ""
        txtP4P1.text = ""
        txtP4P1_1.text = ""
//        txtP4P1_2.text = ""
        txtP4P2.text = ""
        txtP4P2_1.text = ""
//        txtP4P2_2.text = ""
        txtP4P3.text = ""
        txtP4P3_1.text = ""
//        txtP4P3_2.text = ""
        txtP4P4.text = ""
        txtP4P4_1.text = ""
//        txtP4P4_2.text = ""

        // スコア入力 Line5
        txtPar5.text = ""
        txtP5P1.text = ""
        txtP5P1_1.text = ""
//        txtP5P1_2.text = ""
        txtP5P2.text = ""
        txtP5P2_1.text = ""
//        txtP5P2_2.text = ""
        txtP5P3.text = ""
        txtP5P3_1.text = ""
//        txtP5P3_2.text = ""
        txtP5P4.text = ""
        txtP5P4_1.text = ""
//        txtP5P4_2.text = ""
        
        // スコア入力 Line6
        txtPar6.text = ""
        txtP6P1.text = ""
        txtP6P1_1.text = ""
//        txtP6P1_2.text = ""
        txtP6P2.text = ""
        txtP6P2_1.text = ""
//        txtP6P2_2.text = ""
        txtP6P3.text = ""
        txtP6P3_1.text = ""
//        txtP6P3_2.text = ""
        txtP6P4.text = ""
        txtP6P4_1.text = ""
//        txtP6P4_2.text = ""

        // スコア入力 Line7
        txtPar7.text = ""
        txtP7P1.text = ""
        txtP7P1_1.text = ""
//        txtP7P1_2.text = ""
        txtP7P2.text = ""
        txtP7P2_1.text = ""
//        txtP7P2_2.text = ""
        txtP7P3.text = ""
        txtP7P3_1.text = ""
//        txtP7P3_2.text = ""
        txtP7P4.text = ""
        txtP7P4_1.text = ""
//        txtP7P4_2.text = ""
        
        // スコア入力 Line8
        txtPar8.text = ""
        txtP8P1.text = ""
        txtP8P1_1.text = ""
//        txtP8P1_2.text = ""
        txtP8P2.text = ""
        txtP8P2_1.text = ""
//        txtP8P2_2.text = ""
        txtP8P3.text = ""
        txtP8P3_1.text = ""
//        txtP8P3_2.text = ""
        txtP8P4.text = ""
        txtP8P4_1.text = ""
//        txtP8P4_2.text = ""
        
        // スコア入力 Line9
        txtPar9.text = ""
        txtP9P1.text = ""
        txtP9P1_1.text = ""
//        txtP9P1_2.text = ""
        txtP9P2.text = ""
        txtP9P2_1.text = ""
//        txtP9P2_2.text = ""
        txtP9P3.text = ""
        txtP9P3_1.text = ""
//        txtP9P3_2.text = ""
        txtP9P4.text = ""
        txtP9P4_1.text = ""
//        txtP9P4_2.text = ""
        
        // スコア入力 LineOut
        txtPar10.text = ""
        txtP10P1.text = ""
        txtP10P1_1.text = ""
//        txtP10P1_2.text = ""
        txtP10P2.text = ""
        txtP10P2_1.text = ""
//        txtP10P2_2.text = ""
        txtP10P3.text = ""
        txtP10P3_1.text = ""
//        txtP10P3_2.text = ""
        txtP10P4.text = ""
        txtP10P4_1.text = ""
//        txtP10P4_2.text = ""
    }
    
    // スコア読み込み
    func loadScore(_ isFirst: Bool) {
        
        clearTextFiled()
        // realmからラウンド中データを取得
        let appDelegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate
        let playerData = appDelegate.golfRealmData.getPlayerInfo()
        let roundData = appDelegate.golfRealmData.getRoundData()

        // 名前の読み込み
        lblName1.text = playerData.name
        lblName2.text = roundData.name_2
        lblName3.text = roundData.name_3
        lblName4.text = roundData.name_4

        // スコアの読み込み
        if (isFirst) {
            lblHole1.text = "1"
            lblHole2.text = "2"
            lblHole3.text = "3"
            lblHole4.text = "4"
            lblHole5.text = "5"
            lblHole6.text = "6"
            lblHole7.text = "7"
            lblHole8.text = "8"
            lblHole9.text = "9"

            // パー
            if 0 <= roundData.par_num[0] {
                txtPar1.text = roundData.par_num[0].description
            }
            if 0 <= roundData.par_num[1] {
                txtPar2.text = roundData.par_num[1].description
            }
            if 0 <= roundData.par_num[2] {
                txtPar3.text = roundData.par_num[2].description
            }
            if 0 <= roundData.par_num[3] {
                txtPar4.text = roundData.par_num[3].description
            }
            if 0 <= roundData.par_num[4] {
                txtPar5.text = roundData.par_num[4].description
            }
            if 0 <= roundData.par_num[5] {
                txtPar6.text = roundData.par_num[5].description
            }
            if 0 <= roundData.par_num[6] {
                txtPar7.text = roundData.par_num[6].description
            }
            if 0 <= roundData.par_num[7] {
                txtPar8.text = roundData.par_num[7].description
            }
            if 0 <= roundData.par_num[8] {
                txtPar9.text = roundData.par_num[8].description
            }
            var total:Int = 0
            for i in 0 ..< 9 {
                if 0 <= roundData.par_num[i] {
                    total += roundData.par_num[i]
                }
            }
            txtPar10.text = total.description

            // 自分のスコア
            if 0 <= roundData.score_my[0] {
                txtP1P1.text = roundData.score_my[0].description
            }
            if 0 <= roundData.score_my[1] {
                txtP2P1.text = roundData.score_my[1].description
            }
            if 0 <= roundData.score_my[2] {
                txtP3P1.text = roundData.score_my[2].description
            }
            if 0 <= roundData.score_my[3] {
                txtP4P1.text = roundData.score_my[3].description
            }
            if 0 <= roundData.score_my[4] {
                txtP5P1.text = roundData.score_my[4].description
            }
            if 0 <= roundData.score_my[5] {
                txtP6P1.text = roundData.score_my[5].description
            }
            if 0 <= roundData.score_my[6] {
                txtP7P1.text = roundData.score_my[6].description
            }
            if 0 <= roundData.score_my[7] {
                txtP8P1.text = roundData.score_my[7].description
            }
            if 0 <= roundData.score_my[8] {
                txtP9P1.text = roundData.score_my[8].description
            }
            total = 0
            for i in 0 ..< 9 {
                if 0 <= roundData.score_my[i] {
                    total += roundData.score_my[i]
                }
            }
            txtP10P1.text = total.description
            
            // 自分のスコア(PAD)
            if 0 <= roundData.score_my_pad[0] {
                txtP1P1_1.text = roundData.score_my_pad[0].description
            }
            if 0 <= roundData.score_my_pad[1] {
                txtP2P1_1.text = roundData.score_my_pad[1].description
            }
            if 0 <= roundData.score_my_pad[2] {
                txtP3P1_1.text = roundData.score_my_pad[2].description
            }
            if 0 <= roundData.score_my_pad[3] {
                txtP4P1_1.text = roundData.score_my_pad[3].description
            }
            if 0 <= roundData.score_my_pad[4] {
                txtP5P1_1.text = roundData.score_my_pad[4].description
            }
            if 0 <= roundData.score_my_pad[5] {
                txtP6P1_1.text = roundData.score_my_pad[5].description
            }
            if 0 <= roundData.score_my_pad[6] {
                txtP7P1_1.text = roundData.score_my_pad[6].description
            }
            if 0 <= roundData.score_my_pad[7] {
                txtP8P1_1.text = roundData.score_my_pad[7].description
            }
            if 0 <= roundData.score_my_pad[8] {
                txtP9P1_1.text = roundData.score_my_pad[8].description
            }
            var total_pad:Int = 0
            for i in 0 ..< 9 {
                if 0 <= roundData.score_my_pad[i] {
                    total_pad += roundData.score_my_pad[i]
                }
            }
            txtP10P1_1.text = total_pad.description
            
#if false
            // 自分のスコア(ACT)
            if 0 <= roundData.score_my_act[0] {
                txtP1P1_2.text = roundData.score_my_act[0].description
            }
            if 0 <= roundData.score_my_act[1] {
                txtP2P1_2.text = roundData.score_my_act[1].description
            }
            if 0 <= roundData.score_my_act[2] {
                txtP3P1_2.text = roundData.score_my_act[2].description
            }
            if 0 <= roundData.score_my_act[3] {
                txtP4P1_2.text = roundData.score_my_act[3].description
            }
            if 0 <= roundData.score_my_act[4] {
                txtP5P1_2.text = roundData.score_my_act[4].description
            }
            if 0 <= roundData.score_my_act[5] {
                txtP6P1_2.text = roundData.score_my_act[5].description
            }
            if 0 <= roundData.score_my_act[6] {
                txtP7P1_2.text = roundData.score_my_act[6].description
            }
            if 0 <= roundData.score_my_act[7] {
                txtP8P1_2.text = roundData.score_my_act[7].description
            }
            if 0 <= roundData.score_my_act[8] {
                txtP9P1_2.text = roundData.score_my_act[8].description
            }
            var total_act:Int = 0
            for i in 0 ..< 9 {
                if 0 <= roundData.score_my_act[i] {
                    total_act += roundData.score_my_act[i]
                }
            }
            txtP10P1_2.text = total_act.description
#endif
            
            // 二人目のスコア=====================================
            if 0 <= roundData.score_2[0] {
                txtP1P2.text = roundData.score_2[0].description
            }
            if 0 <= roundData.score_2[1] {
                txtP2P2.text = roundData.score_2[1].description
            }
            if 0 <= roundData.score_2[2] {
                txtP3P2.text = roundData.score_2[2].description
            }
            if 0 <= roundData.score_2[3] {
                txtP4P2.text = roundData.score_2[3].description
            }
            if 0 <= roundData.score_2[4] {
                txtP5P2.text = roundData.score_2[4].description
            }
            if 0 <= roundData.score_2[5] {
                txtP6P2.text = roundData.score_2[5].description
            }
            if 0 <= roundData.score_2[6] {
                txtP7P2.text = roundData.score_2[6].description
            }
            if 0 <= roundData.score_2[7] {
                txtP8P2.text = roundData.score_2[7].description
            }
            if 0 <= roundData.score_2[8] {
                txtP9P2.text = roundData.score_2[8].description
            }
            total = 0
            for i in 0 ..< 9 {
                if 0 <= roundData.score_2[i] {
                    total += roundData.score_2[i]
                }
            }
            txtP10P2.text = total.description
            
            // 自分のスコア(PAD)
            if 0 <= roundData.score_2_pad[0] {
                txtP1P2_1.text = roundData.score_2_pad[0].description
            }
            if 0 <= roundData.score_2_pad[1] {
                txtP2P2_1.text = roundData.score_2_pad[1].description
            }
            if 0 <= roundData.score_2_pad[2] {
                txtP3P2_1.text = roundData.score_2_pad[2].description
            }
            if 0 <= roundData.score_2_pad[3] {
                txtP4P2_1.text = roundData.score_2_pad[3].description
            }
            if 0 <= roundData.score_2_pad[4] {
                txtP5P2_1.text = roundData.score_2_pad[4].description
            }
            if 0 <= roundData.score_2_pad[5] {
                txtP6P2_1.text = roundData.score_2_pad[5].description
            }
            if 0 <= roundData.score_2_pad[6] {
                txtP7P2_1.text = roundData.score_2_pad[6].description
            }
            if 0 <= roundData.score_2_pad[7] {
                txtP8P2_1.text = roundData.score_2_pad[7].description
            }
            if 0 <= roundData.score_2_pad[8] {
                txtP9P2_1.text = roundData.score_2_pad[8].description
            }
            total_pad = 0
            for i in 0 ..< 9 {
                if 0 <= roundData.score_2_pad[i] {
                    total_pad += roundData.score_2_pad[i]
                }
            }
            txtP10P2_1.text = total_pad.description

#if false
            // 自分のスコア(ACT)
            if 0 <= roundData.score_2_act[0] {
                txtP1P2_2.text = roundData.score_2_act[0].description
            }
            if 0 <= roundData.score_2_act[1] {
                txtP2P2_2.text = roundData.score_2_act[1].description
            }
            if 0 <= roundData.score_2_act[2] {
                txtP3P2_2.text = roundData.score_2_act[2].description
            }
            if 0 <= roundData.score_2_act[3] {
                txtP4P2_2.text = roundData.score_2_act[3].description
            }
            if 0 <= roundData.score_2_act[4] {
                txtP5P2_2.text = roundData.score_2_act[4].description
            }
            if 0 <= roundData.score_2_act[5] {
                txtP6P2_2.text = roundData.score_2_act[5].description
            }
            if 0 <= roundData.score_2_act[6] {
                txtP7P2_2.text = roundData.score_2_act[6].description
            }
            if 0 <= roundData.score_2_act[7] {
                txtP8P2_2.text = roundData.score_2_act[7].description
            }
            if 0 <= roundData.score_2_act[8] {
                txtP9P2_2.text = roundData.score_2_act[8].description
            }
            total_act = 0
            for i in 0 ..< 9 {
                if 0 <= roundData.score_2_act[i] {
                    total_act += roundData.score_2_act[i]
                }
            }
            txtP10P2_2.text = total_act.description
#endif
            
            // 三人目のスコア=====================================
            if 0 <= roundData.score_3[0] {
                txtP1P3.text = roundData.score_3[0].description
            }
            if 0 <= roundData.score_3[1] {
                txtP2P3.text = roundData.score_3[1].description
            }
            if 0 <= roundData.score_3[2] {
                txtP3P3.text = roundData.score_3[2].description
            }
            if 0 <= roundData.score_3[3] {
                txtP4P3.text = roundData.score_3[3].description
            }
            if 0 <= roundData.score_3[4] {
                txtP5P3.text = roundData.score_3[4].description
            }
            if 0 <= roundData.score_3[5] {
                txtP6P3.text = roundData.score_3[5].description
            }
            if 0 <= roundData.score_3[6] {
                txtP7P3.text = roundData.score_3[6].description
            }
            if 0 <= roundData.score_3[7] {
                txtP8P3.text = roundData.score_3[7].description
            }
            if 0 <= roundData.score_3[8] {
                txtP9P3.text = roundData.score_3[8].description
            }
            total = 0
            for i in 0 ..< 9 {
                if 0 <= roundData.score_3[i] {
                    total += roundData.score_3[i]
                }
            }
            txtP10P3.text = total.description
            
            // 自分のスコア(PAD)
            if 0 <= roundData.score_3_pad[0] {
                txtP1P3_1.text = roundData.score_3_pad[0].description
            }
            if 0 <= roundData.score_3_pad[1] {
                txtP2P3_1.text = roundData.score_3_pad[1].description
            }
            if 0 <= roundData.score_3_pad[2] {
                txtP3P3_1.text = roundData.score_3_pad[2].description
            }
            if 0 <= roundData.score_3_pad[3] {
                txtP4P3_1.text = roundData.score_3_pad[3].description
            }
            if 0 <= roundData.score_3_pad[4] {
                txtP5P3_1.text = roundData.score_3_pad[4].description
            }
            if 0 <= roundData.score_3_pad[5] {
                txtP6P3_1.text = roundData.score_3_pad[5].description
            }
            if 0 <= roundData.score_3_pad[6] {
                txtP7P3_1.text = roundData.score_3_pad[6].description
            }
            if 0 <= roundData.score_3_pad[7] {
                txtP8P3_1.text = roundData.score_3_pad[7].description
            }
            if 0 <= roundData.score_3_pad[8] {
                txtP9P3_1.text = roundData.score_3_pad[8].description
            }
            total_pad = 0
            for i in 0 ..< 9 {
                if 0 <= roundData.score_3_pad[i] {
                    total_pad += roundData.score_3_pad[i]
                }
            }
            txtP10P3_1.text = total_pad.description

#if false
            // 自分のスコア(ACT)
            if 0 <= roundData.score_3_act[0] {
                txtP1P3_2.text = roundData.score_3_act[0].description
            }
            if 0 <= roundData.score_3_act[1] {
                txtP2P3_2.text = roundData.score_3_act[1].description
            }
            if 0 <= roundData.score_3_act[2] {
                txtP3P3_2.text = roundData.score_3_act[2].description
            }
            if 0 <= roundData.score_3_act[3] {
                txtP4P3_2.text = roundData.score_3_act[3].description
            }
            if 0 <= roundData.score_3_act[4] {
                txtP5P3_2.text = roundData.score_3_act[4].description
            }
            if 0 <= roundData.score_3_act[5] {
                txtP6P3_2.text = roundData.score_3_act[5].description
            }
            if 0 <= roundData.score_3_act[6] {
                txtP7P3_2.text = roundData.score_3_act[6].description
            }
            if 0 <= roundData.score_3_act[7] {
                txtP8P3_2.text = roundData.score_3_act[7].description
            }
            if 0 <= roundData.score_3_act[8] {
                txtP9P3_2.text = roundData.score_3_act[8].description
            }
            total_act = 0
            for i in 0 ..< 9 {
                if 0 <= roundData.score_3_act[i] {
                    total_act += roundData.score_3_act[i]
                }
            }
            txtP10P3_2.text = total_act.description
#endif
            
            // 四人目のスコア=====================================
            if 0 <= roundData.score_4[0] {
                txtP1P4.text = roundData.score_4[0].description
            }
            if 0 <= roundData.score_4[1] {
                txtP2P4.text = roundData.score_4[1].description
            }
            if 0 <= roundData.score_4[2] {
                txtP3P4.text = roundData.score_4[2].description
            }
            if 0 <= roundData.score_4[3] {
                txtP4P4.text = roundData.score_4[3].description
            }
            if 0 <= roundData.score_4[4] {
                txtP5P4.text = roundData.score_4[4].description
            }
            if 0 <= roundData.score_4[5] {
                txtP6P4.text = roundData.score_4[5].description
            }
            if 0 <= roundData.score_4[6] {
                txtP7P4.text = roundData.score_4[6].description
            }
            if 0 <= roundData.score_4[7] {
                txtP8P4.text = roundData.score_4[7].description
            }
            if 0 <= roundData.score_4[8] {
                txtP9P4.text = roundData.score_4[8].description
            }
            total = 0
            for i in 0 ..< 9 {
                if 0 <= roundData.score_4[i] {
                    total += roundData.score_4[i]
                }
            }
            txtP10P4.text = total.description
            
            // 自分のスコア(PAD)
            if 0 <= roundData.score_4_pad[0] {
                txtP1P4_1.text = roundData.score_4_pad[0].description
            }
            if 0 <= roundData.score_4_pad[1] {
                txtP2P4_1.text = roundData.score_4_pad[1].description
            }
            if 0 <= roundData.score_4_pad[2] {
                txtP3P4_1.text = roundData.score_4_pad[2].description
            }
            if 0 <= roundData.score_4_pad[3] {
                txtP4P4_1.text = roundData.score_4_pad[3].description
            }
            if 0 <= roundData.score_4_pad[4] {
                txtP5P4_1.text = roundData.score_4_pad[4].description
            }
            if 0 <= roundData.score_4_pad[5] {
                txtP6P4_1.text = roundData.score_4_pad[5].description
            }
            if 0 <= roundData.score_4_pad[6] {
                txtP7P4_1.text = roundData.score_4_pad[6].description
            }
            if 0 <= roundData.score_4_pad[7] {
                txtP8P4_1.text = roundData.score_4_pad[7].description
            }
            if 0 <= roundData.score_4_pad[8] {
                txtP9P4_1.text = roundData.score_4_pad[8].description
            }
            total_pad = 0
            for i in 0 ..< 9 {
                if 0 <= roundData.score_4_pad[i] {
                    total_pad += roundData.score_4_pad[i]
                }
            }
            txtP10P4_1.text = total_pad.description
            
#if false
            // 自分のスコア(ACT)
            if 0 <= roundData.score_4_act[0] {
                txtP1P4_2.text = roundData.score_4_act[0].description
            }
            if 0 <= roundData.score_4_act[1] {
                txtP2P4_2.text = roundData.score_4_act[1].description
            }
            if 0 <= roundData.score_4_act[2] {
                txtP3P4_2.text = roundData.score_4_act[2].description
            }
            if 0 <= roundData.score_4_act[3] {
                txtP4P4_2.text = roundData.score_4_act[3].description
            }
            if 0 <= roundData.score_4_act[4] {
                txtP5P4_2.text = roundData.score_4_act[4].description
            }
            if 0 <= roundData.score_4_act[5] {
                txtP6P4_2.text = roundData.score_4_act[5].description
            }
            if 0 <= roundData.score_4_act[6] {
                txtP7P4_2.text = roundData.score_4_act[6].description
            }
            if 0 <= roundData.score_4_act[7] {
                txtP8P4_2.text = roundData.score_4_act[7].description
            }
            if 0 <= roundData.score_4_act[8] {
                txtP9P4_2.text = roundData.score_4_act[8].description
            }
            total_act = 0
            for i in 0 ..< 9 {
                if 0 <= roundData.score_4_act[i] {
                    total_act += roundData.score_4_act[i]
                }
            }
            txtP10P4_2.text = total_act.description
#endif
        }
        else {
            lblHole1.text = "10"
            lblHole2.text = "11"
            lblHole3.text = "12"
            lblHole4.text = "13"
            lblHole5.text = "14"
            lblHole6.text = "15"
            lblHole7.text = "16"
            lblHole8.text = "17"
            lblHole9.text = "18"
            
            // パー
            if 0 <= roundData.par_num[9] {
                txtPar1.text = roundData.par_num[9].description
            }
            if 0 <= roundData.par_num[10] {
                txtPar2.text = roundData.par_num[10].description
            }
            if 0 <= roundData.par_num[11] {
                txtPar3.text = roundData.par_num[11].description
            }
            if 0 <= roundData.par_num[12] {
                txtPar4.text = roundData.par_num[12].description
            }
            if 0 <= roundData.par_num[13] {
                txtPar5.text = roundData.par_num[13].description
            }
            if 0 <= roundData.par_num[14] {
                txtPar6.text = roundData.par_num[14].description
            }
            if 0 <= roundData.par_num[15] {
                txtPar7.text = roundData.par_num[15].description
            }
            if 0 <= roundData.par_num[16] {
                txtPar8.text = roundData.par_num[16].description
            }
            if 0 <= roundData.par_num[17] {
                txtPar9.text = roundData.par_num[17].description
            }
            var total:Int = 0
            for i in 9 ..< 18 {
                if 0 <= roundData.par_num[i] {
                    total += roundData.par_num[i]
                }
            }
            txtPar10.text = total.description

            // 自分のスコア=====================================
            if 0 <= roundData.score_my[9] {
                txtP1P1.text = roundData.score_my[9].description
            }
            if 0 <= roundData.score_my[10] {
                txtP2P1.text = roundData.score_my[10].description
            }
            if 0 <= roundData.score_my[11] {
                txtP3P1.text = roundData.score_my[11].description
            }
            if 0 <= roundData.score_my[12] {
                txtP4P1.text = roundData.score_my[12].description
            }
            if 0 <= roundData.score_my[13] {
                txtP5P1.text = roundData.score_my[13].description
            }
            if 0 <= roundData.score_my[14] {
                txtP6P1.text = roundData.score_my[14].description
            }
            if 0 <= roundData.score_my[15] {
                txtP7P1.text = roundData.score_my[15].description
            }
            if 0 <= roundData.score_my[16] {
                txtP8P1.text = roundData.score_my[16].description
            }
            if 0 <= roundData.score_my[17] {
                txtP9P1.text = roundData.score_my[17].description
            }
            total = 0
            for i in 9 ..< 18 {
                if 0 <= roundData.score_my[i] {
                    total += roundData.score_my[i]
                }
            }
            txtP10P1.text = total.description
            
            // 自分のスコア(PAD)
            if 0 <= roundData.score_my_pad[9] {
                txtP1P1_1.text = roundData.score_my_pad[9].description
            }
            if 0 <= roundData.score_my_pad[10] {
                txtP2P1_1.text = roundData.score_my_pad[10].description
            }
            if 0 <= roundData.score_my_pad[11] {
                txtP3P1_1.text = roundData.score_my_pad[11].description
            }
            if 0 <= roundData.score_my_pad[12] {
                txtP4P1_1.text = roundData.score_my_pad[12].description
            }
            if 0 <= roundData.score_my_pad[13] {
                txtP5P1_1.text = roundData.score_my_pad[13].description
            }
            if 0 <= roundData.score_my_pad[14] {
                txtP6P1_1.text = roundData.score_my_pad[14].description
            }
            if 0 <= roundData.score_my_pad[15] {
                txtP7P1_1.text = roundData.score_my_pad[15].description
            }
            if 0 <= roundData.score_my_pad[16] {
                txtP8P1_1.text = roundData.score_my_pad[16].description
            }
            if 0 <= roundData.score_my_pad[17] {
                txtP9P1_1.text = roundData.score_my_pad[17].description
            }
            var total_pad:Int = 0
            for i in 9 ..< 18 {
                if 0 <= roundData.score_my_pad[i] {
                    total_pad += roundData.score_my_pad[i]
                }
            }
            txtP10P1_1.text = total_pad.description
            
#if false
            // 自分のスコア(ACT)
            if 0 <= roundData.score_my_act[9] {
                txtP1P1_2.text = roundData.score_my_act[9].description
            }
            if 0 <= roundData.score_my_act[10] {
                txtP2P1_2.text = roundData.score_my_act[10].description
            }
            if 0 <= roundData.score_my_act[11] {
                txtP3P1_2.text = roundData.score_my_act[11].description
            }
            if 0 <= roundData.score_my_act[12] {
                txtP4P1_2.text = roundData.score_my_act[12].description
            }
            if 0 <= roundData.score_my_act[13] {
                txtP5P1_2.text = roundData.score_my_act[13].description
            }
            if 0 <= roundData.score_my_act[14] {
                txtP6P1_2.text = roundData.score_my_act[14].description
            }
            if 0 <= roundData.score_my_act[15] {
                txtP7P1_2.text = roundData.score_my_act[15].description
            }
            if 0 <= roundData.score_my_act[16] {
                txtP8P1_2.text = roundData.score_my_act[16].description
            }
            if 0 <= roundData.score_my_act[17] {
                txtP9P1_2.text = roundData.score_my_act[17].description
            }
            var total_act:Int = 0
            for i in 9 ..< 18 {
                if 0 <= roundData.score_my_act[i] {
                    total_act += roundData.score_my_act[i]
                }
            }
            txtP10P1_2.text = total_act.description
#endif
            // 二人目のスコア=====================================
            if 0 <= roundData.score_2[9] {
                txtP1P2.text = roundData.score_2[9].description
            }
            if 0 <= roundData.score_2[10] {
                txtP2P2.text = roundData.score_2[10].description
            }
            if 0 <= roundData.score_2[11] {
                txtP3P2.text = roundData.score_2[11].description
            }
            if 0 <= roundData.score_2[12] {
                txtP4P2.text = roundData.score_2[12].description
            }
            if 0 <= roundData.score_2[13] {
                txtP5P2.text = roundData.score_2[13].description
            }
            if 0 <= roundData.score_2[14] {
                txtP6P2.text = roundData.score_2[14].description
            }
            if 0 <= roundData.score_2[15] {
                txtP7P2.text = roundData.score_2[15].description
            }
            if 0 <= roundData.score_2[16] {
                txtP8P2.text = roundData.score_2[16].description
            }
            if 0 <= roundData.score_2[17] {
                txtP9P2.text = roundData.score_2[17].description
            }
            total = 0
            for i in 9 ..< 18 {
                if 0 <= roundData.score_2[i] {
                    total += roundData.score_2[i]
                }
            }
            txtP10P2.text = total.description
            
            // 二人目のスコア(PAD)
            if 0 <= roundData.score_2_pad[9] {
                txtP1P2_1.text = roundData.score_2_pad[9].description
            }
            if 0 <= roundData.score_2_pad[10] {
                txtP2P2_1.text = roundData.score_2_pad[10].description
            }
            if 0 <= roundData.score_2_pad[11] {
                txtP3P2_1.text = roundData.score_2_pad[11].description
            }
            if 0 <= roundData.score_2_pad[12] {
                txtP4P2_1.text = roundData.score_2_pad[12].description
            }
            if 0 <= roundData.score_2_pad[13] {
                txtP5P2_1.text = roundData.score_2_pad[13].description
            }
            if 0 <= roundData.score_2_pad[14] {
                txtP6P2_1.text = roundData.score_2_pad[14].description
            }
            if 0 <= roundData.score_2_pad[15] {
                txtP7P2_1.text = roundData.score_2_pad[15].description
            }
            if 0 <= roundData.score_2_pad[16] {
                txtP8P2_1.text = roundData.score_2_pad[16].description
            }
            if 0 <= roundData.score_2_pad[17] {
                txtP9P2_1.text = roundData.score_2_pad[17].description
            }
            total_pad = 0
            for i in 9 ..< 18 {
                if 0 <= roundData.score_2_pad[i] {
                    total_pad += roundData.score_2_pad[i]
                }
            }
            txtP10P2_1.text = total_pad.description

#if false
            // 二人目のスコア(ACT)
            if 0 <= roundData.score_2_act[9] {
                txtP1P2_2.text = roundData.score_2_act[9].description
            }
            if 0 <= roundData.score_2_act[10] {
                txtP2P2_2.text = roundData.score_2_act[10].description
            }
            if 0 <= roundData.score_2_act[11] {
                txtP3P2_2.text = roundData.score_2_act[11].description
            }
            if 0 <= roundData.score_2_act[12] {
                txtP4P2_2.text = roundData.score_2_act[12].description
            }
            if 0 <= roundData.score_2_act[13] {
                txtP5P2_2.text = roundData.score_2_act[13].description
            }
            if 0 <= roundData.score_2_act[14] {
                txtP6P2_2.text = roundData.score_2_act[14].description
            }
            if 0 <= roundData.score_2_act[15] {
                txtP7P2_2.text = roundData.score_2_act[15].description
            }
            if 0 <= roundData.score_2_act[16] {
                txtP8P2_2.text = roundData.score_2_act[16].description
            }
            if 0 <= roundData.score_2_act[17] {
                txtP9P2_2.text = roundData.score_2_act[17].description
            }
            total_act = 0
            for i in 9 ..< 18 {
                if 0 <= roundData.score_2_act[i] {
                    total_act += roundData.score_2_act[i]
                }
            }
            txtP10P2_2.text = total_act.description
#endif
            
            // 三人目のスコア=====================================
            if 0 <= roundData.score_3[9] {
                txtP1P3.text = roundData.score_3[9].description
            }
            if 0 <= roundData.score_3[10] {
                txtP2P3.text = roundData.score_3[10].description
            }
            if 0 <= roundData.score_3[11] {
                txtP3P3.text = roundData.score_3[11].description
            }
            if 0 <= roundData.score_3[12] {
                txtP4P3.text = roundData.score_3[12].description
            }
            if 0 <= roundData.score_3[13] {
                txtP5P3.text = roundData.score_3[13].description
            }
            if 0 <= roundData.score_3[14] {
                txtP6P3.text = roundData.score_3[14].description
            }
            if 0 <= roundData.score_3[15] {
                txtP7P3.text = roundData.score_3[15].description
            }
            if 0 <= roundData.score_3[16] {
                txtP8P3.text = roundData.score_3[16].description
            }
            if 0 <= roundData.score_3[17] {
                txtP9P3.text = roundData.score_3[17].description
            }
            total = 0
            for i in 9 ..< 18 {
                if 0 <= roundData.score_3[i] {
                    total += roundData.score_3[i]
                }
            }
            txtP10P3.text = total.description
            
            // 三人目のスコア(PAD)
            if 0 <= roundData.score_3_pad[9] {
                txtP1P3_1.text = roundData.score_3_pad[9].description
            }
            if 0 <= roundData.score_3_pad[10] {
                txtP2P3_1.text = roundData.score_3_pad[10].description
            }
            if 0 <= roundData.score_3_pad[11] {
                txtP3P3_1.text = roundData.score_3_pad[11].description
            }
            if 0 <= roundData.score_3_pad[12] {
                txtP4P3_1.text = roundData.score_3_pad[12].description
            }
            if 0 <= roundData.score_3_pad[13] {
                txtP5P3_1.text = roundData.score_3_pad[13].description
            }
            if 0 <= roundData.score_3_pad[14] {
                txtP6P3_1.text = roundData.score_3_pad[14].description
            }
            if 0 <= roundData.score_3_pad[15] {
                txtP7P3_1.text = roundData.score_3_pad[15].description
            }
            if 0 <= roundData.score_3_pad[16] {
                txtP8P3_1.text = roundData.score_3_pad[16].description
            }
            if 0 <= roundData.score_3_pad[17] {
                txtP9P3_1.text = roundData.score_3_pad[17].description
            }
            total_pad = 0
            for i in 9 ..< 18 {
                if 0 <= roundData.score_3_pad[i] {
                    total_pad += roundData.score_3_pad[i]
                }
            }
            txtP10P3_1.text = total_pad.description

#if false
            // 三人目のスコア(ACT)
            if 0 <= roundData.score_3_act[9] {
                txtP1P3_2.text = roundData.score_3_act[9].description
            }
            if 0 <= roundData.score_3_act[10] {
                txtP2P3_2.text = roundData.score_3_act[10].description
            }
            if 0 <= roundData.score_3_act[11] {
                txtP3P3_2.text = roundData.score_3_act[11].description
            }
            if 0 <= roundData.score_3_act[12] {
                txtP4P3_2.text = roundData.score_3_act[12].description
            }
            if 0 <= roundData.score_3_act[13] {
                txtP5P3_2.text = roundData.score_3_act[13].description
            }
            if 0 <= roundData.score_3_act[14] {
                txtP6P3_2.text = roundData.score_3_act[14].description
            }
            if 0 <= roundData.score_3_act[15] {
                txtP7P3_2.text = roundData.score_3_act[15].description
            }
            if 0 <= roundData.score_3_act[16] {
                txtP8P3_2.text = roundData.score_3_act[16].description
            }
            if 0 <= roundData.score_3_act[17] {
                txtP9P3_2.text = roundData.score_3_act[17].description
            }
            total_act = 0
            for i in 9 ..< 18 {
                if 0 <= roundData.score_3_act[i] {
                    total_act += roundData.score_3_act[i]
                }
            }
            txtP10P3_2.text = total_act.description
#endif
            
            // 四人目のスコア=====================================
            if 0 <= roundData.score_4[9] {
                txtP1P4.text = roundData.score_4[9].description
            }
            if 0 <= roundData.score_4[10] {
                txtP2P4.text = roundData.score_4[10].description
            }
            if 0 <= roundData.score_4[11] {
                txtP3P4.text = roundData.score_4[11].description
            }
            if 0 <= roundData.score_4[12] {
                txtP4P4.text = roundData.score_4[12].description
            }
            if 0 <= roundData.score_4[13] {
                txtP5P4.text = roundData.score_4[13].description
            }
            if 0 <= roundData.score_4[14] {
                txtP6P4.text = roundData.score_4[14].description
            }
            if 0 <= roundData.score_4[15] {
                txtP7P4.text = roundData.score_4[15].description
            }
            if 0 <= roundData.score_4[16] {
                txtP8P4.text = roundData.score_4[16].description
            }
            if 0 <= roundData.score_4[17] {
                txtP9P4.text = roundData.score_4[17].description
            }
            total = 0
            for i in 9 ..< 18 {
                if 0 <= roundData.score_4[i] {
                    total += roundData.score_4[i]
                }
            }
            txtP10P4.text = total.description
            
            // 四人目のスコア(PAD)
            if 0 <= roundData.score_4_pad[9] {
                txtP1P4_1.text = roundData.score_4_pad[9].description
            }
            if 0 <= roundData.score_4_pad[10] {
                txtP2P4_1.text = roundData.score_4_pad[10].description
            }
            if 0 <= roundData.score_4_pad[11] {
                txtP3P4_1.text = roundData.score_4_pad[11].description
            }
            if 0 <= roundData.score_4_pad[12] {
                txtP4P4_1.text = roundData.score_4_pad[12].description
            }
            if 0 <= roundData.score_4_pad[13] {
                txtP5P4_1.text = roundData.score_4_pad[13].description
            }
            if 0 <= roundData.score_4_pad[14] {
                txtP6P4_1.text = roundData.score_4_pad[14].description
            }
            if 0 <= roundData.score_4_pad[15] {
                txtP7P4_1.text = roundData.score_4_pad[15].description
            }
            if 0 <= roundData.score_4_pad[16] {
                txtP8P4_1.text = roundData.score_4_pad[16].description
            }
            if 0 <= roundData.score_4_pad[17] {
                txtP9P4_1.text = roundData.score_4_pad[17].description
            }
            total_pad = 0
            for i in 9 ..< 18 {
                if 0 <= roundData.score_4_pad[i] {
                    total_pad += roundData.score_4_pad[i]
                }
            }
            txtP10P4_1.text = total_pad.description
            
#if false
            // 四人目のスコア(ACT)
            if 0 <= roundData.score_4_act[9] {
                txtP1P4_2.text = roundData.score_4_act[9].description
            }
            if 0 <= roundData.score_4_act[10] {
                txtP2P4_2.text = roundData.score_4_act[10].description
            }
            if 0 <= roundData.score_4_act[11] {
                txtP3P4_2.text = roundData.score_4_act[11].description
            }
            if 0 <= roundData.score_4_act[12] {
                txtP4P4_2.text = roundData.score_4_act[12].description
            }
            if 0 <= roundData.score_4_act[13] {
                txtP5P4_2.text = roundData.score_4_act[13].description
            }
            if 0 <= roundData.score_4_act[14] {
                txtP6P4_2.text = roundData.score_4_act[14].description
            }
            if 0 <= roundData.score_4_act[15] {
                txtP7P4_2.text = roundData.score_4_act[15].description
            }
            if 0 <= roundData.score_4_act[16] {
                txtP8P4_2.text = roundData.score_4_act[16].description
            }
            if 0 <= roundData.score_4_act[17] {
                txtP9P4_2.text = roundData.score_4_act[17].description
            }
            total_act = 0
            for i in 9 ..< 18 {
                if 0 <= roundData.score_4_act[i] {
                    total_act += roundData.score_4_act[i]
                }
            }
            txtP10P4_2.text = total_act.description
#endif
        }
    }
    
    // Sccoreを保存する
    func saveScore(_ isFirst: Bool) {
        // パー
        var par_num:[Int] = [-1,-1,-1,-1,-1,-1,-1,-1,-1]
        // 本人のスコア
        var score_my:[Int] = [-1,-1,-1,-1,-1,-1,-1,-1,-1]
        var score_my_pad:[Int] = [-1,-1,-1,-1,-1,-1,-1,-1,-1]
        var score_my_act:[Int] = [-1,-1,-1,-1,-1,-1,-1,-1,-1]
        // 二人目
        var name_2 = String()
        var score_2:[Int] = [-1,-1,-1,-1,-1,-1,-1,-1,-1]
        var score_2_pad:[Int] = [-1,-1,-1,-1,-1,-1,-1,-1,-1]
        var score_2_act:[Int] = [-1,-1,-1,-1,-1,-1,-1,-1,-1]
        // 三人目
        var name_3 = String()
        var score_3:[Int] = [-1,-1,-1,-1,-1,-1,-1,-1,-1]
        var score_3_pad:[Int] = [-1,-1,-1,-1,-1,-1,-1,-1,-1]
        var score_3_act:[Int] = [-1,-1,-1,-1,-1,-1,-1,-1,-1]
        // 四人目
        var name_4 = String()
        var score_4:[Int] = [-1,-1,-1,-1,-1,-1,-1,-1,-1]
        var score_4_pad:[Int] = [-1,-1,-1,-1,-1,-1,-1,-1,-1]
        var score_4_act:[Int] = [-1,-1,-1,-1,-1,-1,-1,-1,-1]

        // パー
        var input = Int(txtPar1.text!.description)
        if (nil != input) {
            par_num[0] = input!
        }
        input = Int(txtPar2.text!.description)
        if (nil != input) {
            par_num[1] = input!
        }
        input = Int(txtPar3.text!.description)
        if (nil != input) {
            par_num[2] = input!
        }
        input = Int(txtPar4.text!.description)
        if (nil != input) {
            par_num[3] = input!
        }
        input = Int(txtPar5.text!.description)
        if (nil != input) {
            par_num[4] = input!
        }
        input = Int(txtPar6.text!.description)
        if (nil != input) {
            par_num[5] = input!
        }
        input = Int(txtPar7.text!.description)
        if (nil != input) {
            par_num[6] = input!
        }
        input = Int(txtPar8.text!.description)
        if (nil != input) {
            par_num[7] = input!
        }
        input = Int(txtPar9.text!.description)
        if (nil != input) {
            par_num[8] = input!
        }
        
        // 本人のスコア=================================
        input = Int(txtP1P1.text!.description)
        if (nil != input) {
            score_my[0] = input!
        }
        input = Int(txtP2P1.text!.description)
        if (nil != input) {
            score_my[1] = input!
        }
        input = Int(txtP3P1.text!.description)
        if (nil != input) {
            score_my[2] = input!
        }
        input = Int(txtP4P1.text!.description)
        if (nil != input) {
            score_my[3] = input!
        }
        input = Int(txtP5P1.text!.description)
        if (nil != input) {
            score_my[4] = input!
        }
        input = Int(txtP6P1.text!.description)
        if (nil != input) {
            score_my[5] = input!
        }
        input = Int(txtP7P1.text!.description)
        if (nil != input) {
            score_my[6] = input!
        }
        input = Int(txtP8P1.text!.description)
        if (nil != input) {
            score_my[7] = input!
        }
        input = Int(txtP9P1.text!.description)
        if (nil != input) {
            score_my[8] = input!
        }

        // 本人のスコア（PAD）
        input = Int(txtP1P1_1.text!.description)
        if (nil != input) {
            score_my_pad[0] = input!
        }
        input = Int(txtP2P1_1.text!.description)
        if (nil != input) {
            score_my_pad[1] = input!
        }
        input = Int(txtP3P1_1.text!.description)
        if (nil != input) {
            score_my_pad[2] = input!
        }
        input = Int(txtP4P1_1.text!.description)
        if (nil != input) {
            score_my_pad[3] = input!
        }
        input = Int(txtP5P1_1.text!.description)
        if (nil != input) {
            score_my_pad[4] = input!
        }
        input = Int(txtP6P1_1.text!.description)
        if (nil != input) {
            score_my_pad[5] = input!
        }
        input = Int(txtP7P1_1.text!.description)
        if (nil != input) {
            score_my_pad[6] = input!
        }
        input = Int(txtP8P1_1.text!.description)
        if (nil != input) {
            score_my_pad[7] = input!
        }
        input = Int(txtP9P1_1.text!.description)
        if (nil != input) {
            score_my_pad[8] = input!
        }

#if false
        // 本人のスコア(ACT)
        input = Int(txtP1P1_2.text!.description)
        if (nil != input) {
            score_my_act[0] = input!
        }
        input = Int(txtP2P1_2.text!.description)
        if (nil != input) {
            score_my_act[1] = input!
        }
        input = Int(txtP3P1_2.text!.description)
        if (nil != input) {
            score_my_act[2] = input!
        }
        input = Int(txtP4P1_2.text!.description)
        if (nil != input) {
            score_my_act[3] = input!
        }
        input = Int(txtP5P1_2.text!.description)
        if (nil != input) {
            score_my_act[4] = input!
        }
        input = Int(txtP6P1_2.text!.description)
        if (nil != input) {
            score_my_act[5] = input!
        }
        input = Int(txtP7P1_2.text!.description)
        if (nil != input) {
            score_my_act[6] = input!
        }
        input = Int(txtP8P1_2.text!.description)
        if (nil != input) {
            score_my_act[7] = input!
        }
        input = Int(txtP9P1_2.text!.description)
        if (nil != input) {
            score_my_act[8] = input!
        }
#endif
        
        // 二人目のスコア=================================
        name_2 = lblName2.text!
        input = Int(txtP1P2.text!.description)
        if (nil != input) {
            score_2[0] = input!
        }
        input = Int(txtP2P2.text!.description)
        if (nil != input) {
            score_2[1] = input!
        }
        input = Int(txtP3P2.text!.description)
        if (nil != input) {
            score_2[2] = input!
        }
        input = Int(txtP4P2.text!.description)
        if (nil != input) {
            score_2[3] = input!
        }
        input = Int(txtP5P2.text!.description)
        if (nil != input) {
            score_2[4] = input!
        }
        input = Int(txtP6P2.text!.description)
        if (nil != input) {
            score_2[5] = input!
        }
        input = Int(txtP7P2.text!.description)
        if (nil != input) {
            score_2[6] = input!
        }
        input = Int(txtP8P2.text!.description)
        if (nil != input) {
            score_2[7] = input!
        }
        input = Int(txtP9P2.text!.description)
        if (nil != input) {
            score_2[8] = input!
        }

        // 二人目のスコア（PAD）
        input = Int(txtP1P2_1.text!.description)
        if (nil != input) {
            score_2_pad[0] = input!
        }
        input = Int(txtP2P2_1.text!.description)
        if (nil != input) {
            score_2_pad[1] = input!
        }
        input = Int(txtP3P2_1.text!.description)
        if (nil != input) {
            score_2_pad[2] = input!
        }
        input = Int(txtP4P2_1.text!.description)
        if (nil != input) {
            score_2_pad[3] = input!
        }
        input = Int(txtP5P2_1.text!.description)
        if (nil != input) {
            score_2_pad[4] = input!
        }
        input = Int(txtP6P2_1.text!.description)
        if (nil != input) {
            score_2_pad[5] = input!
        }
        input = Int(txtP7P2_1.text!.description)
        if (nil != input) {
            score_2_pad[6] = input!
        }
        input = Int(txtP8P2_1.text!.description)
        if (nil != input) {
            score_2_pad[7] = input!
        }
        input = Int(txtP9P2_1.text!.description)
        if (nil != input) {
            score_2_pad[8] = input!
        }

#if false
        // 二人目のスコア(ACT)
        input = Int(txtP1P2_2.text!.description)
        if (nil != input) {
            score_2_act[0] = input!
        }
        input = Int(txtP2P2_2.text!.description)
        if (nil != input) {
            score_2_act[1] = input!
        }
        input = Int(txtP3P2_2.text!.description)
        if (nil != input) {
            score_2_act[2] = input!
        }
        input = Int(txtP4P2_2.text!.description)
        if (nil != input) {
            score_2_act[3] = input!
        }
        input = Int(txtP5P2_2.text!.description)
        if (nil != input) {
            score_2_act[4] = input!
        }
        input = Int(txtP6P2_2.text!.description)
        if (nil != input) {
            score_2_act[5] = input!
        }
        input = Int(txtP7P2_2.text!.description)
        if (nil != input) {
            score_2_act[6] = input!
        }
        input = Int(txtP8P2_2.text!.description)
        if (nil != input) {
            score_2_act[7] = input!
        }
        input = Int(txtP9P2_2.text!.description)
        if (nil != input) {
            score_2_act[8] = input!
        }
#endif
        
        // 三人目のスコア=================================
        name_3 = lblName3.text!
        input = Int(txtP1P3.text!.description)
        if (nil != input) {
            score_3[0] = input!
        }
        input = Int(txtP2P3.text!.description)
        if (nil != input) {
            score_3[1] = input!
        }
        input = Int(txtP3P3.text!.description)
        if (nil != input) {
            score_3[2] = input!
        }
        input = Int(txtP4P3.text!.description)
        if (nil != input) {
            score_3[3] = input!
        }
        input = Int(txtP5P3.text!.description)
        if (nil != input) {
            score_3[4] = input!
        }
        input = Int(txtP6P3.text!.description)
        if (nil != input) {
            score_3[5] = input!
        }
        input = Int(txtP7P3.text!.description)
        if (nil != input) {
            score_3[6] = input!
        }
        input = Int(txtP8P3.text!.description)
        if (nil != input) {
            score_3[7] = input!
        }
        input = Int(txtP9P3.text!.description)
        if (nil != input) {
            score_3[8] = input!
        }

        // 三人目のスコア（PAD）
        input = Int(txtP1P3_1.text!.description)
        if (nil != input) {
            score_3_pad[0] = input!
        }
        input = Int(txtP2P3_1.text!.description)
        if (nil != input) {
            score_3_pad[1] = input!
        }
        input = Int(txtP3P3_1.text!.description)
        if (nil != input) {
            score_3_pad[2] = input!
        }
        input = Int(txtP4P3_1.text!.description)
        if (nil != input) {
            score_3_pad[3] = input!
        }
        input = Int(txtP5P3_1.text!.description)
        if (nil != input) {
            score_3_pad[4] = input!
        }
        input = Int(txtP6P3_1.text!.description)
        if (nil != input) {
            score_3_pad[5] = input!
        }
        input = Int(txtP7P3_1.text!.description)
        if (nil != input) {
            score_3_pad[6] = input!
        }
        input = Int(txtP8P3_1.text!.description)
        if (nil != input) {
            score_3_pad[7] = input!
        }
        input = Int(txtP9P3_1.text!.description)
        if (nil != input) {
            score_3_pad[8] = input!
        }

#if false
        // 三人目のスコア(ACT)
        input = Int(txtP1P3_2.text!.description)
        if (nil != input) {
            score_3_act[0] = input!
        }
        input = Int(txtP2P3_2.text!.description)
        if (nil != input) {
            score_3_act[1] = input!
        }
        input = Int(txtP3P3_2.text!.description)
        if (nil != input) {
            score_3_act[2] = input!
        }
        input = Int(txtP4P3_2.text!.description)
        if (nil != input) {
            score_3_act[3] = input!
        }
        input = Int(txtP5P3_2.text!.description)
        if (nil != input) {
            score_3_act[4] = input!
        }
        input = Int(txtP6P3_2.text!.description)
        if (nil != input) {
            score_3_act[5] = input!
        }
        input = Int(txtP7P3_2.text!.description)
        if (nil != input) {
            score_3_act[6] = input!
        }
        input = Int(txtP8P3_2.text!.description)
        if (nil != input) {
            score_3_act[7] = input!
        }
        input = Int(txtP9P3_2.text!.description)
        if (nil != input) {
            score_3_act[8] = input!
        }
#endif
        
        // 四人目のスコア=================================
        name_4 = lblName4.text!
        input = Int(txtP1P4.text!.description)
        if (nil != input) {
            score_4[0] = input!
        }
        input = Int(txtP2P4.text!.description)
        if (nil != input) {
            score_4[1] = input!
        }
        input = Int(txtP3P4.text!.description)
        if (nil != input) {
            score_4[2] = input!
        }
        input = Int(txtP4P4.text!.description)
        if (nil != input) {
            score_4[3] = input!
        }
        input = Int(txtP5P4.text!.description)
        if (nil != input) {
            score_4[4] = input!
        }
        input = Int(txtP6P4.text!.description)
        if (nil != input) {
            score_4[5] = input!
        }
        input = Int(txtP7P4.text!.description)
        if (nil != input) {
            score_4[6] = input!
        }
        input = Int(txtP8P4.text!.description)
        if (nil != input) {
            score_4[7] = input!
        }
        input = Int(txtP9P4.text!.description)
        if (nil != input) {
            score_4[8] = input!
        }

        // 四人目のスコア（PAD）
        input = Int(txtP1P4_1.text!.description)
        if (nil != input) {
            score_4_pad[0] = input!
        }
        input = Int(txtP2P4_1.text!.description)
        if (nil != input) {
            score_4_pad[1] = input!
        }
        input = Int(txtP3P4_1.text!.description)
        if (nil != input) {
            score_4_pad[2] = input!
        }
        input = Int(txtP4P4_1.text!.description)
        if (nil != input) {
            score_4_pad[3] = input!
        }
        input = Int(txtP5P4_1.text!.description)
        if (nil != input) {
            score_4_pad[4] = input!
        }
        input = Int(txtP6P4_1.text!.description)
        if (nil != input) {
            score_4_pad[5] = input!
        }
        input = Int(txtP7P4_1.text!.description)
        if (nil != input) {
            score_4_pad[6] = input!
        }
        input = Int(txtP8P4_1.text!.description)
        if (nil != input) {
            score_4_pad[7] = input!
        }
        input = Int(txtP9P4_1.text!.description)
        if (nil != input) {
            score_4_pad[8] = input!
        }

#if false
        // 四人目のスコア(ACT)
        input = Int(txtP1P4_2.text!.description)
        if (nil != input) {
            score_4_act[0] = input!
        }
        input = Int(txtP2P4_2.text!.description)
        if (nil != input) {
            score_4_act[1] = input!
        }
        input = Int(txtP3P4_2.text!.description)
        if (nil != input) {
            score_4_act[2] = input!
        }
        input = Int(txtP4P4_2.text!.description)
        if (nil != input) {
            score_4_act[3] = input!
        }
        input = Int(txtP5P4_2.text!.description)
        if (nil != input) {
            score_4_act[4] = input!
        }
        input = Int(txtP6P4_2.text!.description)
        if (nil != input) {
            score_4_act[5] = input!
        }
        input = Int(txtP7P4_2.text!.description)
        if (nil != input) {
            score_4_act[6] = input!
        }
        input = Int(txtP8P4_2.text!.description)
        if (nil != input) {
            score_4_act[7] = input!
        }
        input = Int(txtP9P4_2.text!.description)
        if (nil != input) {
            score_4_act[8] = input!
        }
#endif
        
        // 全スコアの保存
        let appDelegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.golfRealmData.setGolfScore(par_num, score_my, score_my_pad, score_my_act, score_2, score_2_pad, score_2_act, score_3, score_3_pad, score_3_act, score_4, score_4_pad, score_4_act, name_2, name_3, name_4, isFirst)

        // 本人の名前の更新
        let bef_name_1 = appDelegate.golfRealmData.getPlayerInfo().name
        let name_1 = lblName1.text!
        if ("" != name_1) && (bef_name_1 != name_1) {
            appDelegate.golfRealmData.setPlayerName(name_1)
        }
    }
}

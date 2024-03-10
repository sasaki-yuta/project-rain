//
//  GolfInputScore3.swift
//  MapApp
//
//  Created by 佐々木勇太 on 2021/09/20.
//  Copyright © 2021 rain-00-00-09. All rights reserved.
//

import UIKit
import GoogleMobileAds

class GolfInputScore3: UIViewController,
                      GADBannerViewDelegate{
    
    @IBOutlet weak var btnBack: UIButton!
    var bannerView: GADBannerView!
    var defineClass:Define = Define()
    // ボタン <
    var backBtn: UIButton!
    var forwardBtn: UIButton!
    var btnDelete: UIButton!
    var btnSave: UIButton!
    
    
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


    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        // Google AddMod広告
        bannerView = GADBannerView(adSize: GADAdSizeBanner) //320×50
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
        forwardBtn.setTitle("＞", for: UIControl.State.normal)
        forwardBtn.frame = CGRect(x:width - 50, y:44, width:30, height:30)
        forwardBtn.sizeToFit() // サイズを決める(自動調整)
        forwardBtn.isEnabled = false
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
        lblHole1.text = "T"
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

  //      txtP1P4_2.frame = CGRect(x:(itemWidth*5), y:90+(itemHeight*2)-(itemHeight/2), width:(itemWidth/2), height:itemHeight/2)
  //      txtP1P4_2.layer.borderWidth = 1
  //      txtP1P4_2.textAlignment = NSTextAlignment.center
  //      self.view.addSubview(txtP1P4_2)
        
        // 削除、保存ボタン表示 Line2 ==============================
        btnDelete = UIButton(type: UIButton.ButtonType.system)
        btnDelete.addTarget(self, action: #selector(btnDelete(_:)), for: UIControl.Event.touchUpInside)
        btnDelete.setTitle("削除", for: UIControl.State.normal)
        btnDelete.frame = CGRect(x:30, y:90+(itemHeight*3)-(itemHeight/2), width:30, height:30)
        btnDelete.sizeToFit() // サイズを決める(自動調整)
        self.view.addSubview(btnDelete)

        btnSave = UIButton(type: UIButton.ButtonType.system)
        btnSave.addTarget(self, action: #selector(btnSave(_:)), for: UIControl.Event.touchUpInside)
        btnSave.setTitle("終了", for: UIControl.State.normal)
        btnSave.frame = CGRect(x:width - 50, y:90+(itemHeight*3)-(itemHeight/2), width:30, height:30)
        btnSave.sizeToFit() // サイズを決める(自動調整)
        self.view.addSubview(btnSave)
        
        
        loadScore()
    }
    
    // 合計スコア表示
    func loadScore() {
        // realmからラウンド中データを取得
        let appDelegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate
        let playerData = appDelegate.golfRealmData.getPlayerInfo()
        let roundData = appDelegate.golfRealmData.getRoundData()
        
        // 名前の読み込み
        lblName1.text = playerData.name
        lblName2.text = roundData.name_2
        lblName3.text = roundData.name_3
        lblName4.text = roundData.name_4
        
        // 合計スコア
        var par:Int = 0
        var P1P1:Int = 0
        var P1P1_1:Int = 0
        var P1P1_2:Int = 0
        var P1P2:Int = 0
        var P1P2_1:Int = 0
        var P1P2_2:Int = 0
        var P1P3:Int = 0
        var P1P3_1:Int = 0
        var P1P3_2:Int = 0
        var P1P4:Int = 0
        var P1P4_1:Int = 0
        var P1P4_2:Int = 0
        
        for i in 0 ..< 18 {
            if (0 <= roundData.par_num[i]) {
                par = par + roundData.par_num[i]
            }
            if (0 <= roundData.score_my[i]) {
                P1P1 = P1P1 + roundData.score_my[i]
            }
            if (0 <= roundData.score_my_pad[i]) {
                P1P1_1 = P1P1_1 + roundData.score_my_pad[i]
            }
            if (0 <= roundData.score_my_act[i]) {
                P1P1_2 = P1P1_2 + roundData.score_my_act[i]
            }
            if (0 <= roundData.score_2[i]) {
                P1P2 = P1P2 + roundData.score_2[i]
            }
            if (0 <= roundData.score_2_pad[i]) {
                P1P2_1 = P1P2_1 + roundData.score_2_pad[i]
            }
            if (0 <= roundData.score_2_act[i]) {
                P1P2_2 = P1P2_2 + roundData.score_2_act[i]
            }
            if (0 <= roundData.score_3[i]) {
                P1P3 = P1P3 + roundData.score_3[i]
            }
            if (0 <= roundData.score_3_pad[i]) {
                P1P3_1 = P1P3_1 + roundData.score_3_pad[i]
            }
            if (0 <= roundData.score_3_act[i]) {
                P1P3_2 = P1P3_2 + roundData.score_3_act[i]
            }
            if (0 <= roundData.score_4[i]) {
                P1P4 = P1P4 + roundData.score_4[i]
            }
            if (0 <= roundData.score_4_pad[i]) {
                P1P4_1 = P1P4_1 + roundData.score_4_pad[i]
            }
            if (0 <= roundData.score_4_act[i]) {
                P1P4_2 = P1P4_2 + roundData.score_4_act[i]
            }
        }
        
        txtPar1.text = par.description
        txtP1P1.text = P1P1.description
        txtP1P1_1.text = P1P1_1.description
//        txtP1P1_2.text = P1P1_2.description
        txtP1P2.text = P1P2.description
        txtP1P2_1.text = P1P2_1.description
//        txtP1P2_2.text = P1P2_2.description
        txtP1P3.text = P1P3.description
        txtP1P3_1.text = P1P3_1.description
//        txtP1P3_2.text = P1P3_2.description
        txtP1P4.text = P1P4.description
        txtP1P4_1.text = P1P4_1.description
//        txtP1P4_2.text = P1P4_2.description
    }

    // < ボタンを押下した時の処理
    @IBAction func btnBack(_ sender: Any)
    {
        self.performSegue(withIdentifier: "toGolfInputScore2", sender: nil)
    }

    // 削除 ボタンを押下した時の処理
    @IBAction func btnDelete(_ sender: Any)
    {
        let alert = UIAlertController(title: "確認", message: "本当に削除しますか？", preferredStyle: .alert)
        let action1 = UIAlertAction(title: "はい", style: .default, handler: { (_) in
            // realmからラウンド中データを削除
            let appDelegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate
            appDelegate.golfRealmData.deleteGolfCource()
            
            self.performSegue(withIdentifier: "toViewController", sender: nil)
        })
        let action2 = UIAlertAction(title: "いいえ", style: .default, handler: { (_) in
            // 何もしない
        })
        alert.addAction(action1)
        alert.addAction(action2)
        self.present(alert, animated: true, completion: nil)
    }

    // 保存 ボタンを押下した時の処理
    @IBAction func btnSave(_ sender: Any)
    {
        let alert = UIAlertController(title: "確認", message: "終了してスコア一覧に登録しますか？\n後で一覧から編集できます。", preferredStyle: .alert)
        let action1 = UIAlertAction(title: "はい", style: .default, handler: { (_) in
            let appDelegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate
            appDelegate.golfRealmData.saveGolfCource()
            self.performSegue(withIdentifier: "toViewController", sender: nil)
        })
        let action2 = UIAlertAction(title: "いいえ", style: .default, handler: { (_) in
            // 何もしない
        })
        alert.addAction(action1)
        alert.addAction(action2)
        self.present(alert, animated: true, completion: nil)
    }

    // 戻るボタンを押下した時の処理
    @IBAction func btnBackThouchDown(_ sender: Any)
    {
        // ViewControllerを表示する
        self.performSegue(withIdentifier: "toViewController", sender: nil)
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

}

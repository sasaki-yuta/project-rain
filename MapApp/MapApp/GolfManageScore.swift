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
                       GADBannerViewDelegate,
                       UITableViewDelegate,
                       UITableViewDataSource{

    @IBOutlet weak var btnBack: UIButton!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet var startDate: UIDatePicker!
    @IBOutlet var endDate: UIDatePicker!
    @IBOutlet var lbl_startDate: UILabel!
    @IBOutlet var lbl_endDate: UILabel!    // ボタン 開始

    var rithtBtn = UIButton(type: UIButton.ButtonType.system)//: UIButton!
    var bannerView: GADBannerView!  // Google AddMod広告
    var defineClass:Define = Define()

    var data = [
            ["ベストスコア",""],
            ["総ラウンド数",""],
            ["平均スコア",""],
            ["チップイン数",""],
            ["ホールインワン数",""],
            ["イーグル以上",""],
            ["バーディー数",""],
            ["パー数",""],
            ["ボギー数",""],
            ["ダブルボギー数",""],
            ["トリプルボギー以上",""],
        ]
    
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
        let dispSize: CGSize = UIScreen.main.bounds.size
        let width = Int(dispSize.width)
        let height = Int(dispSize.height)

        lbl_startDate.frame = CGRect(x:25, y:100, width:50, height:30)
        startDate.frame = CGRect(x:75+10, y:100, width:100, height:30)
        lbl_endDate.frame = CGRect(x:185+10, y:100, width:50, height:30)
        endDate.frame = CGRect(x:245+10, y:100, width:100, height:30)

        tableView.frame = CGRect(x:10, y:150, width:width-20, height:height-150-130)
        
        // スコア一蘭ボタン表示
        rithtBtn.addTarget(self, action: #selector(btnStart(_:)), for: UIControl.Event.touchUpInside)
        rithtBtn.setTitle("スコア一覧", for: UIControl.State.normal)
        rithtBtn.frame = CGRect(x:width - 100, y:44, width:30, height:30)
        rithtBtn.sizeToFit() // サイズを決める(自動調整)
        self.view.addSubview(rithtBtn)
    }
    
    // スコア一覧画 ボタンを押下した時の処理
    @IBAction func btnStart(_ sender: Any)
    {
        // スコア一覧画面表示
        self.performSegue(withIdentifier: "GolfManageScore2", sender: nil)
    }
    
    // セルの個数を指定するデリゲートメソッド（必須）
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    // セルに値を設定するデータソースメソッド（必須）
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // セルを取得する
        let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)

        // TableViewCellの中に配置したLabelを取得する
        let label1 = cell.contentView.viewWithTag(1) as! UILabel
        let label2 = cell.contentView.viewWithTag(2) as! UILabel

        // Labelにテキストを設定する
        label1.text = data[indexPath.row][0]
        label2.text = data[indexPath.row][1]

        return cell
    }
}

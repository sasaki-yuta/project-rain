//
//  GolfManageScore2.swift
//  MapApp
//
//  Created by 佐々木勇太 on 2021/10/31.
//  Copyright © 2021 rain-00-00-09. All rights reserved.
//

import Foundation
import GoogleMobileAds

class GolfManageScore2: UIViewController,
                        GADBannerViewDelegate,
                        UITableViewDelegate,
                        UITableViewDataSource{

    @IBOutlet weak var tableView: UITableView!

    var rithtBtn = UIButton(type: UIButton.ButtonType.system)
    var delBtn = UIButton(type: UIButton.ButtonType.system)
    var showBtn = UIButton(type: UIButton.ButtonType.system)
    var bannerView: GADBannerView!  // Google AddMod広告
    var defineClass:Define = Define()
    
    var data: [[String]] = []
    
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
    
    // 戻るボタンを押下した時の処理
    @IBAction func btnBackThouchDown(_ sender: Any)
    {
        // ViewControllerを表示する
        self.performSegue(withIdentifier: "toViewController", sender: nil)
    }
    
    // 画面の初期描画
    func initView() {
        let dispSize: CGSize = UIScreen.main.bounds.size
        let width = Int(dispSize.width)
        let height = Int(dispSize.height)
    
        tableView.frame = CGRect(x:10, y:100, width:width-20, height:height-100-130)
        // スコア分析ボタン表示
        rithtBtn.addTarget(self, action: #selector(btnStart(_:)), for: UIControl.Event.touchUpInside)
        rithtBtn.setTitle("スコア分析", for: UIControl.State.normal)
        rithtBtn.frame = CGRect(x:width - 100, y:44, width:30, height:30)
        rithtBtn.sizeToFit() // サイズを決める(自動調整)
        self.view.addSubview(rithtBtn)
    }

    // スコア一分析 ボタンを押下した時の処理
    @IBAction func btnStart(_ sender: Any)
    {
        // スコア一覧画面表示
        self.performSegue(withIdentifier: "GolfManageScore", sender: nil)
                }
    
    // セルの個数を指定するデリゲートメソッド（必須）
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let appDelegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate
        let scorelst = appDelegate.golfRealmData.getGolfRoundData()
        return scorelst.count
    }
    
    // セルに値を設定するデータソースメソッド（必須）
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // realmからスコアデータを取得する
        let appDelegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate
        let scorelst = appDelegate.golfRealmData.getGolfRoundData()
        var oneData = ["","","",""]
        oneData[0] = scorelst[indexPath.row].roundDate!
        oneData[1] = scorelst[indexPath.row].courseName!
        oneData[2] = scorelst[indexPath.row].s_total_score.description
        oneData[3] = scorelst[indexPath.row].pid!   // 削除、表示、編集する時に検索する主キー
        data.append(oneData)
        
        // セルを取得する
        let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)

        // TableViewCellの中に配置したLabelを取得する
        let label1 = cell.contentView.viewWithTag(1) as! UILabel
        let label2 = cell.contentView.viewWithTag(2) as! UILabel
        let label3 = cell.contentView.viewWithTag(3) as! UILabel

        // Labelにテキストを設定する
        label1.text = data[indexPath.row][0]
        label2.text = data[indexPath.row][1]
        label3.text = data[indexPath.row][2]

        return cell
    }

    //スワイプしたセルを削除　※arrayNameは変数名に変更してください
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCell.EditingStyle.delete {
            // realmからデータを削除する
            let appDelegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate
            appDelegate.golfRealmData.deleteGolfRoundData(data[indexPath.row][3])


            data.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath as IndexPath], with: UITableView.RowAnimation.automatic)
        }
    }
}

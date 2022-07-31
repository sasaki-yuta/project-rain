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
    var helpBtn: UIButton!

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
        rithtBtn.frame = CGRect(x:width - 120, y:44, width:30, height:30)
        rithtBtn.sizeToFit() // サイズを決める(自動調整)
        self.view.addSubview(rithtBtn)
        
        // helpボタン
        helpBtn = UIButton(type: UIButton.ButtonType.detailDisclosure)
        helpBtn.frame = CGRect(x:width - 40, y:50, width:18, height:18)
        helpBtn.layer.backgroundColor = UIColor(white: 1, alpha: 0.8).cgColor // 背景色
        helpBtn.layer.masksToBounds = false
        helpBtn.layer.shadowColor = UIColor.black.cgColor
        helpBtn.layer.shadowOffset = CGSize(width: 2, height: 2)
        helpBtn.layer.shadowOpacity = 0.2
        helpBtn.layer.shadowRadius = 3 // ぼかし
        helpBtn.layer.cornerRadius = 5.0 // 角丸のサイズ
        helpBtn.addTarget(self, action: #selector(helpBtnThouchDown(_:)), for: UIControl.Event.touchUpInside)
        self.view.addSubview(helpBtn)
    }
    
    // helpボタンを押下した時の処理
    @IBAction func helpBtnThouchDown(_ sender: Any)
    {
        let alert = UIAlertController(title: "操作方法", message: "スコアを選択し、「右スワイプ：削除ボタン」、「左スワイプ：参照ボタン」を表示します。", preferredStyle: .alert)
        let action1 = UIAlertAction(title: "はい", style: .default, handler: { (_) in
            
        })
        alert.addAction(action1)
        self.present(alert, animated: true, completion: nil)
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
        let roundDate = convertDateToString(scorelst[indexPath.row].roundDate!)
        oneData[0] = roundDate.description
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
    
    // 文字列をDate型に変換する
    func convertDateToString(_ strDate: String) -> Date {
        /// 現在のLocaleの取得
        let locale = Locale.current
        let localeId = locale.identifier
        
        // 文字列をDate型に変換する
        let dateformatter = DateFormatter()
        dateformatter.dateFormat = "yyyy/MM/dd HH:mm"   // HH:0-23時間表記 hh:0-11時間表記
        dateformatter.locale = Locale(identifier: localeId)
        let date = dateformatter.date(from: strDate)!
        return date
    }

    // 右へスワイプ
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let action = UIContextualAction(style: .normal, title: "削除") { (action, view, completionHandler) in
            
            let alert = UIAlertController(title: "確認", message: "選択したスコアを削除しますか？", preferredStyle: .alert)
                    let action1 = UIAlertAction(title: "はい", style: .default, handler: { (_) in
                        // realmからデータを削除する
                        let appDelegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate
                        appDelegate.golfRealmData.deleteGolfRoundData(self.data[indexPath.row][3])

                        // tableviewからデータを削除する
                        self.data.remove(at: indexPath.row)
                        tableView.deleteRows(at: [indexPath as IndexPath], with: UITableView.RowAnimation.automatic)
                    })
                    let action2 = UIAlertAction(title: "いいえ", style: .default, handler: { (_) in
                        // 何もしない
                    })
                    alert.addAction(action1)
                    alert.addAction(action2)
            self.present(alert, animated: true, completion: nil)
                
            completionHandler(true) // 処理成功時はtrue/失敗時はfalseを設定する
        }
        let configuration = UISwipeActionsConfiguration(actions: [action])
        return configuration
    }

    // 左へスワイプ
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let action = UIContextualAction(style: .destructive, title: "参照") { (action, view, completionHandler) in
            
            let alert = UIAlertController(title: "確認", message: "ラウンド中のデータがあれば削除されますが良いですか？", preferredStyle: .alert)
                    let action1 = UIAlertAction(title: "はい", style: .default, handler: { (_) in
                        // realmにラウンド中データとして設定する
                        let appDelegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate
                        appDelegate.golfRealmData.setGolfCource(self.data[indexPath.row][3])

                        completionHandler(true) // 処理成功時はtrue/失敗時はfalseを設定する
                        
                        // スコア入力中の場合はスコア入力画面
                        self.performSegue(withIdentifier: "toGolfInputScore2", sender: nil)
                    })
                    let action2 = UIAlertAction(title: "いいえ", style: .default, handler: { (_) in
                        // 何もしない
                    })
                    alert.addAction(action1)
                    alert.addAction(action2)
            self.present(alert, animated: true, completion: nil)
                
            completionHandler(true) // 処理成功時はtrue/失敗時はfalseを設定する
        }
        let configuration = UISwipeActionsConfiguration(actions: [action])
        return configuration
    }
}

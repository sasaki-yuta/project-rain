//
//  CycleSettingViewController.swift
//  MapApp
//
//  Created by yuta sasaki on 2019/08/16.
//  Copyright © 2019 rain-00-00-09. All rights reserved.
//

import UIKit

class CycleSettingViewController: UIViewController {

    @IBOutlet weak var btnBack: UIButton!
    @IBOutlet weak var btnDataInit: UIButton!
    @IBOutlet weak var btnEditInit: UIButton!
    @IBOutlet weak var maxSpeed: UILabel!
    @IBOutlet weak var totalDist: UILabel!
    @IBOutlet weak var totalTime: UILabel!
    
    @IBOutlet weak var lblTotalData: UILabel!
    @IBOutlet weak var lblMaxSpeed: UILabel!
    @IBOutlet weak var lblTotalDist: UILabel!
    @IBOutlet weak var lblTotalTime: UILabel!
    
    @IBOutlet weak var lblEditData: UILabel!
    @IBOutlet weak var lblTimestamp: UILabel!
    @IBOutlet weak var lblAccuracy: UILabel!

    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        initView()
    }
    
    func initView() {
        // デバイスの画面サイズを取得する
        let dispSize: CGSize = UIScreen.main.bounds.size
        let width = Int(dispSize.width)

        // オブジェクトの表示位置設定
        btnDataInit.frame = CGRect(x: width-100, y: 80, width: 100, height: 40)
        self.view.addSubview(btnDataInit)
        btnEditInit.frame = CGRect(x: width-100, y: 300, width: 100, height: 40)
        self.view.addSubview(btnEditInit)
        lblTotalData.frame = CGRect(x: 0, y: 80, width: width, height: 40)
        self.view.addSubview(lblTotalData)
        lblEditData.frame = CGRect(x: 0, y: 300, width: width, height: 40)
        self.view.addSubview(lblEditData)
        
        // 累計データ表示
        let appDelegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate
        // 累計最高速度
        let speed = appDelegate.userDataManager.getTotalMaxSpeed()
        maxSpeed.text = speed.description
        // 累計走行距離
        let dist = appDelegate.userDataManager.getTotalDrivingDist()
        let tmpDist = floor((dist / 1000) * 100) / 100
        totalDist.text = tmpDist.description
        // 累計走行時間
        let time = appDelegate.userDataManager.getTotalDrivingTime()
        let hour = Int(time) / 3600
        let min = (Int(time) - (hour * 3600)) / 60
        let sec = Int(time) - ((hour * 3600) + (min * 60))
        totalTime.text = String(format: "%02d", hour) + ":" +  String(format: "%02d", min) + ":" +  String(format: "%02d", sec)
    }

    // 戻るボタンを押下した時の処理
    @IBAction func btnBackThouchDown(_ sender: Any) {
        // CycleViewControllerを表示する
        self.performSegue(withIdentifier: "toCycleView", sender: nil)
    }

    // データ消去を押下した時の処理
    @IBAction func btnCycleDeleteThouchDown(_ sender: Any) {
        let appDelegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.cycleViewController.deleteData()
        maxSpeed.text = "0.0"
        totalDist.text = "0.0"
        totalTime.text = "00:00:00"
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

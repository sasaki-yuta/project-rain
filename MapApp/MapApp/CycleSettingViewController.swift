//
//  CycleSettingViewController.swift
//  MapApp
//
//  Created by yuta sasaki on 2019/08/16.
//  Copyright © 2019 rain-00-00-09. All rights reserved.
//

import UIKit
import GoogleMobileAds

class CycleSettingViewController:   UIViewController,
                                    UIPickerViewDelegate,
                                    UIPickerViewDataSource,
                                    GADBannerViewDelegate{
    
    // Google AddMod広告
    var bannerView: GADBannerView!
    
    @IBOutlet weak var btnBack: UIButton!
    @IBOutlet weak var btnDataInit: UIButton!
    @IBOutlet weak var btnEditInit: UIButton!
    @IBOutlet weak var maxSpeed: UILabel!
    @IBOutlet weak var totalDist: UILabel!
    @IBOutlet weak var totalTime: UILabel!
    
    @IBOutlet weak var lblTotalData: UILabel!
    @IBOutlet weak var lblTimeInterval: UILabel!
    @IBOutlet weak var lblTimeInterval2: UILabel!
    @IBOutlet weak var lblAccuracy: UILabel!
    @IBOutlet weak var lblAccuracy2: UILabel!

    @IBOutlet weak var lblEditData: UILabel!

    @IBOutlet weak var pickerTimeInterval:UIPickerView!
    let lstTimeInterval = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "10"]
    let lstAccuracy = ["5", "10", "15", "20", "25", "30", "35", "40"]
    
    override func viewDidLoad()
    {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        // Google AddMod広告
        bannerView = GADBannerView(adSize: kGADAdSizeBanner) //320×50
        addBannerViewToView(bannerView)

        bannerView.adUnitID = "ca-app-pub-3940256099942544/2934735716"//←テストID
//        bannerView.adUnitID = "ca-app-pub-3106594758397593/3761431592"//←本物のID
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
    
    func initView()
    {
        let appDelegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate
        
        // デバイスの画面サイズを取得する
        let dispSize: CGSize = UIScreen.main.bounds.size
        let width = Int(dispSize.width)

        // オブジェクトの表示位置設定
        lblTotalData.frame = CGRect(x: 0, y: 80, width: width, height: 40)
        self.view.addSubview(lblTotalData)
        lblEditData.frame = CGRect(x: 0, y: 300, width: width, height: 40)
        self.view.addSubview(lblEditData)
        btnDataInit.frame = CGRect(x: width-100, y: 80, width: 100, height: 40)
        self.view.addSubview(btnDataInit)
        btnEditInit.frame = CGRect(x: width-100, y: 300, width: 100, height: 40)
        self.view.addSubview(btnEditInit)
        lblTimeInterval.frame = CGRect(x: 0, y:340 , width: width/2, height: 60)
        self.view.addSubview(lblTimeInterval)
        lblAccuracy.frame = CGRect(x: width/2, y:340 , width: width/2, height: 60)
        self.view.addSubview(lblAccuracy)
        lblTimeInterval2.frame = CGRect(x: 0, y:500 , width: width/2, height: 60)
        self.view.addSubview(lblTimeInterval2)
        lblAccuracy2.frame = CGRect(x: width/2, y:500 , width: width/2, height: 60)
        self.view.addSubview(lblAccuracy2)
        pickerTimeInterval.frame = CGRect(x: 0, y:400 , width: width, height: 100)
        pickerTimeInterval.delegate = self
        pickerTimeInterval.dataSource = self
        
        // GPS補正ピッカーの表示
        viewPicker()
        
        var speed: Double! = 0.0
        var dist: Double! = 0.0
        var time: Double! = 0.0
        
        // ゴルフモード
        if .MODE_CYCLE == appDelegate.nowMapMode {
            // 累計最高速度
            speed = appDelegate.userDataManager.getTotalMaxSpeed()
            // 累計走行距離
            dist = appDelegate.userDataManager.getTotalDrivingDist()
            // 累計走行時間
            time = appDelegate.userDataManager.getTotalDrivingTime()
        }
        // ウォークモード
        else {
            // 累計最高速度
            speed = appDelegate.userDataManager.getTotalWalkMaxSpeed()
            // 累計走行距離
            dist = appDelegate.userDataManager.getTotalWalkDrivingDist()
            // 累計走行時間
            time = appDelegate.userDataManager.getTotalWalkDrivingTime()
        }
        
        maxSpeed.text = speed.description
        let tmpDist = floor((dist / 1000) * 100) / 100
        totalDist.text = tmpDist.description
        let hour = Int(time) / 3600
        let min = (Int(time) - (hour * 3600)) / 60
        let sec = Int(time) - ((hour * 3600) + (min * 60))
        totalTime.text = String(format: "%02d", hour) + ":" +  String(format: "%02d", min) + ":" +  String(format: "%02d", sec)
        
    }

    // GPS補正ピッカーの表示
    func viewPicker()
    {
        let appDelegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate

        var interval: Int = 0
        var interval2: Int = 0
        
        // ゴルフモード
        if .MODE_CYCLE == appDelegate.nowMapMode {
            interval = appDelegate.userDataManager.getTimeInterval()
            interval2 = appDelegate.userDataManager.getAccuracy()
        }
        // ウォークモード
        else {
            interval = appDelegate.userDataManager.getTimeWalkInterval()
            interval2 = appDelegate.userDataManager.getAccuracyWalk()
        }

        var cnt_num = 0
        for cnt in 0 ..< lstTimeInterval.count
        {
            if interval == Int(lstTimeInterval[cnt])
            {
                cnt_num = cnt
                break
            }
        }
        pickerTimeInterval.selectRow(cnt_num, inComponent: 0, animated: true)
        
        var cnt_num2 = 0
        for cnt in 0 ..< lstAccuracy.count
        {
            if interval2 == Int(lstAccuracy[cnt])
            {
                cnt_num2 = cnt
                break
            }
        }
        pickerTimeInterval.selectRow(cnt_num2, inComponent: 1, animated: true)
        self.view.addSubview(pickerTimeInterval)
    }
    
    // 戻るボタンを押下した時の処理
    @IBAction func btnBackThouchDown(_ sender: Any)
    {
        let appDelegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate
        // ゴルフモード
        if .MODE_CYCLE == appDelegate.nowMapMode {
            // CycleViewControllerを表示する
            self.performSegue(withIdentifier: "toCycleView", sender: nil)
        }
        // ウォークモード
        else {
            // WalkViewControllerを表示する
            self.performSegue(withIdentifier: "toWalkViewFromSetting", sender: nil)
        }
    }

    // データ消去を押下した時の処理
    @IBAction func btnCycleDeleteThouchDown(_ sender: Any)
    {
        let appDelegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate
        // ゴルフモード
        if .MODE_CYCLE == appDelegate.nowMapMode {
            appDelegate.cycleViewController.deleteData()
        }
        // ウォークモード
        else {
            appDelegate.walkViewController.deleteData()
        }

        maxSpeed.text = "0.0"
        totalDist.text = "0.0"
        totalTime.text = "00:00:00"
    }
    
    // 計測制度データ消去を押下した時の処理
    @IBAction func btnCycleDeleteSetupThouchDown(_ sender: Any)
    {
        let appDelegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate
        // ゴルフモード
        if .MODE_CYCLE == appDelegate.nowMapMode {
            appDelegate.userDataManager.deleteCycleSetupData()
        }
        // ウォークモード
        else {
            appDelegate.userDataManager.deleteWalkSetupData()
        }
        viewPicker()
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
     {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    func numberOfComponents(in pickerView: UIPickerView) -> Int
    {
        // // 表示する列数
        return 2
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int
    {
        if component == 0
        {
            return lstTimeInterval.count
        }
        else
        {
            return lstAccuracy.count
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String?
    {
        // 表示する文字列を返す
        if component == 0
        {
            return lstTimeInterval[row]
        }
        else
        {
            return lstAccuracy[row]
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int)
    {
        let appDelegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate
        // 選択時の処理
        if component == 0
        {
            let interval:Int! = Int(lstTimeInterval[row])
            // ゴルフモード
            if .MODE_CYCLE == appDelegate.nowMapMode {
                appDelegate.userDataManager.setTimeInterval(interval)
            }
            // ウォークモード
            else {
                appDelegate.userDataManager.setTimeWalkInterval(interval)
            }
        }
        else
        {
            let accuracy:Int! = Int(lstAccuracy[row])
            // ゴルフモード
            if .MODE_CYCLE == appDelegate.nowMapMode {
                appDelegate.userDataManager.setAccuracy(accuracy)
            }
            // ウォークモード
            else {
                appDelegate.userDataManager.setAccuracyWalk(accuracy)
            }
        }
        
        // ゴルフモード
        if .MODE_CYCLE == appDelegate.nowMapMode {
            appDelegate.userDataManager.saveCycleData()
        }
        // ウォークモード
        else {
            appDelegate.userDataManager.saveWalkData()
        }
    }
}

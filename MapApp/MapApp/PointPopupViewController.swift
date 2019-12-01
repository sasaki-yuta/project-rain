//
//  PointPopupViewController.swift
//  MapApp
//
//  Created by yuta sasaki on 2019/12/01.
//  Copyright © 2019 rain-00-00-09. All rights reserved.
//

import UIKit

class PointPopupViewController: UIViewController {
    
    @IBOutlet weak var lblDistance: UILabel!
    @IBOutlet weak var lblStreetAddr: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        initView()
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    // Viewの初期化
    func initView() {
        let appDelegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate
        lblDistance.text = appDelegate.cycleViewController.getTapDistance().description
        self.view.addSubview(lblDistance)

        lblStreetAddr.text = "住所 \n" + appDelegate.cycleViewController.getTapStreetAddr().description
        self.view.addSubview(lblStreetAddr)
    }
}

//
//  Define.swift
//  MapApp
//
//  Created by 佐々木勇太 on 2021/08/13.
//  Copyright © 2021 rain-00-00-09. All rights reserved.
//

import Foundation

class Define: NSObject {
    let isTest = true
    let adUnitID_test = "ca-app-pub-3940256099942544/2934735716"//←テストID
    let adUnitID = "ca-app-pub-3106594758397593/3761431592"//←本物のID

    // Google AddMod広告のUNIT IDを返す
    func getAddModUnitID() -> String {
        var retval = adUnitID
        if isTest {
            retval = adUnitID_test
        }
        return retval
    }
}

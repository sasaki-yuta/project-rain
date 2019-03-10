//
//  InterfaceController.swift
//  MapAppWatch Extension
//
//  Created by yuta sasaki on 2019/03/09.
//  Copyright © 2019 rain-00-00-09. All rights reserved.
//

import WatchKit
import Foundation
import WatchConnectivity //sasaki


class InterfaceController:  WKInterfaceController,
                            WCSessionDelegate //sasaki
{
    var session = WCSession.default
    @IBOutlet weak var label: WKInterfaceLabel! //sasaki
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        
        // Configure interface objects here.
        if (WCSession.isSupported()) {
            self.session = WCSession.default
            self.session.delegate = self
            self.session.activate()
        }
    }
    
    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
    }
    
    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }

    //sasaki start
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
    }
    
    public func session(_ session: WCSession, didReceiveMessage message: [String : Any], replyHandler: @escaping ([String : Any]) -> Swift.Void){
        print("receiveMessage::\(message)")
        
        guard let kind = message["body"] as? String else {
            return
        }
        
        label.setText(kind)
    }
    public func session(_ session: WCSession, didReceiveMessageData messageData: Data, replyHandler: @escaping (Data) -> Void) {
        print("receiveMessageData::\(messageData)")
    }
    public func session(_ session: WCSession, didFinish userInfoTransfer: WCSessionUserInfoTransfer, error: Error?) {
        print("userInfoTransfer::\(userInfoTransfer)")
        
    }
    public func session(_ session: WCSession, didReceiveUserInfo userInfo: [String : Any] = [:]){
        print("didReceiveUserInfo::\(userInfo)");
    }
    
    public func session(_ session: WCSession, didReceiveApplicationContext applicationContext: [String : Any])
    {
        print("didReceiveApplicationContext::\(applicationContext)");
    }
    //sasaki end
}

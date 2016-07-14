//
//  ProgressView.swift
//  QXJS
//
//  Created by Yachen Dai on 7/6/16.
//  Copyright © 2016 qxjs. All rights reserved.
//

import UIKit

class ProgressView: UIView {

    @IBOutlet var progressValueLb: UILabel!
    var progressValue : Int32 = 0
     private var foregroundNotification: NSObjectProtocol!
    
    override func drawRect(rect: CGRect)
    {
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(ProgressView.progressNoti(_:)), name: UPDATEPROCESS, object: nil)
        foregroundNotification = NSNotificationCenter.defaultCenter().addObserverForName(UIApplicationWillEnterForegroundNotification, object: nil, queue: NSOperationQueue.mainQueue()) {
            [unowned self] notification in
            self.showProgress()
            // do whatever you want when the app is brought back to the foreground
        }
        self.showProgress()
    }

    func progressNoti(notification: NSNotification)
    {
        self.showProgress()
    }
    
    func showProgress()
    {
        self.progressValue = updateProgress
        if progressValueLb == nil
        {
            return
        }
        dispatch_async(dispatch_get_main_queue()) {
            self.progressValueLb.text = "\(String(self.progressValue)) %"
        }
        if progressValue == 100
        {
            NSNotificationCenter.defaultCenter().removeObserver(foregroundNotification)
            self.removeFromSuperview()
        }
    }
}

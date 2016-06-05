//
//  StuffView.swift
//  QXJS
//
//  Created by Yachen Dai on 2/28/16.
//  Copyright © 2016 qxjs. All rights reserved.
//

import UIKit

class StuffView: UIView {

    @IBOutlet var scrollView: UIScrollView!
    var showImgDelegate : ShowImgDelegate?
    
    override func drawRect(rect: CGRect)
    {
        return
//        self.scrollView.contentSize = self.scrollView.frame.size
//        let tapMainImgViewRecognizer = UITapGestureRecognizer(target: self, action: #selector(HonourView.onImgViewTapped(_:)))
//        scrollView.addGestureRecognizer(tapMainImgViewRecognizer)
    }
    
    func onImgViewTapped(sender : UITapGestureRecognizer)
    {
        print(sender.view?.tag)
        let touchLocation = sender.locationInView(self.scrollView)
        self.scrollView.subviews.map {
            if $0.isMemberOfClass(UIImageView)
            {
                if touchLocation.x > $0.frame.origin.x && touchLocation.x < ($0.frame.size.width + $0.frame.origin.x)
                    && touchLocation.y > $0.frame.origin.y && touchLocation.y < ($0.frame.size.height + $0.frame.origin.y)
                {
                    self.showImgDelegate!.showImgOnView(($0 as! UIImageView).image?.copy() as! UIImage, imageSize: (($0 as! UIImageView).frame.size))
                }
            }
        }
    }

}

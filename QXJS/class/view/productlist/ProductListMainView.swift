//
//  ProductListMainView.swift
//  QXJS
//
//  Created by Yachen Dai on 2/4/16.
//  Copyright © 2016 qxjs. All rights reserved.
//

import UIKit

class ProductListMainView: UIView {

    @IBOutlet var navBtn1: UIButton!
    @IBOutlet var navBtn2: UIButton!
    @IBOutlet var navBtn3: UIButton!
    @IBOutlet var navBtn4: UIButton!
    @IBOutlet var selectedView: UIView!
    
    @IBOutlet var productListScrollView: UIScrollView!
    
    
    override func drawRect(rect: CGRect) {
        // Drawing code
        let contentWidth = 447 * 2 + 10 + 15 * 2
        let contentHeight = 290 * 3 + 15 * 2 + 10 * 2
        self.productListScrollView.contentSize = CGSizeMake(CGFloat(contentWidth), CGFloat(contentHeight))
    }
    
    @IBAction func navBtnClick(sender: UIButton) {
        selectedView.frame.origin.x = sender.frame.origin.x
    }
    

}

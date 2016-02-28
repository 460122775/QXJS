//
//  CompanyBrandView.swift
//  QXJS
//
//  Created by Yachen Dai on 2/26/16.
//  Copyright © 2016 qxjs. All rights reserved.
//

import UIKit

class CompanyBrandView: UIView {
    
    var companyBrandNavDelegate : CompanyBrandNavDelegate?
    var brandDetail11 : BrandDetail11?

    override func drawRect(rect: CGRect)
    {
        // Drawing code
    }
    
    @IBAction func btn11Click(sender: UIButton)
    {
        brandDetail11 = ((NSBundle.mainBundle().loadNibNamed("BrandDetail11", owner: self, options: nil) as NSArray).lastObject as? BrandDetail11)!
        companyBrandNavDelegate?.gotoThirdClassView(brandDetail11!)
    }
    
    @IBAction func btn12Click(sender: UIButton) {
    }
    
    @IBAction func btn13Click(sender: UIButton) {
    }
    
    @IBAction func btn21Click(sender: UIButton) {
    }

    @IBAction func btn22Click(sender: UIButton) {
    }
}

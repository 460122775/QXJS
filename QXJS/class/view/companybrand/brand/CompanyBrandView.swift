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
    var currentDetailView : UIView?

    override func drawRect(rect: CGRect)
    {
        // Drawing code
    }
    
    @IBAction func btn11Click(sender: UIButton)
    {
        currentDetailView = ((NSBundle.mainBundle().loadNibNamed("BrandDetail11", owner: self, options: nil) as NSArray).lastObject as? UIView)!
        companyBrandNavDelegate?.gotoThirdClassView(currentDetailView!)
    }
    
    @IBAction func btn12Click(sender: UIButton)
    {
        currentDetailView = ((NSBundle.mainBundle().loadNibNamed("BrandDetail12", owner: self, options: nil) as NSArray).lastObject as? UIView)!
        companyBrandNavDelegate?.gotoThirdClassView(currentDetailView!)
    }
    
    @IBAction func btn13Click(sender: UIButton)
    {
        currentDetailView = ((NSBundle.mainBundle().loadNibNamed("BrandDetail13", owner: self, options: nil) as NSArray).lastObject as? UIView)!
        companyBrandNavDelegate?.gotoThirdClassView(currentDetailView!)
    }
    
    @IBAction func btn21Click(sender: UIButton)
    {
        currentDetailView = ((NSBundle.mainBundle().loadNibNamed("BrandDetail21", owner: self, options: nil) as NSArray).lastObject as? UIView)!
        companyBrandNavDelegate?.gotoThirdClassView(currentDetailView!)
    }

    @IBAction func btn22Click(sender: UIButton)
    {
        currentDetailView = ((NSBundle.mainBundle().loadNibNamed("BrandDetail22", owner: self, options: nil) as NSArray).lastObject as? UIView)!
        companyBrandNavDelegate?.gotoThirdClassView(currentDetailView!)
    }
}

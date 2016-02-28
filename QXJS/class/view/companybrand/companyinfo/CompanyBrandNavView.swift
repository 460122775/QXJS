//
//  CompanyInfoView.swift
//  QXJS
//
//  Created by Yachen Dai on 2/25/16.
//  Copyright © 2016 qxjs. All rights reserved.
//

import UIKit

protocol CompanyBrandNavDelegate
{
    func gotoThirdClassView(subView : UIView)
}

class CompanyBrandNavView: UIView, CompanyBrandNavDelegate{
   
    @IBOutlet var navView: UIView!
    @IBOutlet var navBtnView: UIView!
    
    
    var companyBrandDelegate : CompanyBrandDelegate?
    var companyInfoView : CompanyInfoView?
    var contactInfoView : ContactInfoView?
    var companyBrandView : CompanyBrandView?
    var thirdClassView : UIView?
    
    @IBOutlet var mainView: UIView!
    
    override func drawRect(rect: CGRect)
    {
        // Drawing code
    }
    
    
    @IBAction func backBtnClick(sender: UIButton)
    {
        if thirdClassView != nil
        {
            thirdClassView?.removeFromSuperview()
            thirdClassView = nil
            self.navBtnView.hidden = false
        }else{
            companyBrandDelegate?.navBtnClick(sender)
        }
    }
    
    @IBAction func cultureBtnClick(sender: UIButton)
    {
        self.mainView.subviews.map { $0.removeFromSuperview() }
        if companyInfoView == nil
        {
            companyInfoView = ((NSBundle.mainBundle().loadNibNamed("CompanyInfoView", owner: self, options: nil) as NSArray).lastObject as? CompanyInfoView)!
        }
        self.mainView.addSubview(companyInfoView!)
    }
    
    @IBAction func progressBtnClick(sender: UIButton)
    {
        self.mainView.subviews.map { $0.removeFromSuperview() }
    }
    
    @IBAction func stuffBtnClick(sender: UIButton)
    {
        self.mainView.subviews.map { $0.removeFromSuperview() }
    }
    
    @IBAction func honourBtnClick(sender: UIButton)
    {
        self.mainView.subviews.map { $0.removeFromSuperview() }
    }
    
    @IBAction func brandBtnClick(sender: UIButton)
    {
        self.mainView.subviews.map { $0.removeFromSuperview() }
        if companyBrandView == nil
        {
            companyBrandView = ((NSBundle.mainBundle().loadNibNamed("CompanyBrandView", owner: self, options: nil) as NSArray).lastObject as? CompanyBrandView)!
            companyBrandView?.companyBrandNavDelegate = self
        }
        self.mainView.addSubview(companyBrandView!)
    }
    
    @IBAction func contactBtnClick(sender: UIButton)
    {
        self.mainView.subviews.map { $0.removeFromSuperview() }
        if contactInfoView == nil
        {
            contactInfoView = ((NSBundle.mainBundle().loadNibNamed("ContactInfoView", owner: self, options: nil) as NSArray).lastObject as? ContactInfoView)!
        }
        self.mainView.addSubview(contactInfoView!)
    }

    func gotoThirdClassView(subView : UIView)
    {
        thirdClassView = subView
        subView.frame.origin.y = self.navView.frame.size.height
        self.navBtnView.hidden = true
        self.addSubview(subView)
    }
}

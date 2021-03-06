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
    @IBOutlet var selectedView: UIView!
    @IBOutlet weak var selectedViewLeading: NSLayoutConstraint!
    
    @IBOutlet var cultureBtn: UIButton!
    @IBOutlet var progressBtn: UIButton!
    @IBOutlet var stuffBtn: UIButton!
    @IBOutlet var honourBtn: UIButton!
    @IBOutlet var brandBtn: UIButton!
    @IBOutlet var contactBtn: UIButton!
    
    var companyBrandDelegate : CompanyBrandDelegate?
    var showImgDelegate : ShowImgDelegate?
    var companyInfoView : CompanyInfoView?
    var companyProgressView : CompanyProgressView?
    var contactInfoView : ContactInfoView?
    var companyBrandView : CompanyBrandView?
    var honourView : HonourView?
    var stuffView : StuffView?
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
        selectedViewLeading.constant = cultureBtn.frame.origin.x
        self.mainView.subviews.map { $0.removeFromSuperview() }
        if companyInfoView == nil
        {
            companyInfoView = ((NSBundle.mainBundle().loadNibNamed("CompanyInfoView", owner: self, options: nil) as NSArray).lastObject as? CompanyInfoView)!
        }
        self.mainView.addSubview(companyInfoView!)
    }
    
    @IBAction func progressBtnClick(sender: UIButton)
    {
        selectedViewLeading.constant = progressBtn.frame.origin.x
        self.mainView.subviews.map { $0.removeFromSuperview() }
        if companyProgressView == nil
        {
            companyProgressView = ((NSBundle.mainBundle().loadNibNamed("CompanyProgressView", owner: self, options: nil) as NSArray).lastObject as? CompanyProgressView)!
        }
        self.mainView.addSubview(companyProgressView!)
    }
    
    @IBAction func stuffBtnClick(sender: UIButton)
    {
        selectedViewLeading.constant = stuffBtn.frame.origin.x
        self.mainView.subviews.map { $0.removeFromSuperview() }
        if stuffView == nil
        {
            stuffView = ((NSBundle.mainBundle().loadNibNamed("StuffView", owner: self, options: nil) as NSArray).lastObject as? StuffView)!
        }
        self.mainView.addSubview(stuffView!)
    }
    
    @IBAction func honourBtnClick(sender: UIButton)
    {
        selectedViewLeading.constant = honourBtn.frame.origin.x
        self.mainView.subviews.map { $0.removeFromSuperview() }
        if honourView == nil
        {
            honourView = ((NSBundle.mainBundle().loadNibNamed("HonourView", owner: self, options: nil) as NSArray).lastObject as? HonourView)!
            honourView?.showImgDelegate = self.showImgDelegate
        }
        self.mainView.addSubview(honourView!)
    }
    
    @IBAction func brandBtnClick(sender: UIButton)
    {
        selectedViewLeading.constant = brandBtn.frame.origin.x
        self.mainView.subviews.map { $0.removeFromSuperview() }
        if companyBrandView == nil
        {
            companyBrandView = ((NSBundle.mainBundle().loadNibNamed("CompanyBrandView", owner: self, options: nil) as NSArray).lastObject as? CompanyBrandView)!
            companyBrandView?.companyBrandNavDelegate = self
            companyBrandView?.showImgDelegate = self.showImgDelegate
        }
        self.mainView.addSubview(companyBrandView!)
    }
    
    @IBAction func contactBtnClick(sender: UIButton)
    {
        selectedViewLeading.constant = contactBtn.frame.origin.x
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

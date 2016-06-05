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
    var tapImgViewRecognizer : UITapGestureRecognizer?
    var showImgDelegate : ShowImgDelegate?
    
    override func drawRect(rect: CGRect)
    {
        // Drawing code
        tapImgViewRecognizer = UITapGestureRecognizer(target: self, action: #selector(CompanyBrandView.onImgViewTapped(_:)))
    }
    
    func onImgViewTapped(sender : UITapGestureRecognizer)
    {
        let mainImgView = sender.view?.viewWithTag(99) as? UIImageView
        if mainImgView == nil
        {
            return
        }
        self.showImgDelegate!.showImgOnView(mainImgView!.image?.copy() as! UIImage, imageSize: mainImgView!.frame.size)
    }
    
    @IBAction func btn11Click(sender: UIButton)
    {
        if self.currentDetailView != nil
        {
            self.currentDetailView?.removeGestureRecognizer(self.tapImgViewRecognizer!)
        }
        currentDetailView = ((NSBundle.mainBundle().loadNibNamed("BrandDetail11", owner: self, options: nil) as NSArray).lastObject as? UIView)!
        currentDetailView!.addGestureRecognizer(tapImgViewRecognizer!)
        companyBrandNavDelegate?.gotoThirdClassView(currentDetailView!)
    }
    
    @IBAction func btn12Click(sender: UIButton)
    {
        if self.currentDetailView != nil
        {
            self.currentDetailView?.removeGestureRecognizer(self.tapImgViewRecognizer!)
        }
        currentDetailView = ((NSBundle.mainBundle().loadNibNamed("BrandDetail12", owner: self, options: nil) as NSArray).lastObject as? UIView)!
        currentDetailView!.addGestureRecognizer(tapImgViewRecognizer!)
        companyBrandNavDelegate?.gotoThirdClassView(currentDetailView!)
    }
    
    @IBAction func btn13Click(sender: UIButton)
    {
        if self.currentDetailView != nil
        {
            self.currentDetailView?.removeGestureRecognizer(self.tapImgViewRecognizer!)
        }
        currentDetailView = ((NSBundle.mainBundle().loadNibNamed("BrandDetail13", owner: self, options: nil) as NSArray).lastObject as? UIView)!
        currentDetailView!.addGestureRecognizer(tapImgViewRecognizer!)
        companyBrandNavDelegate?.gotoThirdClassView(currentDetailView!)
    }
    
    @IBAction func btn21Click(sender: UIButton)
    {
        if self.currentDetailView != nil
        {
            self.currentDetailView?.removeGestureRecognizer(self.tapImgViewRecognizer!)
        }
        currentDetailView = ((NSBundle.mainBundle().loadNibNamed("BrandDetail21", owner: self, options: nil) as NSArray).lastObject as? UIView)!
        currentDetailView!.addGestureRecognizer(tapImgViewRecognizer!)
        companyBrandNavDelegate?.gotoThirdClassView(currentDetailView!)
    }

    @IBAction func btn22Click(sender: UIButton)
    {
        if self.currentDetailView != nil
        {
            self.currentDetailView?.removeGestureRecognizer(self.tapImgViewRecognizer!)
        }
        currentDetailView = ((NSBundle.mainBundle().loadNibNamed("BrandDetail22", owner: self, options: nil) as NSArray).lastObject as? UIView)!
        currentDetailView!.addGestureRecognizer(tapImgViewRecognizer!)
        companyBrandNavDelegate?.gotoThirdClassView(currentDetailView!)
    }
}

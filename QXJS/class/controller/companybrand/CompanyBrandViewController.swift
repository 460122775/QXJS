//
//  CompanyBrandViewController.swift
//  QXJS
//
//  Created by Yachen Dai on 2/3/16.
//  Copyright © 2016 qxjs. All rights reserved.
//

import UIKit

class CompanyBrandViewController: UIViewController, CompanyBrandDelegate
{
    
    @IBOutlet var mainMenuContainer : UIView!
    @IBOutlet var mainContainer : UIView!
    var companyBrandMainView : CompanyBrandMainView!
    var mainMenuView : MainMenuView!
    var companyBrandNavView : CompanyBrandNavView?
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?)
    {
        
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        if mainMenuView == nil
        {
            mainMenuView = MainMenuView.sharedInstance()
        }
        mainMenuView.removeFromSuperview()
        mainMenuContainer.addSubview(mainMenuView)
        if companyBrandMainView == nil
        {
            companyBrandMainView = ((NSBundle.mainBundle().loadNibNamed("CompanyBrandMainView", owner: self, options: nil) as NSArray).lastObject as? CompanyBrandMainView)!
            companyBrandMainView.companyBrandDelegate = self
        }
        companyBrandMainView.removeFromSuperview()
        mainContainer.addSubview(companyBrandMainView)
    }
    
    // CompanyBrandDelegate.
    func navBtnClick(navBtn: UIButton)
    {
        if companyBrandNavView == nil
        {
            companyBrandNavView = ((NSBundle.mainBundle().loadNibNamed("CompanyBrandNavView", owner: self, options: nil) as NSArray).lastObject as? CompanyBrandNavView)!
            companyBrandNavView?.companyBrandDelegate = self
        }
        
        if navBtn.tag == 0
        {
            companyBrandNavView!.removeFromSuperview()
            return
        }else if navBtn.tag == 1{
            companyBrandNavView?.cultureBtnClick(navBtn)
        }else if navBtn.tag == 2{
            companyBrandNavView?.progressBtnClick(navBtn)
        }else if navBtn.tag == 3{
            companyBrandNavView?.stuffBtnClick(navBtn)
        }else if navBtn.tag == 4{
            companyBrandNavView?.honourBtnClick(navBtn)
        }else if navBtn.tag == 5{
            companyBrandNavView?.brandBtnClick(navBtn)
        }else if navBtn.tag == 6{
            companyBrandNavView?.contactBtnClick(navBtn)
        }
        self.view.addSubview(companyBrandNavView!)
    }
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

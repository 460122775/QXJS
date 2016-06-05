//
//  MainMenuView.swift
//  QXJS
//
//  Created by Yachen Dai on 2/3/16.
//  Copyright © 2016 qxjs. All rights reserved.
//

import UIKit

var mainMenuViewInstance : MainMenuView?

class MainMenuView: UIView {
    @IBOutlet var companyBrandBtn : UIButton!
    @IBOutlet var productListBtn : UIButton!
    @IBOutlet var newsBtn : UIButton!
    @IBOutlet var collocationBtn: UIButton!
    @IBOutlet var technologyBtn: UIButton!
    @IBOutlet var storesBtn: UIButton!
    @IBOutlet var customBtn: UIButton!
    @IBOutlet var settingBtn: UIButton!

    class func sharedInstance() -> MainMenuView
    {
        if mainMenuViewInstance == nil{
            mainMenuViewInstance = ((NSBundle.mainBundle().loadNibNamed("MainMenuView", owner: self, options: nil) as NSArray).lastObject as? MainMenuView)
        }
        return mainMenuViewInstance!
    }
    
    override func drawRect(rect: CGRect)
    {
        // Drawing code
        
    }
    
    func setNormalState()
    {
        companyBrandBtn.tag = 0
        companyBrandBtn.setBackgroundImage(UIImage(named: "icon1_normal_menu"), forState: UIControlState.Normal)
        productListBtn.tag = 0
        productListBtn.setBackgroundImage(UIImage(named: "icon2_normal_menu"), forState: UIControlState.Normal)
        newsBtn.tag = 0
        newsBtn.setBackgroundImage(UIImage(named: "icon3_normal_menu"), forState: UIControlState.Normal)
        collocationBtn.tag = 0
        collocationBtn.setBackgroundImage(UIImage(named: "icon4_normal_menu"), forState: UIControlState.Normal)
        technologyBtn.tag = 0
        technologyBtn.setBackgroundImage(UIImage(named: "icon5_normal_menu"), forState: UIControlState.Normal)
        storesBtn.tag = 0
        storesBtn.setBackgroundImage(UIImage(named: "icon6_normal_menu"), forState: UIControlState.Normal)
        customBtn.tag = 0
        customBtn.setBackgroundImage(UIImage(named: "icon7_normal_menu"), forState: UIControlState.Normal)
        settingBtn.tag = 0
        settingBtn.setBackgroundImage(UIImage(named: "icon8_normal_menu"), forState: UIControlState.Normal)
    }
    
    @IBAction func companyBrandBtnClick(sender: UIButton?)
    {
        if companyBrandBtn.tag == 0
        {
            setNormalState()
            companyBrandBtn.tag = 1
            companyBrandBtn.setBackgroundImage(UIImage(named: "icon1_highlight_menu"), forState: UIControlState.Normal)
            let companyBrandViewController = CompanyBrandViewController(nibName: "CompanyBrandViewController", bundle: nil)
            (UIApplication.sharedApplication().delegate as! AppDelegate).window?.rootViewController?.presentViewController(companyBrandViewController, animated: false, completion: nil)
            (UIApplication.sharedApplication().delegate as! AppDelegate).window?.rootViewController = companyBrandViewController
        }
    }
    
    @IBAction func productListBtnClick(sender: UIButton?)
    {
        if productListBtn.tag == 0
        {
            setNormalState()
            productListBtn.tag = 1
            productListBtn.setBackgroundImage(UIImage(named: "icon2_highlight_menu"), forState: UIControlState.Normal)
            let productListViewController = ProductListViewController(nibName: "ProductListViewController", bundle: nil)
            (UIApplication.sharedApplication().delegate as! AppDelegate).window?.rootViewController?.presentViewController(productListViewController, animated: false, completion: nil)
            (UIApplication.sharedApplication().delegate as! AppDelegate).window?.rootViewController = productListViewController
        }
    }

    @IBAction func newsBtnClick(sender: UIButton?)
    {
        if newsBtn.tag == 0
        {
            setNormalState()
            newsBtn.tag = 1
            newsBtn.setBackgroundImage(UIImage(named: "icon3_highlight_menu"), forState: UIControlState.Normal)
            let newsViewController = NewsViewController(nibName: "NewsViewController", bundle: nil)
            (UIApplication.sharedApplication().delegate as! AppDelegate).window?.rootViewController?.presentViewController(newsViewController, animated: false, completion: nil)
            (UIApplication.sharedApplication().delegate as! AppDelegate).window?.rootViewController = newsViewController
        }
    }

    @IBAction func collocationBtnClick(sender: UIButton?)
    {
        if collocationBtn.tag == 0
        {
            setNormalState()
            collocationBtn.tag = 1
            collocationBtn.setBackgroundImage(UIImage(named: "icon4_highlight_menu"), forState: UIControlState.Normal)
            let collocationViewController = CollocationViewController(nibName: "CollocationViewController", bundle: nil)
            (UIApplication.sharedApplication().delegate as! AppDelegate).window?.rootViewController?.presentViewController(collocationViewController, animated: false, completion: nil)
            (UIApplication.sharedApplication().delegate as! AppDelegate).window?.rootViewController = collocationViewController
        }
    }
    
    @IBAction func technologyBtnClick(sender: UIButton?)
    {
        if technologyBtn.tag == 0
        {
            setNormalState()
            technologyBtn.tag = 1
            technologyBtn.setBackgroundImage(UIImage(named: "icon5_highlight_menu"), forState: UIControlState.Normal)
        }
        let technologyViewController = TechnologyViewController(nibName: "TechnologyViewController", bundle: nil)
        (UIApplication.sharedApplication().delegate as! AppDelegate).window?.rootViewController?.presentViewController(technologyViewController, animated: false, completion: nil)
        (UIApplication.sharedApplication().delegate as! AppDelegate).window?.rootViewController = technologyViewController
    }
    
    @IBAction func storesBtnClick(sender: UIButton?)
    {
        if storesBtn.tag == 0
        {
            setNormalState()
            storesBtn.tag = 1
            storesBtn.setBackgroundImage(UIImage(named: "icon6_highlight_menu"), forState: UIControlState.Normal)
            let storeViewController = StoreViewController(nibName: "StoreViewController", bundle: nil)
            (UIApplication.sharedApplication().delegate as! AppDelegate).window?.rootViewController?.presentViewController(storeViewController, animated: false, completion: nil)
            (UIApplication.sharedApplication().delegate as! AppDelegate).window?.rootViewController = storeViewController
        }
    }
    
    @IBAction func customBtnClick(sender: UIButton?)
    {
        if customBtn.tag == 0
        {
            setNormalState()
            customBtn.tag = 1
            customBtn.setBackgroundImage(UIImage(named: "icon7_highlight_menu"), forState: UIControlState.Normal)
            let customViewController = CustomViewController(nibName: "CustomViewController", bundle: nil)
            (UIApplication.sharedApplication().delegate as! AppDelegate).window?.rootViewController?.presentViewController(customViewController, animated: false, completion: nil)
            (UIApplication.sharedApplication().delegate as! AppDelegate).window?.rootViewController = customViewController
        }
    }
    
    @IBAction func settingBtnClick(sender: UIButton?)
    {
        if settingBtn.tag == 0
        {
            setNormalState()
            settingBtn.tag = 1
            settingBtn.setBackgroundImage(UIImage(named: "icon8_highlight_menu"), forState: UIControlState.Normal)
            let settingViewController = SettingViewController(nibName: "SettingViewController", bundle: nil)
            (UIApplication.sharedApplication().delegate as! AppDelegate).window?.rootViewController?.presentViewController(settingViewController, animated: false, completion: nil)
            (UIApplication.sharedApplication().delegate as! AppDelegate).window?.rootViewController = settingViewController
        }
    }
    
}

//
//  ProductListViewController.swift
//  QXJS
//
//  Created by Yachen Dai on 2/4/16.
//  Copyright © 2016 qxjs. All rights reserved.
//

import UIKit

class SettingViewController: UIViewController,UpdateInfoViewDelegate, UpdateStoreViewDelegate
{

    @IBOutlet var mainMenuContainer : UIView!
    @IBOutlet var mainContainer : UIView!
    @IBOutlet var usernameLabel: UILabel!
    @IBOutlet var userRoleLabel: UILabel!
    @IBOutlet var storeNameLabel: UILabel!
    @IBOutlet var storeAddressLabel: UILabel!
    @IBOutlet var phoneLabel: UILabel!
    @IBOutlet var logoutBtn: UIButton!
    
    var mainMenuView : MainMenuView!
    var delegate = DownloadSessionDelegate.sharedInstance
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?)
    {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init?(coder aDecoder: NSCoder)
    {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        mainMenuView = MainMenuView.sharedInstance()
        mainMenuView.removeFromSuperview()
        mainMenuContainer.addSubview(mainMenuView)
    }
    
    override func viewWillAppear(animated: Bool)
    {
        self.usernameLabel.text = "用 户 名：" + CurrentUserName!
        if CurrentUserRole == 4
        {
            self.userRoleLabel.text = "用户角色：超级管理员"
        }else if CurrentUserRole == 3{
            self.userRoleLabel.text = "用户角色：管理员"
        }else if CurrentUserRole == 2{
            self.userRoleLabel.text = "用户角色：店长"
        }else if CurrentUserRole == 1{
            self.userRoleLabel.text = "用户角色：店员"
        }
        self.updateStoreSuccess()
    }
    
    func updateStoreSuccess()
    {
        self.storeNameLabel.text = CurrentStoreName
        if CurrentStoreAddress != nil
        {
            self.storeAddressLabel.text = "地址：" + CurrentStoreAddress!
        }else{
            self.storeAddressLabel.text = "地址：--"
        }
        if CurrentStorePhone != nil
        {
            self.phoneLabel.text = "电话：" + CurrentStorePhone!
        }else{
            self.phoneLabel.text = "电话：--"
        }
        
    }
    
    @IBAction func updateInfoBtnClick(sender: AnyObject)
    {
        let updateInfoView : UpdateInfoView! = NSBundle.mainBundle().loadNibNamed("UpdateInfoView", owner: nil, options: nil)[0] as? UpdateInfoView
        updateInfoView.delegate = self
        self.view.addSubview(updateInfoView)
    }
    
    func updateInfoSuccess()
    {
        self.logoutBtnClick(self.logoutBtn)
    }
    
    @IBAction func updateStoreInfoBtnClick(sender: AnyObject)
    {
        let updateStoreInfoView : UpdateStoreInfoView! = NSBundle.mainBundle().loadNibNamed("UpdateStoreInfoView", owner: nil, options: nil)[0] as? UpdateStoreInfoView
        updateStoreInfoView.delegate = self
        self.view.addSubview(updateStoreInfoView)
    }
    
    var firstClick : Bool = true
    @IBAction func downloadDataBtnClick(sender: UIButton)
    {
        if firstClick
        {
            firstClick = false
            let progressView : ProgressView! = NSBundle.mainBundle().loadNibNamed("ProgressView", owner: nil, options: nil)[0] as? ProgressView
            self.view.window?.addSubview(progressView)
            SettingModel.UpdateDataControl()
            firstClick = true
        }
//        else{
//            let configuration = NSURLSessionConfiguration.backgroundSessionConfigurationWithIdentifier(SessionProperties.identifier)
//            let backgroundSession = NSURLSession(configuration: configuration, delegate: self.delegate, delegateQueue: nil)
//            SettingModel.cacheFile(configuration, backgroundSession: backgroundSession)
//        }
    }

    @IBAction func logoutBtnClick(sender: UIButton)
    {
        CurrentUserId = 0
        NSUserDefaults.standardUserDefaults().removeObjectForKey("CurrentUserId")
        CurrentUserName = ""
        NSUserDefaults.standardUserDefaults().removeObjectForKey("CurrentUserName")
        CurrentUserPwd = ""
        NSUserDefaults.standardUserDefaults().removeObjectForKey("CurrentUserPwd")
        CurrentStoreId = 0
        NSUserDefaults.standardUserDefaults().removeObjectForKey("CurrentStoreId")
        CurrentUserRole = 0
        NSUserDefaults.standardUserDefaults().removeObjectForKey("CurrentUserRole")
        CurrentStoreName = ""
        NSUserDefaults.standardUserDefaults().removeObjectForKey("CurrentStoreName")
        CurrentStoreAddress = ""
        NSUserDefaults.standardUserDefaults().removeObjectForKey("CurrentStoreAddress")
        CurrentStorePhone = ""
        NSUserDefaults.standardUserDefaults().removeObjectForKey("CurrentStorePhone")
        
        let loginViewController = LoginViewController(nibName: "LoginViewController", bundle: nil)
        (UIApplication.sharedApplication().delegate as! AppDelegate).window?.rootViewController?.presentViewController(loginViewController, animated: false, completion: nil)
        (UIApplication.sharedApplication().delegate as! AppDelegate).window?.rootViewController = loginViewController
    }
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

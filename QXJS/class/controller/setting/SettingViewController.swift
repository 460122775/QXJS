//
//  ProductListViewController.swift
//  QXJS
//
//  Created by Yachen Dai on 2/4/16.
//  Copyright © 2016 qxjs. All rights reserved.
//

import UIKit

class SettingViewController: UIViewController
{

    @IBOutlet var mainMenuContainer : UIView!
    @IBOutlet var mainContainer : UIView!
    
    @IBOutlet var clauseDetailBtn: UIButton!
    @IBOutlet var lawDetailBtn: UIButton!
    @IBOutlet var aboutusDetailBtn: UIButton!
    
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
        
        clauseDetailBtn.layer.borderWidth = 1
        clauseDetailBtn.layer.cornerRadius = 4
        clauseDetailBtn.layer.borderColor = UIColor(red: 240 / 255, green: 240 / 255, blue: 240 / 255, alpha: 1).CGColor
        lawDetailBtn.layer.borderWidth = 1
        lawDetailBtn.layer.cornerRadius = 4
        lawDetailBtn.layer.borderColor = UIColor(red: 240 / 255, green: 240 / 255, blue: 240 / 255, alpha: 1).CGColor
        aboutusDetailBtn.layer.borderWidth = 1
        aboutusDetailBtn.layer.cornerRadius = 4
        aboutusDetailBtn.layer.borderColor = UIColor(red: 240 / 255, green: 240 / 255, blue: 240 / 255, alpha: 1).CGColor
    }
    
    var firstClick : Bool = true
    @IBAction func downloadDataBtnClick(sender: UIButton)
    {
        if firstClick
        {
            firstClick = false
            SettingModel.downloadDataControl()
        }else{
            let configuration = NSURLSessionConfiguration.backgroundSessionConfigurationWithIdentifier(SessionProperties.identifier)
            let backgroundSession = NSURLSession(configuration: configuration, delegate: self.delegate, delegateQueue: nil)
            SettingModel.cacheFile(configuration, backgroundSession: backgroundSession)
        }
    }

    @IBAction func logoutBtnClick(sender: UIButton)
    {
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

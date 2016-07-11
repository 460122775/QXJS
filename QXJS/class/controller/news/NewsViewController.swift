//
//  ProductListViewController.swift
//  QXJS
//
//  Created by Yachen Dai on 2/4/16.
//  Copyright © 2016 qxjs. All rights reserved.
//

import UIKit

class NewsViewController: UIViewController
{

    @IBOutlet var mainMenuContainer : UIView!
    @IBOutlet var mainContainer : UIView!
    
    @IBOutlet var subViewContainer: UIView!
    var newsMainView : NewsMainView!
    var mainMenuView : MainMenuView!
    var currentView : UIView?
    
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
        newsMainView = ((NSBundle.mainBundle().loadNibNamed("NewsMainView", owner: self, options: nil) as NSArray).lastObject as? NewsMainView)!
        currentView = newsMainView
        subViewContainer.addSubview(newsMainView)
    }

    @IBAction func segValueChanged(sender: UISegmentedControl)
    {
        if sender.selectedSegmentIndex == 0
        {
            
        }else if CurrentUserRole <= 1{
            SwiftNotice.showText("请使用店长及以上权限的账户登录")
        }else{
            
        }
    }
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

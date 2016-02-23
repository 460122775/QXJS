//
//  CompanyBrandViewController.swift
//  QXJS
//
//  Created by Yachen Dai on 2/3/16.
//  Copyright © 2016 qxjs. All rights reserved.
//

import UIKit

class CompanyBrandViewController: UIViewController
{
    
    @IBOutlet var mainMenuContainer : UIView!
    @IBOutlet var mainContainer : UIView!
    var companyBrandMainView : CompanyBrandMainView!
    var mainMenuView : MainMenuView!
    
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
        }
        companyBrandMainView.removeFromSuperview()
        mainContainer.addSubview(companyBrandMainView)
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

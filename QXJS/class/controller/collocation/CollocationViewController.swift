//
//  ProductListViewController.swift
//  QXJS
//
//  Created by Yachen Dai on 2/4/16.
//  Copyright © 2016 qxjs. All rights reserved.
//

import UIKit

class CollocationViewController: UIViewController, CollocationDetailDelegate
{

    @IBOutlet var mainMenuContainer : UIView!
    @IBOutlet var mainContainer : UIView!
    
    var collocationDetailView : CollocationDetailView!
    var mainMenuView : MainMenuView!
    
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
    
    override func viewDidAppear(animated: Bool)
    {
        super.viewDidAppear(animated)
    }

    @IBAction func detailBtnClick(sender: UIButton)
    {
        collocationDetailView = ((NSBundle.mainBundle().loadNibNamed("CollocationDetailView", owner: self, options: nil) as NSArray).lastObject as? CollocationDetailView)!
        collocationDetailView.collocationDetailDelegate = self
        self.view.addSubview(collocationDetailView)
        collocationDetailView.initByData(CollocationModel.getCollocationData()!)
    }
    
    func goBackBtnClick()
    {
        collocationDetailView.removeFromSuperview()
    }
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

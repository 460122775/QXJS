//
//  ProductListViewController.swift
//  QXJS
//
//  Created by Yachen Dai on 2/4/16.
//  Copyright © 2016 qxjs. All rights reserved.
//

import UIKit

class NewsViewController: UIViewController, InputPasseordViewDelegate
{

    @IBOutlet var mainMenuContainer : UIView!
    @IBOutlet var mainContainer : UIView!
    @IBOutlet var titleSeg: UISegmentedControl!
    
    @IBOutlet var subViewContainer: UIView!
    var newsMainView : NewsMainView!
    var mainMenuView : MainMenuView!
    var currentIndex : Int = -1
    
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
        subViewContainer.addSubview(newsMainView)
        self.titleSeg.selectedSegmentIndex = 0
    }
    
    override func viewWillAppear(animated: Bool)
    {
        super.viewWillAppear(animated)
        self.segValueChanged(self.titleSeg)
    }

    @IBAction func segValueChanged(sender: UISegmentedControl)
    {
        if sender.selectedSegmentIndex == 0 && self.currentIndex != 0
        {
            self.currentIndex = 0
            newsMainView.showNewsData()
        }else if sender.selectedSegmentIndex == 1{
            let inputPasswordView : InputPasswordView = (NSBundle.mainBundle().loadNibNamed("InputPasswordView", owner: nil, options: nil)[0] as? InputPasswordView)!
            inputPasswordView.delegate = self
            self.view.addSubview(inputPasswordView)
        }
    }
    
    func inputPwdRight()
    {
        self.currentIndex = 1
        newsMainView.showActivityData()
    }   
    
    func inputPwdWrong()
    {
        self.titleSeg.selectedSegmentIndex = 0
    }
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

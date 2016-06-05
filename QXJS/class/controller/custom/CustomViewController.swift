//
//  ProductListViewController.swift
//  QXJS
//
//  Created by Yachen Dai on 2/4/16.
//  Copyright © 2016 qxjs. All rights reserved.
//

import UIKit

protocol CustomViewDelegate {
    func showCustomDetail(dataDic : NSMutableDictionary)
}

class CustomViewController: UIViewController, CustomViewDelegate, OrderViewDelegate
{

    @IBOutlet var mainMenuContainer : UIView!
    @IBOutlet var mainContainer : UIView!
    
    var mainMenuView : MainMenuView!
    var customMainView : CustomMainView!
    var customDataArr : NSMutableArray?
    var orderView : OrderView?
    
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
        self.customMainView = ((NSBundle.mainBundle().loadNibNamed("CustomMainView", owner: self, options: nil) as NSArray).lastObject as? CustomMainView)!
        self.mainContainer.addSubview(self.customMainView)
        self.customMainView.customDelegate = self
    }
    
    override func viewDidAppear(animated: Bool)
    {
        self.customDataArr = CustomModel.getCustomData()
        if customDataArr == nil || customDataArr?.count == 0
        {
            
        }else{
            self.customMainView.initViewByData(self.customDataArr!)
        }
    }
    
    func showCustomDetail(dataDic: NSMutableDictionary)
    {
        let orderDataArr = CustomModel.getOrderData((dataDic.objectForKey("customId") as! NSNumber).longLongValue)
        if self.orderView == nil
        {
            self.orderView = ((NSBundle.mainBundle().loadNibNamed("OrderView", owner: self, options: nil) as NSArray).lastObject as? OrderView)!
            self.orderView!.orderViewDelegate = self
        }
        self.mainContainer.addSubview(self.orderView!)
        self.orderView?.initViewByData(orderDataArr, _customData: dataDic)
    }

    // Order main view delegate.
    func orderMainViewReturnBack() {
        self.orderView?.removeFromSuperview()
    }
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

//
//  ProductListViewController.swift
//  QXJS
//
//  Created by Yachen Dai on 2/4/16.
//  Copyright © 2016 qxjs. All rights reserved.
//

import UIKit

class ProductListViewController: UIViewController, ProductListMainDelegate, ProductDetailDelegate
{

    @IBOutlet var mainMenuContainer : UIView!
    @IBOutlet var mainContainer : UIView!
    
    var productListMainView : ProductListMainView!
    var productDetailView : ProductDetailView?
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
        productListMainView = ((NSBundle.mainBundle().loadNibNamed("ProductListMainView", owner: self, options: nil) as NSArray).lastObject as? ProductListMainView)!
        productListMainView.productListMainDelegate = self
        productListMainView.removeFromSuperview()
        mainContainer.addSubview(productListMainView)
    }
    
    func showDetailView(selectGroupDic : NSMutableDictionary)
    {
        if productDetailView == nil
        {
            productDetailView = ((NSBundle.mainBundle().loadNibNamed("ProductDetailView", owner: self, options: nil) as NSArray).lastObject as? ProductDetailView)!
            productDetailView?.productDetailDelegate = self
        }
        self.view.addSubview(productDetailView!)
        productDetailView!.initWithGroup(selectGroupDic)
    }
    
    func goBackToMainView()
    {
        productDetailView?.removeFromSuperview()
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

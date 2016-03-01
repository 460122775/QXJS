//
//  ProductListViewController.swift
//  QXJS
//
//  Created by Yachen Dai on 2/4/16.
//  Copyright © 2016 qxjs. All rights reserved.
//

import UIKit

class TechnologyViewController: UIViewController, TechnologyViewDelegate
{

    @IBOutlet var mainMenuContainer : UIView!
    @IBOutlet var mainContainer : UIView!
    @IBOutlet var detailViewContainer: UIView!
    
    var currentDetailView : UIView?
    var technologyMainView : TechnologyMainView!
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
        technologyMainView = ((NSBundle.mainBundle().loadNibNamed("TechnologyMainView", owner: self, options: nil) as NSArray).lastObject as? TechnologyMainView)!
        technologyMainView.technologyViewDelegate = self
        technologyMainView.removeFromSuperview()
        mainContainer.addSubview(technologyMainView)
        
        let tapDetailViewRecognizer = UITapGestureRecognizer(target: self, action: "onDetailViewTapped")
        detailViewContainer.addGestureRecognizer(tapDetailViewRecognizer)

    }
    
    func onDetailViewTapped()
    {
        detailViewContainer.hidden = true
        currentDetailView?.removeFromSuperview()
        technologyMainView.showDetailLabel()
        currentDetailView = nil
    }
    
    func showDetailViewByTag(tag: Int)
    {
        if tag == 1
        {
            let technologyDetail1View = ((NSBundle.mainBundle().loadNibNamed("TechnologyDetail1View", owner: self, options: nil) as NSArray).lastObject as? UIView)!
            currentDetailView = technologyDetail1View
        }else if tag == 2{
            let technologyDetail2View = ((NSBundle.mainBundle().loadNibNamed("TechnologyDetail2View", owner: self, options: nil) as NSArray).lastObject as? UIView)!
            currentDetailView = technologyDetail2View
        }else if tag == 3{
            let technologyDetail3View = ((NSBundle.mainBundle().loadNibNamed("TechnologyDetail3View", owner: self, options: nil) as NSArray).lastObject as? UIView)!
            currentDetailView = technologyDetail3View
        }else if tag == 4{
            let technologyDetail4View = ((NSBundle.mainBundle().loadNibNamed("TechnologyDetail4View", owner: self, options: nil) as NSArray).lastObject as? UIView)!
            currentDetailView = technologyDetail4View
        }else if tag == 5{
            let technologyDetail5View = ((NSBundle.mainBundle().loadNibNamed("TechnologyDetail5View", owner: self, options: nil) as NSArray).lastObject as? UIView)!
            currentDetailView = technologyDetail5View
        }else if tag == 6{
            let technologyDetail6View = ((NSBundle.mainBundle().loadNibNamed("TechnologyDetail6View", owner: self, options: nil) as NSArray).lastObject as? UIView)!
            currentDetailView = technologyDetail6View
        }else if tag == 7{
            let technologyDetail7View = ((NSBundle.mainBundle().loadNibNamed("TechnologyDetail7View", owner: self, options: nil) as NSArray).lastObject as? UIView)!
            currentDetailView = technologyDetail7View
        }else if tag == 8{
            let technologyDetail8View = ((NSBundle.mainBundle().loadNibNamed("TechnologyDetail8View", owner: self, options: nil) as NSArray).lastObject as? UIView)!
            currentDetailView = technologyDetail8View
        }else if tag == 9{
            let technologyDetail9View = ((NSBundle.mainBundle().loadNibNamed("TechnologyDetail9View", owner: self, options: nil) as NSArray).lastObject as? UIView)!
            currentDetailView = technologyDetail9View
        }else if tag == 10{
            let technologyDetail10View = ((NSBundle.mainBundle().loadNibNamed("TechnologyDetail10View", owner: self, options: nil) as NSArray).lastObject as? UIView)!
            currentDetailView = technologyDetail10View
        }else if tag == 11{
            let technologyDetail11View = ((NSBundle.mainBundle().loadNibNamed("TechnologyDetail11View", owner: self, options: nil) as NSArray).lastObject as? UIView)!
            currentDetailView = technologyDetail11View
        }
        currentDetailView?.center = self.view.center
        self.view.addSubview(currentDetailView!)
        detailViewContainer.hidden = false
    }
    
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

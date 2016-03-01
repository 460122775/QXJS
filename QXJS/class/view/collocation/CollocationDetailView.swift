//
//  ProductListMainView.swift
//  QXJS
//
//  Created by Yachen Dai on 2/4/16.
//  Copyright © 2016 qxjs. All rights reserved.
//

import UIKit

protocol CollocationDetailDelegate
{
    func goBackBtnClick()
}

class CollocationDetailView: UIView
{
    var collocationDetailDelegate : CollocationDetailDelegate?
    @IBOutlet var mainImgView: UIImageView!
    @IBOutlet var rightChoiceView: UIView!
    
    
    override func drawRect(rect: CGRect)
    {
        let tapMainImgViewRecognizer = UITapGestureRecognizer(target: self, action: "onMainImgViewTapped")
        mainImgView.addGestureRecognizer(tapMainImgViewRecognizer)
    }
    
    func onMainImgViewTapped()
    {
        rightChoiceView.hidden = false
    }

    @IBAction func goBackBtnClick(sender: UIButton)
    {
        collocationDetailDelegate?.goBackBtnClick()
    }
    
    @IBAction func closeBtnClick(sender: UIButton)
    {
        rightChoiceView.hidden = true
    }
}

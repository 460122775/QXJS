//
//  ProductListMainView.swift
//  QXJS
//
//  Created by Yachen Dai on 2/4/16.
//  Copyright © 2016 qxjs. All rights reserved.
//

import UIKit

protocol TechnologyViewDelegate
{
    func showDetailViewByTag(tag : Int)
}

class TechnologyMainView: UIView {

    @IBOutlet var sofaNormalImg: UIImageView!
    @IBOutlet var sofaBgImgView: UIImageView!
    @IBOutlet var sofaDetailView: UIView!
    @IBOutlet var detailLabel: UILabel!
    @IBOutlet var sofaDetailImgView: UIImageView!
    
    var technologyViewDelegate : TechnologyViewDelegate?
    
    override func drawRect(rect: CGRect)
    {
        // Drawing code
        let tapNormalImgRecognizer = UITapGestureRecognizer(target: self, action: #selector(TechnologyMainView.onNormalImgTapped(_:)))
        sofaNormalImg.addGestureRecognizer(tapNormalImgRecognizer)
        
        let tapDetailImgRecognizer = UITapGestureRecognizer(target: self, action: #selector(TechnologyMainView.onDetailImgTapped(_:)))
        sofaDetailImgView.addGestureRecognizer(tapDetailImgRecognizer)
    }

    func onNormalImgTapped(recognizer:UITapGestureRecognizer)
    {
        sofaNormalImg.hidden = true
        sofaDetailView.hidden = false
        detailLabel.text = "点击沙发返回效果图"
    }
    
    func onDetailImgTapped(recognizer:UITapGestureRecognizer)
    {
        sofaDetailView.hidden = true
        sofaNormalImg.hidden = false
        detailLabel.text = "点击沙发显示细节图"
    }
    
    @IBAction func detailBtnClick(sender: UIButton)
    {
        technologyViewDelegate?.showDetailViewByTag(sender.tag)
        detailLabel.hidden = true
    }
    
    func showDetailLabel()
    {
        detailLabel.hidden = false
    }
}

//
//  CompanyBrandMainView.swift
//  QXJS
//
//  Created by Yachen Dai on 2/3/16.
//  Copyright © 2016 qxjs. All rights reserved.
//

import UIKit

protocol CompanyBrandDelegate
{
    func navBtnClick(navBtn : UIButton)
}

class CompanyBrandMainView: UIView {
    
    var companyBrandDelegate : CompanyBrandDelegate?
    
    override func drawRect(rect: CGRect)
    {
        
    }
    
    @IBAction func navBtnClick(sender: UIButton)
    {
       companyBrandDelegate?.navBtnClick(sender)
    }
}

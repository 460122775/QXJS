//
//  ContactInfoView.swift
//  QXJS
//
//  Created by Yachen Dai on 2/25/16.
//  Copyright © 2016 qxjs. All rights reserved.
//

import UIKit

class ContactInfoView: UIView
{
    
    var companyBrandDelegate : CompanyBrandDelegate?

    override func drawRect(rect: CGRect)
    {

    }
    
    @IBAction func backBtnClick(sender: UIButton)
    {
        companyBrandDelegate!.navBtnClick(sender)
    }

}

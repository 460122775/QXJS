//
//  ProductListTableViewCell.swift
//  QXJS
//
//  Created by Yachen Dai on 3/29/16.
//  Copyright © 2016 qxjs. All rights reserved.
//

import UIKit

protocol CustomTableViewCellDelegate
{
    func onSelectProductImg(productDic : NSMutableDictionary)
}

class CustomTableViewCell : UITableViewCell {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var sexLabel: UILabel!
    @IBOutlet weak var ageLabel: UILabel!
    @IBOutlet weak var phoneLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    
    var _dataDic : NSMutableDictionary?
    var delegate : CustomTableViewCellDelegate?

    required init?(coder aDecoder: NSCoder)
    {
        super.init(coder: aDecoder)
    }
    
    override func awakeFromNib()
    {
        super.awakeFromNib()
        // Initialization code
    }

    func setDataDic(data : NSMutableDictionary?, index : Int, selected : Bool)
    {
        self._dataDic = data
        if self._dataDic == nil
        {
            self.nameLabel.text = nil
            self.sexLabel.text = nil
            self.ageLabel.text = nil
            self.phoneLabel.text = nil
            self.addressLabel.text = nil
        }else{
            self.nameLabel.text = self._dataDic?.objectForKey("customName") as? String
            self.sexLabel.text = self._dataDic?.objectForKey("sex") as? String
            self.ageLabel.text = String(format: "%i", (self._dataDic?.objectForKey("age") as! NSNumber).longLongValue)
            self.phoneLabel.text = self._dataDic?.objectForKey("phone") as? String
            self.addressLabel.text = self._dataDic?.objectForKey("address") as? String
        }
        self.setBgStyle(index, selected: selected)
    }
    
    func setBgStyle(index : Int, selected : Bool)
    {
        if selected
        {
            self.nameLabel.backgroundColor = UIColor.lightGrayColor()
            self.sexLabel.backgroundColor = UIColor.lightGrayColor()
            self.ageLabel.backgroundColor = UIColor.lightGrayColor()
            self.phoneLabel.backgroundColor = UIColor.lightGrayColor()
            self.addressLabel.backgroundColor = UIColor.lightGrayColor()
        }else if index % 2 == 0{
            self.nameLabel.backgroundColor = UIColor(red: CGFloat(225/255.0), green: CGFloat(225/255.0), blue: CGFloat(225/255.0), alpha: 1)
            self.sexLabel.backgroundColor = UIColor(red: CGFloat(225/255.0), green: CGFloat(225/255.0), blue: CGFloat(225/255.0), alpha: 1)
            self.ageLabel.backgroundColor = UIColor(red: CGFloat(225/255.0), green: CGFloat(225/255.0), blue: CGFloat(225/255.0), alpha: 1)
            self.phoneLabel.backgroundColor = UIColor(red: CGFloat(225/255.0), green: CGFloat(225/255.0), blue: CGFloat(225/255.0), alpha: 1)
            self.addressLabel.backgroundColor = UIColor(red: CGFloat(225/255.0), green: CGFloat(225/255.0), blue: CGFloat(225/255.0), alpha: 1)
        }else{
            self.nameLabel.backgroundColor = UIColor.whiteColor()
            self.sexLabel.backgroundColor = UIColor.whiteColor()
            self.ageLabel.backgroundColor = UIColor.whiteColor()
            self.phoneLabel.backgroundColor = UIColor.whiteColor()
            self.addressLabel.backgroundColor = UIColor.whiteColor()
        }
    }
}

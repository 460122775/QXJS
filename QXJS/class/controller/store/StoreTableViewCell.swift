//
//  ProductListTableViewCell.swift
//  QXJS
//
//  Created by Yachen Dai on 3/29/16.
//  Copyright © 2016 qxjs. All rights reserved.
//

import UIKit

protocol StoreTableViewCellDelegate
{
    func onSelectProductImg(productDic : NSMutableDictionary)
}

class StoreTableViewCell : UITableViewCell {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var storeImgView: UIImageView!
    @IBOutlet weak var phoneLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    
    var _dataDic : NSMutableDictionary?
    var delegate : StoreTableViewCellDelegate?

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
            self.storeImgView.image = nil
            self.phoneLabel.text = nil
            self.addressLabel.text = nil
        }else{
            self.nameLabel.text = self._dataDic?.objectForKey("storeName") as? String
            self.storeImgView.image = UIImage(named: self._dataDic?.objectForKey("img") as! String)
            self.addressLabel.text = self._dataDic?.objectForKey("address") as? String
            self.phoneLabel.text = self._dataDic?.objectForKey("phone") as? String
            self.addressLabel.text = self._dataDic?.objectForKey("address") as? String
        }
        self.setBgStyle(index, selected: selected)
    }
    
    func setBgStyle(index : Int, selected : Bool)
    {
        if selected
        {
            self.backgroundColor = UIColor.lightGrayColor()
        }else{
            self.backgroundColor = UIColor.whiteColor()
        }
    }
}

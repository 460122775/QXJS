//
//  ProductListTableViewCell.swift
//  QXJS
//
//  Created by Yachen Dai on 3/29/16.
//  Copyright © 2016 qxjs. All rights reserved.
//

import UIKit

protocol OrderTableViewCellDelegate
{
//    func onSelectProductImg(productDic : NSMutableDictionary)
}

class OrderTableViewCell : UITableViewCell {
    
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var commentLabel: UILabel!
    
    var _dataDic : NSMutableDictionary?
    var delegate : OrderTableViewCellDelegate?

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
            self.timeLabel.text = nil
            self.contentLabel.text = nil
            self.addressLabel.text = nil
            self.commentLabel.text = nil
        }else{
            self.timeLabel.text = self._dataDic?.objectForKey("time") as? String
            self.contentLabel.text = self._dataDic?.objectForKey("content") as? String
            self.addressLabel.text = self._dataDic?.objectForKey("address") as? String
            self.commentLabel.text = self._dataDic?.objectForKey("content") as? String
        }
        self.setBgStyle(index, selected: selected)
    }
    
    func setBgStyle(index : Int, selected : Bool)
    {
        if selected
        {
            self.timeLabel.backgroundColor = UIColor.lightGrayColor()
            self.contentLabel.backgroundColor = UIColor.lightGrayColor()
            self.addressLabel.backgroundColor = UIColor.lightGrayColor()
            self.commentLabel.backgroundColor = UIColor.lightGrayColor()
        }else if index % 2 == 0{
            self.timeLabel.backgroundColor = UIColor(red: CGFloat(225/255.0), green: CGFloat(225/255.0), blue: CGFloat(225/255.0), alpha: 1)
            self.contentLabel.backgroundColor = UIColor(red: CGFloat(225/255.0), green: CGFloat(225/255.0), blue: CGFloat(225/255.0), alpha: 1)
            self.addressLabel.backgroundColor = UIColor(red: CGFloat(225/255.0), green: CGFloat(225/255.0), blue: CGFloat(225/255.0), alpha: 1)
            self.commentLabel.backgroundColor = UIColor(red: CGFloat(225/255.0), green: CGFloat(225/255.0), blue: CGFloat(225/255.0), alpha: 1)
        }else{
            self.timeLabel.backgroundColor = UIColor.whiteColor()
            self.contentLabel.backgroundColor = UIColor.whiteColor()
            self.addressLabel.backgroundColor = UIColor.whiteColor()
            self.commentLabel.backgroundColor = UIColor.whiteColor()
        }
    }
}

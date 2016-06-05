//
//  ProductListTableViewCell.swift
//  QXJS
//
//  Created by Yachen Dai on 3/29/16.
//  Copyright © 2016 qxjs. All rights reserved.
//

import UIKit

protocol ProductListTableViewCellDelegate
{
    func onSelectProductImg(productDic : NSMutableDictionary)
}

class ProductListTableViewCell: UITableViewCell {
    var leftImgView: UIImageView!
    var rightImgView: UIImageView!
    
    var _leftProductDic : NSMutableDictionary?
    var _rightProductDic : NSMutableDictionary?
    var productListTableViewCellDelegate : ProductListTableViewCellDelegate?

    required init(coder aDecoder: NSCoder)
    {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String!)
    {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.frame.size = CGSizeMake(934, 305)
        let width = (self.frame.size.width - 30) / 2
        let height = self.frame.size.height - 20
        if self.leftImgView == nil
        {
            self.leftImgView = UIImageView(frame:CGRectMake(10, 10, width, height))
            self.addSubview(self.leftImgView)
            self.leftImgView.userInteractionEnabled = true
            let tapLeftImgViewRecognizer = UITapGestureRecognizer(target: self, action: #selector(ProductListTableViewCell.onLeftImgViewTapped))
            self.leftImgView.addGestureRecognizer(tapLeftImgViewRecognizer)
        }
        
        if self.rightImgView == nil
        {
            self.rightImgView = UIImageView(frame:CGRectMake(width + 10 + 10, 10, width, height))
            self.addSubview(self.rightImgView)
            self.rightImgView.userInteractionEnabled = true
            let tapRightImgViewRecognizer = UITapGestureRecognizer(target: self, action: #selector(ProductListTableViewCell.onRightImgViewTapped))
            self.rightImgView.addGestureRecognizer(tapRightImgViewRecognizer)
        }
        if self._leftProductDic != nil
        {
            self.setLeftProductDic(self._leftProductDic)
        }
        if self._rightProductDic != nil
        {
            self.setRightProductDic(self._rightProductDic)
        }
    }
    
    func setLeftProductDic(leftProductDic : NSMutableDictionary?)
    {
        self._leftProductDic = leftProductDic
        if self.leftImgView != nil
        {
            if self._leftProductDic != nil && self._leftProductDic?.objectForKey("imgPath") != nil
            {
                dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), {
                    let image = UIImage(named: PATH_ProductImg + (self._leftProductDic!.objectForKey("imgPath") as! String))
                    dispatch_async(dispatch_get_main_queue(), {
                        self.leftImgView.image = image
                    })
                })
            }else{
                dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), {
                    dispatch_async(dispatch_get_main_queue(), {
                        self.leftImgView.image = nil
                    })
                })
            }
        }
    }
    
    func setRightProductDic(rightProductDic : NSMutableDictionary?)
    {
        self._rightProductDic = rightProductDic
        if self.rightImgView != nil
        {
            if self._rightProductDic != nil && self._rightProductDic?.objectForKey("imgPath") != nil
            {
                dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), {
                    let image = UIImage(named: PATH_ProductImg + (self._rightProductDic!.objectForKey("imgPath") as! String))
                    dispatch_async(dispatch_get_main_queue(), {
                        self.rightImgView.image = image
                    });
                });
            }else{
                dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), {
                    dispatch_async(dispatch_get_main_queue(), {
                        self.rightImgView.image = nil
                    });
                });
            }
        }
    }
    
    func onLeftImgViewTapped()
    {
        if self._leftProductDic != nil
        {
            productListTableViewCellDelegate?.onSelectProductImg(self._leftProductDic!)
        }
    }
    
    func onRightImgViewTapped()
    {
        if self._rightProductDic != nil
        {
            productListTableViewCellDelegate?.onSelectProductImg(self._rightProductDic!)
        }
    }

    override func setSelected(selected: Bool, animated: Bool)
    {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

//
//  ImgShowView.swift
//  QXJS
//
//  Created by Yachen Dai on 4/14/16.
//  Copyright © 2016 qxjs. All rights reserved.
//

import UIKit

class ImgShowView: UIView {

    @IBOutlet var bgView: UIView!
    var imgView: UIImageView!
    
    var image : UIImage?
    var imageSize : CGSize?
    
    override func drawRect(rect: CGRect) {
        // Drawing code
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(ImgShowView.onBgViewTapped(_:)))
        bgView?.userInteractionEnabled = true
        bgView?.addGestureRecognizer(tapRecognizer)
    }
    
    class func getInstance() -> ImgShowView
    {
        struct ImgShowViewStruct{
            static var predicate:dispatch_once_t = 0
            static var instance : ImgShowView? = nil
        }
        dispatch_once(&ImgShowViewStruct.predicate,{
            ImgShowViewStruct.instance = ((NSBundle.mainBundle().loadNibNamed("ImgShowView", owner: self, options: nil) as NSArray).lastObject as? ImgShowView)!
        })
        return ImgShowViewStruct.instance!
    }
    
    func showImg(image : UIImage, imageSize : CGSize)
    {
        if self.imgView == nil
        {
            self.imgView = UIImageView()
            self.addSubview(self.imgView)
        }
        self.imgView.image = image
        dispatch_async(dispatch_get_main_queue(), {
            if imageSize.width > imageSize.height
            {
                self.imgView.frame.size = CGSizeMake(
                    self.frame.size.width - 80 * 2,
                    imageSize.height / imageSize.width * (self.frame.size.width - 40 * 2)
                )
            }else{
                self.imgView.frame.size = CGSizeMake(
                    imageSize.width / imageSize.height * (self.frame.size.height - 40 * 2),
                    self.frame.size.height - 80 * 2
                )
            }
            self.imgView.frame.origin = CGPointMake(
                (self.frame.size.width - self.imgView.frame.size.width) / 2,
                (self.frame.size.height - self.imgView.frame.size.height) / 2
            )
        })
    }
    
    func onBgViewTapped(sender : UITapGestureRecognizer)
    {
        self.removeFromSuperview()
        self.imgView.image = nil
    }

}

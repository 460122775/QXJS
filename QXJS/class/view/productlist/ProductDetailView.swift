//
//  ProductListMainView.swift
//  QXJS
//
//  Created by Yachen Dai on 2/4/16.
//  Copyright © 2016 qxjs. All rights reserved.
//

import UIKit

protocol ProductDetailDelegate
{
    func goBackToMainView()
}

class ProductDetailView: UIView
{
    var productDetailDelegate : ProductDetailDelegate?
    
    @IBOutlet var mainImgView: UIImageView!
    @IBOutlet var productCdLabel: UILabel!
    @IBOutlet var productCommentLabel: UILabel!
    @IBOutlet var productCdLeftLabel: UILabel!
    
    
    @IBOutlet var rightChoiceView: UIView!
    @IBOutlet var productComposeScrollView: UIScrollView!
    @IBOutlet var userPhotoScrollView: UIScrollView!
    @IBOutlet var paramTextView: UITextView!
    
    var selectGroupDic : NSMutableDictionary?
    var currentProductArr : NSMutableArray?
    var currentUserPhotoArr : NSMutableArray?
    var currentProductDic : NSMutableDictionary?
    
    override func drawRect(rect: CGRect)
    {
        let tapMainImgViewRecognizer = UITapGestureRecognizer(target: self, action: #selector(ProductDetailView.onMainImgViewTapped))
        mainImgView.addGestureRecognizer(tapMainImgViewRecognizer)
    }
    
    func onMainImgViewTapped()
    {
        rightChoiceView.hidden = false
    }
    
    func initWithGroup(_selectGroupDic : NSMutableDictionary)
    {
        if selectGroupDic == _selectGroupDic
        {
            return
        }
        selectGroupDic = _selectGroupDic
        if currentProductArr != nil
        {
            currentProductArr?.removeAllObjects()
            currentProductArr = nil
        }
        if currentUserPhotoArr != nil
        {
            currentUserPhotoArr?.removeAllObjects()
            currentUserPhotoArr = nil
        }
        currentProductArr = ProductModel.getProductDataByGroup((selectGroupDic!.objectForKey("groupId") as! NSNumber).longLongValue)
        if currentProductArr != nil && currentProductArr?.count > 0
        {
            self.initViewByProductDic((currentProductArr?.firstObject)! as! NSMutableDictionary)
        }
    }
    
    func initViewByProductDic(_productDic : NSMutableDictionary)
    {
        if currentProductDic == _productDic
        {
            return
        }
        currentProductDic = _productDic
        // Set Img.
        self.mainImgView.image = UIImage(named: PATH_ProductImg + (_productDic.objectForKey("imgPath") as! String))
        
        // Init label detail.
        self.productCdLabel.text = "产品型号：" + (_productDic.objectForKey("productCd") as? String)!
        if _productDic.objectForKey("comment") != nil
        {
            self.productCommentLabel.text = "产品特点：" + (_productDic.objectForKey("comment") as? String)!
        }else{
            self.productCommentLabel.text = "产品特点："
        }
        self.productCdLeftLabel.text = "产品型号：" + (_productDic.objectForKey("productCd") as? String)!
        
        // Init product compose line.
        self.productComposeScrollView.subviews.map { $0.removeFromSuperview() }
        var productDicTemp : NSMutableDictionary?
        for i in 0 ..< self.currentProductArr!.count
        {
            productDicTemp = self.currentProductArr?.objectAtIndex(i) as? NSMutableDictionary
            let imgView = UIImageView(frame: CGRectMake(CGFloat(i) * (138 + 8), 0, 138, 100))
            imgView.userInteractionEnabled = true
            imgView.image = UIImage(named: PATH_ProductImg + (productDicTemp!.objectForKey("imgPath") as! String))
            imgView.tag = i
            let tapProductComposeImgRecognizer = UITapGestureRecognizer(target: self, action: #selector(ProductDetailView.onTapProductComposeImg(_:)))
            imgView.addGestureRecognizer(tapProductComposeImgRecognizer)
            self.productComposeScrollView.addSubview(imgView)
        }
        self.productComposeScrollView.contentSize = CGSizeMake(CGFloat((self.currentProductArr?.count)!) * (138 + 8), 100)
        
        // Init user upload photos.
        self.userPhotoScrollView.subviews.map { $0.removeFromSuperview() }
        self.currentUserPhotoArr = ProductModel.getUserPhotoDataByProduct((currentProductDic!.objectForKey("productId") as! NSNumber).longLongValue)
        if currentUserPhotoArr != nil && currentUserPhotoArr?.count > 0
        {
            for i in 0 ..< self.currentUserPhotoArr!.count
            {
                let imgView = UIImageView(frame: CGRectMake(CGFloat(i) * (138 + 8), 0, 138, 100))
                imgView.userInteractionEnabled = true
                imgView.image = UIImage(named: PATH_UserPhotoImg + (self.currentUserPhotoArr?.objectAtIndex(i) as? String)!)
                imgView.tag = i
                let tapUserPhotoImgRecognizer = UITapGestureRecognizer(target: self, action: #selector(ProductDetailView.onTapProductComposeImg(_:)))
                imgView.addGestureRecognizer(tapUserPhotoImgRecognizer)
                self.userPhotoScrollView.addSubview(imgView)
            }
            self.userPhotoScrollView.contentSize =
                CGSizeMake(CGFloat((self.currentUserPhotoArr?.count)!) * (138 + 8), 100)
        }
        // Init params.
        paramTextView.text = self.cutCommentChars(currentProductDic?.objectForKey("comment") as? String)
        if currentProductDic!.objectForKey("paramJson") != nil
        {
            let paramJson = currentProductDic!.objectForKey("paramJson") as! String
            let paramArr = paramJson.componentsSeparatedByString("@#")
            for _paramStr in paramArr
            {
                paramTextView.text = paramTextView.text + "\n" + self.cutCommentChars(_paramStr)
            }
        }
    }
    
    func cutCommentChars(contentStr : String?) -> String
    {
        if contentStr == nil || contentStr!.lengthOfBytesUsingEncoding(NSUTF8StringEncoding) == 0
        {
            return ""
            
        }
        print(contentStr!.lengthOfBytesUsingEncoding(NSUTF16StringEncoding))
        if contentStr!.lengthOfBytesUsingEncoding(NSUTF16StringEncoding) > 20 * 2
        {
            return contentStr!.substringToIndex(contentStr!.startIndex.advancedBy(20)) + "..."
        }else{
            return contentStr!
        }
    }
    
    func onTapProductComposeImg(sender: UITapGestureRecognizer)
    {
        self.initViewByProductDic((currentProductArr?.objectAtIndex(sender.view!.tag))! as! NSMutableDictionary)
    }
    
    func tapUserPhotoImgRecognizer(sender: UITapGestureRecognizer)
    {
        self.initViewByProductDic((currentProductArr?.objectAtIndex(sender.view!.tag))! as! NSMutableDictionary)
    }
    
    @IBAction func userPhotoUploadBtnClick(sender: UIButton)
    {
        
    }

    @IBAction func goBackBtnClick(sender: UIButton)
    {
        productDetailDelegate?.goBackToMainView()
    }
    
    @IBAction func closeBtnClick(sender: UIButton)
    {
        rightChoiceView.hidden = true
    }
    
    @IBAction func downLoadBtnClick(sender: UIButton)
    {
        // Save product screen shot into photo album.
        UIGraphicsBeginImageContextWithOptions((self.mainImgView.bounds.size), true, 0)
        self.mainImgView.drawViewHierarchyInRect(self.mainImgView.bounds, afterScreenUpdates: true)
        let snapshot = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        UIImageWriteToSavedPhotosAlbum(snapshot, self, #selector(ProductDetailView.image(_:didFinishSavingWithError:contextInfo:)), nil)
    }
    
    func image(image: UIImage, didFinishSavingWithError: NSError?, contextInfo: AnyObject)
    {
        if didFinishSavingWithError != nil
        {
            SwiftNotice.showText("产品图保存失败！")
            return
        }
        SwiftNotice.showText("产品图已成功保存到您的相册！")
    }
}

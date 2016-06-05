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
    @IBOutlet var mainImgView: UIView!
    @IBOutlet var rightChoiceView: UIView!
    @IBOutlet var livingRoomScrollView: UIScrollView!
    @IBOutlet var sofaScrollView: UIScrollView!
    @IBOutlet var curtainScrollView: UIScrollView!
    @IBOutlet var floorScrollView: UIScrollView!
    @IBOutlet var allImgView: UIView!
    @IBOutlet var livingroomImg: UIImageView!
    @IBOutlet var curtainImg: UIImageView!
    @IBOutlet var sofaImg: UIImageView!
    @IBOutlet var floorImg: UIImageView!
    var dataArr : NSMutableArray?
    var livingroomArr : NSMutableArray?
    var curtainArr : NSMutableArray?
    var sofaArr : NSMutableArray?
    var floorArr : NSMutableArray?
    let SMALLIMGHEIGHT : CGFloat = 90
    let SMALLIMGGAP : CGFloat = 16
    
    override func drawRect(rect: CGRect)
    {
        let tapMainImgViewRecognizer = UITapGestureRecognizer(target: self, action: #selector(CollocationDetailView.onMainImgViewTapped))
        mainImgView.addGestureRecognizer(tapMainImgViewRecognizer)
    }
    
    func onMainImgViewTapped()
    {
        rightChoiceView.hidden = false
    }
    
    func initByData(_dataArr : NSMutableArray)
    {
        self.dataArr = _dataArr
        var collocationImgView : UIImageView?
        var collocationDic : NSMutableDictionary?
        var tapRecognizer : UITapGestureRecognizer?
        var index : Int = 0
        // Livingroom.
        livingroomArr = _dataArr.objectAtIndex(0) as? NSMutableArray
        self.livingRoomScrollView.subviews.map { $0.removeFromSuperview() }
        for i in 0 ..< livingroomArr!.count
        {
            collocationDic = livingroomArr?.objectAtIndex(i) as? NSMutableDictionary
            collocationImgView = UIImageView(image: UIImage(named: PATH_CollocationImg + (collocationDic!.objectForKey("imgPath") as! String)))
            collocationImgView?.frame = CGRectMake(CGFloat(i) * (SMALLIMGGAP + 120), 0, 120, SMALLIMGHEIGHT)
            index += 1
            collocationImgView?.tag = index
            self.livingRoomScrollView.addSubview(collocationImgView!)
            tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(CollocationDetailView.onImgViewTapped(_:)))
            collocationImgView?.userInteractionEnabled = true
            collocationImgView?.addGestureRecognizer(tapRecognizer!)
        }
        self.livingRoomScrollView.contentSize = CGSizeMake(CGFloat(livingroomArr!.count) * (CGFloat(120) + SMALLIMGGAP) - SMALLIMGGAP, SMALLIMGHEIGHT)
        
        // Curtain.
        curtainArr = _dataArr.objectAtIndex(1) as? NSMutableArray
        self.curtainScrollView.subviews.map { $0.removeFromSuperview() }
        for i in 0 ..< curtainArr!.count
        {
            collocationDic = curtainArr?.objectAtIndex(i) as? NSMutableDictionary
            collocationImgView = UIImageView(image: UIImage(named: PATH_CollocationImg + (collocationDic!.objectForKey("imgPath") as! String)))
            collocationImgView?.frame = CGRectMake(CGFloat(i) * (SMALLIMGGAP + 15), 0, 15, SMALLIMGHEIGHT)
            index += 1
            collocationImgView?.tag = index
            self.curtainScrollView.addSubview(collocationImgView!)
            tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(CollocationDetailView.onImgViewTapped(_:)))
            collocationImgView?.userInteractionEnabled = true
            collocationImgView?.addGestureRecognizer(tapRecognizer!)
        }
        self.curtainScrollView.contentSize = CGSizeMake(CGFloat(curtainArr!.count) * (CGFloat(15) + SMALLIMGGAP) - SMALLIMGGAP, SMALLIMGHEIGHT)
        
        // Sofa.
        sofaArr = _dataArr.objectAtIndex(2) as? NSMutableArray
        self.sofaScrollView.subviews.map { $0.removeFromSuperview() }
        for i in 0 ..< sofaArr!.count
        {
            collocationDic = sofaArr?.objectAtIndex(i) as? NSMutableDictionary
            collocationImgView = UIImageView(image: UIImage(named: PATH_CollocationImg + (collocationDic!.objectForKey("imgPath") as! String)))
            collocationImgView?.frame = CGRectMake(CGFloat(i) * (SMALLIMGGAP + 262), 0, 262, SMALLIMGHEIGHT)
            index += 1
            collocationImgView?.tag = index
            self.sofaScrollView.addSubview(collocationImgView!)
            tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(CollocationDetailView.onImgViewTapped(_:)))
            collocationImgView?.userInteractionEnabled = true
            collocationImgView?.addGestureRecognizer(tapRecognizer!)
        }
        self.sofaScrollView.contentSize = CGSizeMake(CGFloat(sofaArr!.count) * (CGFloat(262) + SMALLIMGGAP) - SMALLIMGGAP, SMALLIMGHEIGHT)
        
        // Floor.
        floorArr = _dataArr.objectAtIndex(3) as? NSMutableArray
        self.floorScrollView.subviews.map { $0.removeFromSuperview() }
        for i in 0 ..< floorArr!.count
        {
            collocationDic = floorArr?.objectAtIndex(i) as? NSMutableDictionary
            collocationImgView = UIImageView(image: UIImage(named: PATH_CollocationImg + (collocationDic!.objectForKey("imgPath") as! String)))
            collocationImgView?.frame = CGRectMake(CGFloat(i) * (SMALLIMGGAP + 296), 0, 296, SMALLIMGHEIGHT)
            index += 1
            collocationImgView?.tag = index
            self.floorScrollView.addSubview(collocationImgView!)
            tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(CollocationDetailView.onImgViewTapped(_:)))
            collocationImgView?.userInteractionEnabled = true
            collocationImgView?.addGestureRecognizer(tapRecognizer!)
        }
        self.floorScrollView.contentSize = CGSizeMake(CGFloat(floorArr!.count) * (CGFloat(296) + SMALLIMGGAP) - SMALLIMGGAP, SMALLIMGHEIGHT)
        
    }
    
    func onImgViewTapped(sender : UITapGestureRecognizer)
    {
        print(sender.view?.tag)
        var index : Int = (sender.view?.tag)!
        index -= (self.livingroomArr?.count)!
        if index <= 0
        {
            let collocationDic = self.livingroomArr?.objectAtIndex(index + (self.livingroomArr?.count)! - 1)
            self.livingroomImg.image = UIImage(named: PATH_CollocationImg + (collocationDic!.objectForKey("imgPath") as! String))
            return
        }
        index -= (self.curtainArr?.count)!
        if index <= 0
        {
            let collocationDic = self.curtainArr?.objectAtIndex(index + (self.curtainArr?.count)!  - 1)
            self.curtainImg.image = UIImage(named: PATH_CollocationImg + (collocationDic!.objectForKey("imgPath") as! String))
            return
        }
        index -= (self.sofaArr?.count)!
        if index <= 0
        {
            let collocationDic = self.sofaArr?.objectAtIndex(index + (self.sofaArr?.count)! - 1)
            self.sofaImg.image = UIImage(named: PATH_CollocationImg + (collocationDic!.objectForKey("imgPath") as! String))
            return
        }
        index -= (self.floorArr?.count)!
        if index <= 0
        {
            let collocationDic = self.floorArr?.objectAtIndex(index + (self.floorArr?.count)! - 1)
            self.floorImg.image = UIImage(named: PATH_CollocationImg + (collocationDic!.objectForKey("imgPath") as! String))
            return
        }
    }

    @IBAction func goBackBtnClick(sender: UIButton)
    {
        collocationDetailDelegate?.goBackBtnClick()
    }
    
    @IBAction func downloadBtnClick(sender: AnyObject)
    {
        // Save product screen shot into photo album.
        UIGraphicsBeginImageContextWithOptions((self.allImgView.bounds.size), false, 0)
        self.allImgView.drawViewHierarchyInRect(self.allImgView.bounds, afterScreenUpdates: true)
        let snapshot = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        UIImageWriteToSavedPhotosAlbum(snapshot, self, #selector(CollocationDetailView.image(_:didFinishSavingWithError:contextInfo:)), nil)
    }
    
    func image(image: UIImage, didFinishSavingWithError: NSError?, contextInfo: AnyObject)
    {
        if didFinishSavingWithError != nil
        {
            SwiftNotice.showText("产品截图保存失败！")
            return
        }
        SwiftNotice.showText("产品截图已成功保存到您的相册！")
    }
    @IBAction func closeBtnClick(sender: UIButton)
    {
        rightChoiceView.hidden = true
    }
}

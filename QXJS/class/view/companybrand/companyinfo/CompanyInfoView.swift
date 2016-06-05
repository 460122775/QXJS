//
//  CompanyInfoView.swift
//  QXJS
//
//  Created by Yachen Dai on 2/25/16.
//  Copyright © 2016 qxjs. All rights reserved.
//

import UIKit

class CompanyInfoView: UIView ,UIScrollViewDelegate{

    @IBOutlet var imgContainer: UIScrollView!
    @IBOutlet var pageControl: UIPageControl!
    
    override func drawRect(rect: CGRect)
    {
        // Drawing code
        var pageImages: [UIImageView?] =
        [
            UIImageView(image : UIImage(named: "company_page1.png")!),
            UIImageView(image : UIImage(named: "company_page2.png")!)
        ]
        imgContainer.contentSize = CGSize(width: imgContainer.frame.size.width * CGFloat(pageImages.count),
            height: imgContainer.frame.size.height)
        //关闭滚动条显示
        imgContainer.showsHorizontalScrollIndicator = false
        imgContainer.showsVerticalScrollIndicator = false
        imgContainer.scrollsToTop = false
        //协议代理，在本类中处理滚动事件
        imgContainer.delegate = self
        //滚动时只能停留到某一页
        imgContainer.pagingEnabled = true
        //添加页面到滚动面板里
        let size = imgContainer.bounds.size
        for seq in 0 ..< pageImages.count
        {
            pageImages[seq]?.frame = CGRect(x: CGFloat(seq) * size.width, y: 0,
                width: size.width, height: size.height)
            imgContainer.addSubview(pageImages[seq]!)
        }
        //页控件属性
        pageControl.backgroundColor = UIColor.clearColor()
        pageControl.numberOfPages = pageImages.count
        pageControl.currentPage = 0
        //设置页控件点击事件
        pageControl.addTarget(self, action: #selector(CompanyInfoView.pageChanged(_:)), forControlEvents: UIControlEvents.ValueChanged)
    }
    
    //UIScrollViewDelegate方法，每次滚动结束后调用
    func scrollViewDidEndDecelerating(scrollView: UIScrollView)
    {
        pageControl.currentPage = Int(scrollView.contentOffset.x / scrollView.frame.size.width)
    }

    //点击页控件时事件处理
    func pageChanged(sender:UIPageControl)
    {
        //根据点击的页数，计算scrollView需要显示的偏移量
        var frame = imgContainer.frame
        frame.origin.x = frame.size.width * CGFloat(sender.currentPage)
        frame.origin.y = 0
        //展现当前页面内容
        imgContainer.scrollRectToVisible(frame, animated:true)
    }
}

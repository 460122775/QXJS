//
//  ProductListMainView.swift
//  QXJS
//
//  Created by Yachen Dai on 2/4/16.
//  Copyright © 2016 qxjs. All rights reserved.
//

import UIKit

protocol ProductListMainDelegate
{
    func showDetailView(selectProductDic : NSMutableDictionary)
}

class ProductListMainView: UIView, UITableViewDelegate, UITableViewDataSource, ProductListTableViewCellDelegate, UITextFieldDelegate{

    @IBOutlet var navBtn1: UIButton!
    @IBOutlet var navBtn2: UIButton!
    @IBOutlet var navBtn3: UIButton!
    @IBOutlet var navBtn4: UIButton!
    @IBOutlet var navBtn5: UIButton!
    @IBOutlet var navBtn6: UIButton!
    @IBOutlet var searchTextField: UITextField!

    @IBOutlet var selectedView: UIView!
    var productListMainDelegate : ProductListMainDelegate?
    @IBOutlet var productListTableView: UITableView!
    var productArr : NSMutableArray?
    var ProductListTableCellIndentifier : String = "ProductListTableCellIndentifier"
    var selectProductDic : NSMutableDictionary?
    var currentNavBtn : UIButton?
    
    override func drawRect(rect: CGRect)
    {
        // Set product table view.
        self.productListTableView!.dataSource = self
        self.productListTableView!.delegate = self
        self.productListTableView.layoutMargins = UIEdgeInsetsZero
        self.productListTableView.separatorInset = UIEdgeInsetsZero
        self.navBtnClick(self.navBtn1)
        self.searchTextField.delegate = self
    }
    
    @IBAction func navBtnClick(sender: UIButton)
    {
        currentNavBtn = sender
        self.searchTextField.text = ""
        selectedView.frame.origin.x = sender.frame.origin.x
        productArr = ProductModel.getProductDataBySeries(Int64(sender.tag), searchStr: self.searchTextField.text!)
        // Must reload data in main queue, or maybe crashed.
        dispatch_async(dispatch_get_main_queue(), {
            self.productListTableView.reloadData()
        });
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool
    {
        self.searchTextField.resignFirstResponder()
        productArr = ProductModel.getProductDataBySeries(Int64(currentNavBtn!.tag), searchStr: self.searchTextField.text!)
        // Must reload data in main queue, or maybe crashed.
        dispatch_async(dispatch_get_main_queue(), {
            self.productListTableView.reloadData()
        });
        return true
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        if productArr != nil
        {
            if productArr!.count % 2 == 0
            {
                return productArr!.count / 2
            }else{
                return productArr!.count / 2 + 1
            }
        }else{
            return 0
        }
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int
    {
        return 1
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat
    {
        return 305
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        var cell : ProductListTableViewCell? = tableView.dequeueReusableCellWithIdentifier(ProductListTableCellIndentifier) as? ProductListTableViewCell
        if cell == nil
        {
            cell = ProductListTableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: ProductListTableCellIndentifier) as ProductListTableViewCell!
            cell!.selectionStyle = UITableViewCellSelectionStyle.None
            cell!.backgroundColor = UIColor.clearColor()
            cell!.contentView.backgroundColor = UIColor.clearColor();
            cell!.productListTableViewCellDelegate = self
        }
        
        if productArr?.count > (indexPath.row as Int) * 2
        {
            let dataDic = productArr?.objectAtIndex((indexPath.row as Int) * 2) as? NSMutableDictionary
            cell!.setLeftProductDic(dataDic)
        }else{
            cell!.setLeftProductDic(nil)
        }
        if productArr?.count > (indexPath.row as Int) * 2 + 1
        {
            let dataDic = productArr?.objectAtIndex((indexPath.row as Int) * 2 + 1) as? NSMutableDictionary
            cell!.setRightProductDic(dataDic)
        }else{
            cell!.setRightProductDic(nil)
        }
        return cell!
    }

    func onSelectProductImg(productDic: NSMutableDictionary)
    {
        productListMainDelegate?.showDetailView(productDic)
    }
}

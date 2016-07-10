//
//  OrderAddView.swift
//  QXJS
//
//  Created by Yachen Dai on 6/27/16.
//  Copyright © 2016 qxjs. All rights reserved.
//

import UIKit

protocol OrderAddDelegate
{
    func updateOrderData()
}

class OrderAddView: UIView, UITextFieldDelegate, UITextViewDelegate {
    
    var orderAddDelegate : OrderAddDelegate?
    @IBOutlet var mainContainerVPositionConstraints: NSLayoutConstraint!
    
    @IBOutlet var addressTextField: UITextField!
    @IBOutlet var contentTextField: UITextField!
    @IBOutlet var commentTextField: UITextView!
    var customDataDic : NSDictionary?
    
    override func drawRect(rect: CGRect)
    {
        // Drawing code
        self.addressTextField.delegate = self
        self.contentTextField.delegate = self
        self.commentTextField.delegate = self
        self.commentTextField.layer.borderWidth = 1
        self.commentTextField.layer.borderColor = UIColor.lightGrayColor().CGColor
    }
    
    func initViewControl()
    {
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(LoginViewController.keyboardWillShow(_:)), name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(LoginViewController.keyboardWillHide(_:)), name: UIKeyboardWillHideNotification, object: nil)
    }
    
    @IBAction func onReturnBtnClick(sender: AnyObject)
    {
        self.addressTextField.text = ""
        self.contentTextField.text = ""
        self.commentTextField.text = ""
        
        self.removeFromSuperview()
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIKeyboardWillHideNotification, object: nil)
    }
    
    @IBAction func onSubmitBtnClick(sender: AnyObject)
    {
        // Judge nil.
        if self.addressTextField.text == nil || self.addressTextField.text?.lengthOfBytesUsingEncoding(NSUTF8StringEncoding) == 0
        {
            SwiftNotice.showText("订单地址不能为空")
            return
        }else if self.contentTextField.text == nil || self.contentTextField.text?.lengthOfBytesUsingEncoding(NSUTF8StringEncoding) == 0{
            SwiftNotice.showText("订单内容不能为空")
            return
        }else if self.orderAddDelegate != nil{
            let orderData : NSMutableDictionary = NSMutableDictionary()
            
            orderData.setObject(NSNumber(longLong: Int64(NSDate().timeIntervalSince1970)), forKey: "time")
            orderData.setObject((self.customDataDic?.objectForKey("customId"))!, forKey: "customId")
            orderData.setObject(self.contentTextField.text!, forKey: "content")
            orderData.setObject(self.commentTextField.text!, forKey: "comment")
            orderData.setObject(self.addressTextField.text!, forKey: "address")
            if CustomModel.insertOrderData(orderData) == true
            {
                orderAddDelegate?.updateOrderData()
                self.removeFromSuperview()
            }
        }
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool
    {
        if textField === self.addressTextField
        {
            self.addressTextField.resignFirstResponder()
            self.contentTextField.becomeFirstResponder()
        }else if textField === self.contentTextField{
            self.contentTextField.resignFirstResponder()
            self.commentTextField.becomeFirstResponder()
        }else if textField === self.commentTextField{
            self.commentTextField.resignFirstResponder()
        }
        return true
    }
    
    func keyboardWillShow(notification: NSNotification)
    {
        let info:NSDictionary = notification.userInfo!
        let keyboardSize = (info[UIKeyboardFrameBeginUserInfoKey] as! NSValue).CGRectValue()
        let _: CGFloat = info[UIKeyboardAnimationDurationUserInfoKey] as! NSNumber as CGFloat
        UIView.animateWithDuration(0.25, delay: 0.25, options: UIViewAnimationOptions.CurveEaseInOut, animations: {
            self.mainContainerVPositionConstraints.constant = -1 * keyboardSize.height / 2
            }, completion: nil)
        
    }
    
    func keyboardWillHide(notification: NSNotification)
    {
        UIView.animateWithDuration(0.25, delay: 0.25, options: UIViewAnimationOptions.CurveEaseInOut, animations: {
            self.mainContainerVPositionConstraints.constant = 0
            }, completion: nil)
    }

}

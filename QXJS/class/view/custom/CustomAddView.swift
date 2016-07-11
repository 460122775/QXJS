//
//  CustomAddView.swift
//  QXJS
//
//  Created by Yachen Dai on 6/5/16.
//  Copyright © 2016 qxjs. All rights reserved.
//

import UIKit

protocol CustomAddViewDelegate {

    func customAddSuccess(customData : NSMutableDictionary)
}

class CustomAddView: UIView, UITextFieldDelegate {
    
    @IBOutlet var mainContainerView: UIView!
    @IBOutlet var mainContainerVPositionConstraints: NSLayoutConstraint!

    @IBOutlet var nameTextField: UITextField!
    @IBOutlet var sexMaleBtn: UIButton!
    @IBOutlet var sexFamaleBtn: UIButton!
    @IBOutlet var ageTextFile: UITextField!
    @IBOutlet var phoneTextField: UITextField!
    @IBOutlet var addressTextfield: UITextField!
    @IBOutlet var titleLabel: UILabel!
    
    var delegate : CustomAddViewDelegate?
    var sexValue : Int32 = 1
    var isAddState : Bool = true
    var customData : NSMutableDictionary?
    
    override func drawRect(rect: CGRect)
    {
        // Drawing code
        self.nameTextField.delegate = self
        self.ageTextFile.delegate = self
        self.phoneTextField.delegate = self
        self.addressTextfield.delegate = self
        if self.isAddState == false
        {
            self.updateViewByData()
        }
    }
    
    func initViewControl(_isAddState : Bool)
    {
        self.isAddState = _isAddState
        if self.isAddState == false && self.nameTextField != nil
        {
           self.updateViewByData()
        }
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(LoginViewController.keyboardWillShow(_:)), name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(LoginViewController.keyboardWillHide(_:)), name: UIKeyboardWillHideNotification, object: nil)
    }
    
    func updateViewByData()
    {
        self.titleLabel.text = "编辑客户"
        self.nameTextField.text = self.customData!.objectForKey("customName") as? String
        self.ageTextFile.text = (String)((self.customData!.objectForKey("age") as! NSNumber).longLongValue)
        self.phoneTextField.text = self.customData!.objectForKey("phone") as? String
        self.addressTextfield.text = self.customData!.objectForKey("address") as? String
        if self.customData!.objectForKey("sex") as! String == "男"
        {
            self.sexMaleBtn.backgroundColor = UIColor(red: 248/255, green: 87/255, blue: 9/255, alpha: 1)
            self.sexMaleBtn.titleLabel?.textColor = UIColor.whiteColor()
            self.sexFamaleBtn.backgroundColor = UIColor.whiteColor()
            self.sexFamaleBtn.titleLabel?.textColor = UIColor.darkGrayColor()
            self.sexValue = 1
        }else{
            self.sexFamaleBtn.backgroundColor = UIColor(red: 248/255, green: 87/255, blue: 9/255, alpha: 1)
            self.sexFamaleBtn.titleLabel?.textColor = UIColor.whiteColor()
            self.sexMaleBtn.backgroundColor = UIColor.whiteColor()
            self.sexMaleBtn.titleLabel?.textColor = UIColor.darkGrayColor()
            self.sexValue = 0
        }
    }

    @IBAction func onSexBtnCick(sender: UIButton)
    {
        if sender.tag == 1
        {
            self.sexMaleBtn.backgroundColor = UIColor(red: 248/255, green: 87/255, blue: 9/255, alpha: 1)
            self.sexMaleBtn.titleLabel?.textColor = UIColor.whiteColor()
            self.sexFamaleBtn.backgroundColor = UIColor.whiteColor()
            self.sexFamaleBtn.titleLabel?.textColor = UIColor.darkGrayColor()
            self.sexValue = 1
        }else{
            self.sexFamaleBtn.backgroundColor = UIColor(red: 248/255, green: 87/255, blue: 9/255, alpha: 1)
            self.sexFamaleBtn.titleLabel?.textColor = UIColor.whiteColor()
            self.sexMaleBtn.backgroundColor = UIColor.whiteColor()
            self.sexMaleBtn.titleLabel?.textColor = UIColor.darkGrayColor()
            self.sexValue = 0
        }
    }

    @IBAction func onReturnBtnClick(sender: AnyObject)
    {
        self.nameTextField.text = ""
        self.addressTextfield.text = ""
        self.phoneTextField.text = ""
        self.ageTextFile.text = ""
        
        self.removeFromSuperview()
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIKeyboardWillHideNotification, object: nil)
    }
    
    @IBAction func onSubmitBtnClick(sender: AnyObject)
    {
        // Judge nil.
        if self.nameTextField.text == nil || self.nameTextField.text?.lengthOfBytesUsingEncoding(NSUTF8StringEncoding) == 0
        {
            SwiftNotice.showText("客户名称不能为空")
            return
        }else if self.addressTextfield.text == nil || self.addressTextfield.text?.lengthOfBytesUsingEncoding(NSUTF8StringEncoding) == 0{
            SwiftNotice.showText("客户地址不能为空")
            return
        }else if self.phoneTextField.text == nil || self.phoneTextField.text?.lengthOfBytesUsingEncoding(NSUTF8StringEncoding) == 0{
            SwiftNotice.showText("联系电话不能为空")
            return
        }else if self.delegate != nil && isAddState == true{
            let customData : NSMutableDictionary = NSMutableDictionary()
            customData.setObject(NSNumber(int: self.sexValue), forKey: "sex")
            if self.ageTextFile.text != nil && Int32(self.ageTextFile.text!) != nil
            {
                customData.setObject(NSNumber(int:Int32(self.ageTextFile.text!)!), forKey: "age")
            }else{
                customData.setObject(NSNumber(int:0), forKey: "age")
            }
            customData.setObject(self.nameTextField.text!, forKey: "customName")
            customData.setObject(self.phoneTextField.text!, forKey: "phone")
            customData.setObject(self.addressTextfield.text!, forKey: "address")
            if CustomModel.insertCustomData(customData) == true
            {
                delegate?.customAddSuccess(customData)
                self.removeFromSuperview()
            }
        }else if self.delegate != nil && isAddState == false{
            self.customData!.setObject(NSNumber(int: self.sexValue), forKey: "sex")
            if self.ageTextFile.text != nil && Int32(self.ageTextFile.text!) != nil
            {
                self.customData!.setObject(NSNumber(int:Int32(self.ageTextFile.text!)!), forKey: "age")
            }else{
                self.customData!.setObject(NSNumber(int:0), forKey: "age")
            }
            self.customData!.setObject(self.nameTextField.text!, forKey: "customName")
            self.customData!.setObject(self.phoneTextField.text!, forKey: "phone")
            self.customData!.setObject(self.addressTextfield.text!, forKey: "address")
            self.customData!.setObject(1, forKey: "state")
            if CustomModel.updateCustomData(customData) == true
            {
                if self.sexValue == 1
                {
                    self.customData!.setObject("男", forKey: "sex")
                }else{
                    self.customData!.setObject("女", forKey: "sex")
                }
                delegate?.customAddSuccess(self.customData!)
                self.removeFromSuperview()
            }
        }
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool
    {
        if textField === self.nameTextField
        {
            self.nameTextField.resignFirstResponder()
            self.ageTextFile.becomeFirstResponder()
        }else if textField === self.ageTextFile{
            self.ageTextFile.resignFirstResponder()
            self.phoneTextField.becomeFirstResponder()
        }else if textField === self.phoneTextField{
            self.phoneTextField.resignFirstResponder()
            self.addressTextfield.becomeFirstResponder()
        }else if textField === self.addressTextfield{
            self.addressTextfield.resignFirstResponder()
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

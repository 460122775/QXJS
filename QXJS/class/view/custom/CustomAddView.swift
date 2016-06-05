//
//  CustomAddView.swift
//  QXJS
//
//  Created by Yachen Dai on 6/5/16.
//  Copyright © 2016 qxjs. All rights reserved.
//

import UIKit

protocol CustomAddViewDelegate {

    func customAddSuccess()
    
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
    
    var delegate : CustomAddViewDelegate?
    
    override func drawRect(rect: CGRect)
    {
        // Drawing code
        self.nameTextField.delegate = self
        self.ageTextFile.delegate = self
        self.phoneTextField.delegate = self
        self.addressTextfield.delegate = self
    }
    
    func initViewControl()
    {
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(LoginViewController.keyboardWillShow(_:)), name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(LoginViewController.keyboardWillHide(_:)), name: UIKeyboardWillHideNotification, object: nil)
    }

    @IBAction func onSexBtnCick(sender: UIButton)
    {
        if sender.tag == 1
        {
            self.sexMaleBtn.backgroundColor = UIColor(red: 248/255, green: 87/255, blue: 9/255, alpha: 1)
            self.sexMaleBtn.titleLabel?.textColor = UIColor.whiteColor()
            self.sexFamaleBtn.backgroundColor = UIColor.whiteColor()
            self.sexFamaleBtn.titleLabel?.textColor = UIColor.darkGrayColor()
        }else{
            self.sexFamaleBtn.backgroundColor = UIColor(red: 248/255, green: 87/255, blue: 9/255, alpha: 1)
            self.sexFamaleBtn.titleLabel?.textColor = UIColor.whiteColor()
            self.sexMaleBtn.backgroundColor = UIColor.whiteColor()
            self.sexMaleBtn.titleLabel?.textColor = UIColor.darkGrayColor()
        }
    }

    @IBAction func onReturnBtnClick(sender: AnyObject)
    {
        self.removeFromSuperview()
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIKeyboardWillHideNotification, object: nil)
    }
    
    @IBAction func onSubmitBtnClick(sender: AnyObject)
    {
        if self.delegate != nil
        {
            delegate?.customAddSuccess()
        }
        self.onReturnBtnClick(self.sexFamaleBtn)
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

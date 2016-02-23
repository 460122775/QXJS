//
//  LoginViewController.swift
//  QXJS
//
//  Created by Yachen Dai on 2/3/16.
//  Copyright © 2016 qxjs. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController
{

    @IBOutlet var loginBtn: UIButton!
    @IBOutlet var nameInput: UITextField!
    @IBOutlet var pwdInput: UITextField!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        // Input view.
        
        // Login Btn.
        self.loginBtn.layer.masksToBounds = true
        self.loginBtn.layer.cornerRadius = 3
        
    }
    
    @IBAction func LoginBtnClick(sender: AnyObject)
    {
        MainMenuView.sharedInstance().companyBrandBtnClick(nil)
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

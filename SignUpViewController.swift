//
//  SignUpViewController.swift
//  findmyself
//
//  Created by 渡邉寛都 on 2020/06/24.
//  Copyright © 2020 WatanbeHiroto. All rights reserved.
//

import UIKit
import NCMB

class SignUpViewController: UIViewController,UITextFieldDelegate {
    
    @IBOutlet var emailTextField: UITextField!
    @IBOutlet var confirmTextField: UITextField!
    @IBOutlet var userIdTextField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        emailTextField.delegate = self
        confirmTextField.delegate = self
        
        
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func signUp() {
        let user = NCMBUser()
        
        
        user.mailAddress = emailTextField.text!
        
        
        if emailTextField.text == confirmTextField.text {
            user.mailAddress = emailTextField.text!
        } else {
            print("error")
        }
        user.signUpInBackground { (error) in
            if error != nil {
                print(error)
            } else {
                let storyboad = UIStoryboard(name: "Main", bundle: Bundle.main)
                let rootViewController = storyboad.instantiateViewController(identifier: "RootTabBarController")
                UIApplication.shared.keyWindow?.rootViewController = rootViewController
                
                let ud = UserDefaults.standard
                ud.set(true, forKey: "isLogin")
                ud.synchronize()
            }
        }
    }
    
}

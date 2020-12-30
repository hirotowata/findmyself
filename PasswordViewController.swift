//
//  PasswordViewController.swift
//  findmyself
//
//  Created by 渡邉寛都 on 2020/04/30.
//  Copyright © 2020 WatanbeHiroto. All rights reserved.
//

import UIKit
import NCMB

class PasswordViewController: UIViewController,UITextFieldDelegate {
    
    @IBOutlet var PasswordTextField: UITextField!
    
    @IBOutlet var passwordButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        PasswordTextField.delegate = self
        
        
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func savePassword() {
        
        let user = NCMBUser()
        let userId = UserDefaults.standard.object(forKey: "userId")
        let useradress = UserDefaults.standard.object(forKey: "emailadress")
        user.userName = userId as! String
        user.mailAddress = useradress as! String
        user.password = PasswordTextField.text
        
        
        if PasswordTextField.text!.count >= 6{
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
            
        } else {
            print("入ってません")
        }
        
    }
}

//
//  MailadressViewController.swift
//  findmyself
//
//  Created by 渡邉寛都 on 2020/04/30.
//  Copyright © 2020 WatanbeHiroto. All rights reserved.
//

import UIKit
import NCMB

class MailadressViewController: UIViewController,UITextFieldDelegate {
    
    @IBOutlet var emailTextField: UITextField!
    @IBOutlet var confirmTextField: UITextField!
    @IBOutlet var userIdTextField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        emailTextField.delegate = self
        
        
        
        
        
        // Do any additional setup after loading the view.
    }
    
    
    
   @IBAction func signUp() {
    let user = NCMBUser()
    user.mailAddress = emailTextField.text!
           // メール認証
           var error : NSError? = nil
           NCMBUser.requestAuthenticationMail(emailTextField.text!, error: &error)
    
           if (error != nil) {
             print(error ?? "")
           }
           print("メール完了")
    //present modal
           self.dismiss(animated: true, completion: nil)
    //show+navigatoncontroller
    self.navigationController?.popViewController(animated: true)
           print("dismiss完了")
    
    print(emailTextField.text!)
           }
    
   
    
}

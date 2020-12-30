//
//  SignInViewController.swift
//  findmyself
//
//  Created by 渡邉寛都 on 2020/04/28.
//  Copyright © 2020 WatanbeHiroto. All rights reserved.
//

import UIKit
import NCMB
import PKHUD

class SignInViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet var passwordTextField: UITextField!
    @IBOutlet var emailTextField: UITextField!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        emailTextField.delegate = self
        passwordTextField.delegate = self
    

        // Do any additional setup after loading the view.
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    @IBAction func signIn() {
    
    NCMBUser.logInWithUsername(inBackground: emailTextField.text!, password: passwordTextField.text!, block: {(user, error) in
      if (error != nil) {
        HUD.flash(.labeledError(title: "ログインエラー", subtitle: "入力内容を\n確認してください"), delay: 2)
        print(error)
      } else {
        // ログイン成功
          let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
          let rootViewController = storyboard.instantiateViewController(withIdentifier: "RootTabBarController")
          UIApplication.shared.keyWindow?.rootViewController = rootViewController
          // 画面の切り替え
          // ログイン状態の保持
          let ud = UserDefaults.standard
          ud.set(true, forKey: "isLogin")
          ud.synchronize()
      }
    })}
    @IBAction func forgetPassword() {
        
    }


}

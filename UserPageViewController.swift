//
//  UserPageViewController.swift
//  findmyself
//
//  Created by 渡邉寛都 on 2020/04/28.
//  Copyright © 2020 WatanbeHiroto. All rights reserved.
//

import UIKit
import NCMB

class UserPageViewController: UIViewController {
    
    @IBOutlet var userImageView: UIImageView!
    
    @IBOutlet var userDisplayNameLabel: UILabel!
    
    @IBOutlet var userAgelabel: UILabel!
    
    @IBOutlet var userSchoolLabel: UILabel!
    
    @IBOutlet var userNameTextField: UILabel!
    
    
        // Do any additional setup after loading the view.
    
    
    override func viewDidLoad() {
    super.viewDidLoad()
        
        if let user = NCMBUser.current() {
            if let name = user.object(forKey: "displayName") as? String{
                userDisplayNameLabel.text = name
                
            } else {
                print("入ってない")
            }
            if let age = user.object(forKey: "age") as? String{
                userAgelabel.text = age
            } else {
                print("入ってない")
            }
            if let school = user.object(forKey: "school") as? String {
                userSchoolLabel.text = school
            } else {
                print("入ってない")
            }
            if let name = user.object(forKey: "userName") as? String {
                userNameTextField.text = name
            } else {
                print("入ってない")
            }
            
            
            self.navigationItem.title = user.userName
            
            let file = NCMBFile.file(withName: user.objectId, data: nil) as! NCMBFile
            file.getDataInBackground { (data, error) in
                if error != nil {
                    let alert = UIAlertController(title: "画像取得エラー", message: error!.localizedDescription, preferredStyle: .alert)
                    let okAction = UIAlertAction(title: "OK", style: .default, handler: { (action) in
                        
                    })
                    alert.addAction(okAction)
                    self.present(alert, animated: true, completion: nil)
                } else {
                    if data != nil {
                        let image = UIImage(data: data!)
                        self.userImageView.image = image
                    }
                }
            }
        } else {
            // NCMBUser.current()がnilだったとき
            let storyboard = UIStoryboard(name: "SignIn", bundle: Bundle.main)
            let rootViewController = storyboard.instantiateViewController(withIdentifier: "RootNavigationController")
            UIApplication.shared.keyWindow?.rootViewController = rootViewController
            
            // ログイン状態の保持
            let ud = UserDefaults.standard
            ud.set(false, forKey: "isLogin")
            ud.synchronize()
        }
        
    }
    
    
    
    @IBAction func showMenu() {
        let alertController = UIAlertController(title: "メニュー", message: "メニューを選択してください", preferredStyle: .actionSheet)
        let signOutAction = UIAlertAction(title: "ログアウト", style: .default) { (action) in
            NCMBUser.logOutInBackground { (error) in
                if error != nil {
                    print(error)
                } else {
                    let storyboad = UIStoryboard(name: "SignIn", bundle: Bundle.main)
                    let rootViewController = storyboad.instantiateViewController(identifier: "RootNavigationController")
                    UIApplication.shared.keyWindow?.rootViewController = rootViewController
                    
                    let ud = UserDefaults.standard
                    ud.set(false, forKey: "isLogin")
                    ud.synchronize()
                }
            }
        }
        
        
//        @IBAction func signIn() {
//
//        NCMBUser.logInWithUsername(inBackground: emailTextField.text!, password: passwordTextField.text!, block: {(user, error) in
//          if (error != nil) {
//            HUD.flash(.labeledError(title: "ログインエラー", subtitle: "入力内容を\n確認してください"), delay: 2)
//            print(error)
//          } else {
//            // ログイン成功
//              let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
//              let rootViewController = storyboard.instantiateViewController(withIdentifier: "RootTabBarController")
//              UIApplication.shared.keyWindow?.rootViewController = rootViewController
//              // 画面の切り替え
//              // ログイン状態の保持
//              let ud = UserDefaults.standard
//              ud.set(true, forKey: "isLogin")
//              ud.synchronize()
//          }
//        })}
        
        
        
        
        
        
        
        let deleteAction = UIAlertAction(title: "退会", style: .default) { (action) in
            let user = NCMBUser.current()
            user?.deleteInBackground({ (error) in
                if error != nil {
                    print(error)
                } else {
                    let storyboad = UIStoryboard(name: "String", bundle: Bundle.main)
                    let rootViewController = storyboad.instantiateViewController(withIdentifier: "RootNavigationController")
                    UIApplication.shared.keyWindow?.rootViewController = rootViewController
                    
                    let ud = UserDefaults.standard
                    ud.set(false, forKey: "isLogin")
                    ud.synchronize()
                }
            })
        }
        
        let cancelAction = UIAlertAction(title: "キャンセル", style: .cancel) { (cancel) in
            alertController.dismiss(animated: true, completion: nil)
        }
        alertController.addAction(signOutAction)
        alertController.addAction(deleteAction)
        alertController.addAction(cancelAction)
        
        self.present(alertController,animated: true, completion: nil)
    }
}





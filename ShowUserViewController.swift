//
//  ShowUserViewController.swift
//  findmyself
//
//  Created by 渡邉寛都 on 2020/05/10.
//  Copyright © 2020 WatanbeHiroto. All rights reserved.
//

import UIKit
import  NCMB





class ShowUserViewController: UIViewController {
    
    
    
    var selectedUser: NCMBUser?
    var list = [String]()
    var ListArray = [[String]]()
    override func viewDidLoad() {
        super.viewDidLoad()
      
        
        guard let currentUser = NCMBUser.current() else {
          //ログインに戻る
          //ログアウト登録成功
          let storyboard = UIStoryboard(name: "SignIn", bundle: Bundle.main)
          let RootViewController = storyboard.instantiateViewController(withIdentifier: "RootNavigationController")
          UIApplication.shared.keyWindow?.rootViewController = RootViewController
          //ログアウト状態の保持
          let ud = UserDefaults.standard
          ud.set(false, forKey: "isLogin")
          ud.synchronize()
          return
        }
        
        
        
        
        // Jload()
        // Do any additional setup after loading the view.
    }
   
    //中学生
    
    @IBAction  func Junioirloadmessage(){
        let query = NCMBQuery(className: "Jmessag")
        query?.includeKey("user")
        query?.whereKey("user", equalTo: selectedUser!)
        
        query?.findObjectsInBackground({ (result, error) in
            if error != nil{
                
            }else{
                self.ListArray = []
              print("what")

            let objects = result as! [NCMBObject]
                for object in objects{
                       self.list = []//初期化
                     
                    let user = object.object(forKey: "user") as! NCMBUser
                    let memo = object.object(forKey: "memo") as! String
                    let num = object.object(forKey: "number") as! String
                    self.list.append(memo)//0番目
                    self.list.append(num)//1番目
                   
                   self.ListArray.append(self.list)
                    
                  
                }
                
                self.performSegue(withIdentifier: "toDetail", sender: nil)
                print(self.ListArray)
                print("============")
            }
        })
    }
    
    
    @IBAction  func Highloadmessage(){
        let query = NCMBQuery(className: "Hmessage")
        query?.includeKey("user")
        query?.whereKey("user", equalTo: selectedUser!)
       
        query?.findObjectsInBackground({ (result, error) in
            if error != nil{
                
            }else{
                self.ListArray = []
              print("what")

            let objects = result as! [NCMBObject]
                for object in objects{
                       self.list = []//初期化
                     
                    let user = object.object(forKey: "user") as! NCMBUser
                    let memo = object.object(forKey: "memo") as! String
                    let num = object.object(forKey: "number") as! String
                    self.list.append(memo)//0番目
                    self.list.append(num)//1番目
                   
                   self.ListArray.append(self.list)
                    
                  
                }
                
                self.performSegue(withIdentifier: "toDetail", sender: nil)
                print(self.ListArray)
                print("============")
            }
        })
    }
    
    
    
    @IBAction  func Universloadmessage(){
        let query = NCMBQuery(className: "Umessage")
        query?.includeKey("user")
        query?.whereKey("user", equalTo: selectedUser!)
      
        query?.findObjectsInBackground({ (result, error) in
            if error != nil{
                
            }else{
                self.ListArray = []
              print("what")

            let objects = result as! [NCMBObject]
                for object in objects{
                       self.list = []//初期化
                     
                    let user = object.object(forKey: "user") as! NCMBUser
                    let memo = object.object(forKey: "memo") as! String
                    let num = object.object(forKey: "number") as! String
                    self.list.append(memo)//0番目
                    self.list.append(num)//1番目
                   
                   self.ListArray.append(self.list)
                    
                  
                }
                
                self.performSegue(withIdentifier: "toDetail", sender: nil)
                print(self.ListArray)
                print("============")
            }
        })
    }
    
    
    @IBAction  func Lastloadmessage(){
        let query = NCMBQuery(className: "Lmessag")
        query?.includeKey("user")
        query?.whereKey("user", equalTo: selectedUser!)
      
        query?.findObjectsInBackground({ (result, error) in
            if error != nil{
                
            }else{
                self.ListArray = []
              print("what")

            let objects = result as! [NCMBObject]
                for object in objects{
                       self.list = []//初期化
                     
                    let user = object.object(forKey: "user") as! NCMBUser
                    let memo = object.object(forKey: "memo") as! String
                    let num = object.object(forKey: "number") as! String
                    self.list.append(memo)//0番目
                    self.list.append(num)//1番目
                    
                    
                    print(self.list)
                    
                   self.ListArray.append(self.list)
                    
                  
                }
                
                self.performSegue(withIdentifier: "toDetail", sender: nil)
                print(self.ListArray)
                print("============")
            }
        })
    }
    
    
    
//   func loadData(){
//        let query = NCMBQuery(className: "message")
//        query?.includeKey("user")
//    query?.findObjectsInBackground({ (result, error) in
//
//        print(result)
//        print("$$")
//    })
//    }
//
    
    
    @IBAction  func loadmessage(){
        
        let query = NCMBQuery(className: "message")
        query?.includeKey("user")
        print(selectedUser!)
        print("000000")
        
        
        
     query?.whereKey("user", equalTo: selectedUser!)
      
        query?.findObjectsInBackground({ (result, error) in
            if error != nil{
                print(error)
                print("what")
            }else{
                self.ListArray = []
              
              print("what")

            let objects = result as! [NCMBObject]
                for object in objects{
                       self.list = []//初期化
                     
                    let user = object.object(forKey: "user") as! NCMBUser
                    let memo = object.object(forKey: "memo") as! String
                    let num = object.object(forKey: "number") as! String
                    self.list.append(memo)//0番目
                    self.list.append(num)//1番目
                   
                    print(self.list)
                    
                   self.ListArray.append(self.list)
                    
                  
                }
                
                self.performSegue(withIdentifier: "toDetail", sender: nil)
                print(self.ListArray[0])
                print("============")
            }
        })
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let nextVC = segue.destination as! _stViewController
        
       
//        nextVC.num = list[1]
//        nextVC.text = list[0]
        nextVC.ListArray = self.ListArray
        print(self.ListArray)
        print("###")
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}

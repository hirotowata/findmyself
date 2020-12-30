//
//  ViewController.swift
//  findmyself
//
//  Created by 渡邉寛都 on 2020/04/27.
//  Copyright © 2020 WatanbeHiroto. All rights reserved.
//

import UIKit
import NCMB
import SwiftDate
import Kingfisher
import PKHUD

class ViewController: UIViewController,UITableViewDataSource, UISearchBarDelegate, UITableViewDelegate, QusetionTableViewCellDelegate{
    
    
    
    
    func didTapFollowButton(tableViewCell: UITableViewCell, button: UIButton) {
        let displayName = users[tableViewCell.tag].object(forKey: "displayName") as? String
    }
    
    var blockUserIdArray = [String]()
    var lists = [String]()//から配列 投稿した内容 BAC [memo,num] [memo1,num1]
    var listArray = [[String]]()             //[[memo,num],[memo1,num1]]       //（）これなんだっけ？？？？？？？？？？？？？？？？？？？？？？？？？
    var users = [NCMBUser]() //会員情報の順番 ログインした順番 ABC 会員をtableview表示のため
    //var members = [NCMBUser]()//投稿の主 BAC
    
    //var followingUserIds = [String]()
    
    var searchBar: UISearchBar!
    
    @IBOutlet var searchUserTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       // setSearchBar()
        
        searchUserTableView.rowHeight = 120
        
        
        searchUserTableView.dataSource = self
        searchUserTableView.delegate = self
        
        loadmessage()
        
        getBlockUser()
        
        
        // カスタムセルの登録
        let nib = UINib(nibName: "QusetionTableViewCell", bundle: Bundle.main)
        searchUserTableView.register(nib, forCellReuseIdentifier: "Cell")
        
        // 余計な線を消す
        //        searchUserTableView.tableFooterView = UIView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        
        loadUsers()
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let showUserViewController = segue.destination as! ShowUserViewController
        let selectedIndex = searchUserTableView.indexPathForSelectedRow!
        showUserViewController.selectedUser = users[selectedIndex.row]//
        //  showUserViewController.list = listArray[selectedIndex.row]
        print(showUserViewController.list)
        print(users[selectedIndex.row].userName)
        //print(users[selectedIndex.row])
        print("====")
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        if users[indexPath.row].objectId != NCMBUser.current()?.objectId {
            let reportButton: UITableViewRowAction = UITableViewRowAction(style: .normal, title: "報告") { (action, index) -> Void in
                let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
                let reportAction = UIAlertAction(title: "報告する", style: .destructive) { (action) in
                    // PKHUD用にする
                    HUD.show(.labeledSuccess(title: "この投稿を報告しました。ご協力ありがとうございました。", subtitle: nil))
                    //新たにクラス作る
                    let object = NCMBObject(className: "Report")
                    
                    
                    object?.setObject(self.users[indexPath.row].objectId, forKey: "reportId")
                    object?.setObject(NCMBUser.current(), forKey: "user")
                    object?.saveInBackground({ (error) in
                        if error != nil {
                            HUD.show(.labeledError(title: "エラーです", subtitle: nil))
                        } else {
                            HUD.flash(.progress, delay: 2)
                            tableView.deselectRow(at: indexPath, animated: true)
                        }
                    })
                }
                let cancelAction = UIAlertAction(title: "キャンセル", style: .cancel) { (action) in
                    alertController.dismiss(animated: true, completion: nil)
                }
                alertController.addAction(reportAction)
                alertController.addAction(cancelAction)
                self.present(alertController, animated: true, completion: nil)
                tableView.isEditing = false
            }
            // 緑
            reportButton.backgroundColor = UIColor(displayP3Red: 93/255, green: 167/255, blue: 151/255, alpha: 1.0)
            let blockButton: UITableViewRowAction = UITableViewRowAction(style: .normal, title: "ブロック") { (action, index) -> Void in
                let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
                let blockAction = UIAlertAction(title: "ブロックする", style: .destructive) { (action) in
                    
                    HUD.show(.labeledSuccess(title: "このユーザーをブロックしました。", subtitle: nil))
                    
                    //新たにクラス作る
                    let object = NCMBObject(className: "Block")
                    object?.setObject(self.users[indexPath.row].objectId, forKey: "blockUserID")
                    object?.setObject(NCMBUser.current(), forKey: "user")
                    object?.saveInBackground({ (error) in
                        if error != nil{
                            
                            HUD.show(.labeledError(title: "エラーです", subtitle: nil))
                            
                        } else {
                            HUD.flash(.progress, delay: 2)
                            tableView.deselectRow(at: indexPath, animated: true)
                            
                            //ここで③を読み込んでいる
                            self.getBlockUser()
                        }
                    })
                }
                let cancelAction = UIAlertAction(title: "キャンセル", style: .cancel) { (action) in
                    alertController.dismiss(animated: true, completion: nil)
                }
                
                alertController.addAction(blockAction)
                alertController.addAction(cancelAction)
                self.present(alertController, animated: true, completion: nil)
                tableView.isEditing = false
            }
            // 濃いグレー
            blockButton.backgroundColor = UIColor(displayP3Red: 69/255, green: 69/255, blue: 69/255, alpha: 1.0)
            return[blockButton,reportButton]
        } else {
            return nil
            
        }
        
    }
    //                let deleteButton: UITableViewRowAction = UITableViewRowAction(style: .normal, title: "削除") { (action, index) -> Void in
    //                    // ⚠️
    //                    let query = NCMBQuery(className: "Post")
    //                    query?.getObjectInBackground(withId: self.users[indexPath.row].objectId, block: { (post, error) in
    //                        if error != nil {
    //
    //                            HUD.flash(.labeledError(title: "エラーです", subtitle: nil), delay: 2)
    //
    //                        } else {
    //                            DispatchQueue.main.async {
    //                                let alertController = UIAlertController(title: "投稿を削除しますか？", message: nil, preferredStyle: .alert)
    //                                let cancelAction = UIAlertAction(title: "キャンセル", style: .cancel) { (action) in
    //                                    alertController.dismiss(animated: true, completion: nil)
    //                                }
    //                                let deleteAction = UIAlertAction(title: "削除", style: .default) { (action) in
    //                                    post?.deleteInBackground({(error)in
    //                                        if error != nil{
    //
    //                                            HUD.flash(.labeledError(title: "エラーです", subtitle: nil), delay: 2)
    //
    //                                        } else {
    //                                            tableView.deselectRow(at: indexPath, animated: true)
    //                                           // self.loadTimeline()
    //    //                                        self.setTimeTableView.reloadTimeline()
    //                                        }
    //                                    })
    //                                }
    //                                alertController.addAction(cancelAction)
    //                                alertController.addAction(deleteAction)
    //                                self.present(alertController, animated: true,completion: nil)
    //                                tableView.isEditing = false
    //                            }
    //
    //                        }
    //                    })
    //                }
    //                //色変更
    //                deleteButton.backgroundColor =  UIColor(displayP3Red: 93/255, green: 167/255, blue: 151/255, alpha: 1.0)
    //                return [deleteButton]
    //            }
    
    
    func getBlockUser() {
        //classの中で、Blockをここで指定してる
        let query = NCMBQuery(className: "Block")
        
        //includeKeyでBlockの子クラスである会員情報を持ってきている
        query?.includeKey("user")
        //whereKeyでuserに絞り込んでる(whereは絞り込み、includeは指定)
        query?.whereKey("user", equalTo: NCMBUser.current())
        query?.findObjectsInBackground({ (result, error) in
            if error != nil {
                //エラーの処理
                print("getBlockUser読み込み失敗")
                print(error)
            } else {
                //ブロックされたユーザーのIDが含まれる + removeall()は初期化していて、データの重複を防いでいる
                self.blockUserIdArray.removeAll()
                for blockObject in result as! [NCMBObject] {
                    //この部分で①の配列にブロックユーザー情報が格納
                    self.blockUserIdArray.append(blockObject.object(forKey:"blockUserID") as! String)
                    
                    print(self.blockUserIdArray)
                    
                }
                // self.loadTimeline()
            }
        })
        self.loadUsers()
    }
    
    
    
    
    //        func setSearchBar() {
    //            // NavigationBarにSearchBarをセット
    //            if let navigationBarFrame = self.navigationController?.navigationBar.bounds {
    //                let searchBar: UISearchBar = UISearchBar(frame: navigationBarFrame)
    //                searchBar.delegate = self
    //                searchBar.placeholder = "ユーザーを検索"
    //                searchBar.autocapitalizationType = UITextAutocapitalizationType.none
    //                navigationItem.titleView = searchBar
    //                navigationItem.titleView?.frame = searchBar.frame
    //                self.searchBar = searchBar
    //            }
    //        }
    
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        searchBar.setShowsCancelButton(true, animated: true)
        return true
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        loadUsers()
        searchBar.showsCancelButton = false
        searchBar.resignFirstResponder()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        loadUsers()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(users.count)
        print("&&&")
        return users.count
        
    }
    
//    func setSearchBar() {
//        // NavigationBarにSearchBarをセット
//        if let navigationBarFrame = self.navigationController?.navigationBar.bounds {
//            let searchBar = UISearchBar(frame: navigationBarFrame)
//            searchBar.delegate = self
//            searchBar.placeholder = "検索"
//            searchBar.autocapitalizationType = UITextAutocapitalizationType.none
//            navigationItem.titleView = searchBar
//            navigationItem.titleView?.frame = searchBar.frame
//            self.searchBar = searchBar
//        }
//    }
    //    func searchBarShouldEndEditing(_ searchBar: UISearchBar) -> Bool {
    //      searchBar.setShowsCancelButton(true, animated: true)
    //      return true
    //    }
    //    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
    //      searchPost(searchText: nil)
    //      searchBar.showsCancelButton = false
    //      searchBar.resignFirstResponder()
    //    }
    //    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
    //      searchBar.endEditing(true)
    //      searchPost(searchText: searchBar.text)
    //    }
    //    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) ->
    //    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    //      //TableView押した時に画面遷移
    //      self.performSegue(withIdentifier: “toT”, sender: nil)
    //      //遷移したら押されたのを解除する
    //      tableView.deselectRow(at: indexPath, animated: true)
    //    }
    //    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    //      let cell = tableView.dequeueReusableCell(withIdentifier: “Cell”) as! SearchTableViewCell
    //      cell.delegate = self
    //      cell.tag = indexPath.row
    //      cell.selectionStyle = .none
    //      cell.directionLabel!.text = posts[indexPath.row].object(forKey: “direction”) as! String
    //       let user = posts[indexPath.row].object(forKey: “user”) as! NCMBUser
    //      let userImageUrl = “https://mbaas.api.nifcloud.com/2013-09-01/applications/QYEIUecMOiGT2A6H/publicFiles/” + user.objectId
    //      cell.userimageView2.kf.setImage(with: URL(string: userImageUrl), placeholder: UIImage(named: “placeholder.jpg”))
    //      return cell
    //    }
    func searchPost(searchText: String?) {
        let query = NCMBUser.query()
        //query?.includeKey(“user”)
        // 検索ワードがある場合
        
        if let text = searchText {
            query?.whereKey("userName", equalTo: text)
        }
        query?.findObjectsInBackground({ (result, error) in
            if error != nil {
                // SVProgressHUD.showError(withStatus: error!.localizedDescription)
            } else {
                // 取得した新着50件のユーザーを格納
                // self.users = result as! [NCMBObject]
                self.searchUserTableView.reloadData()
            }
        })
    }
    
    
    
    func loadmessage(){
        let query = NCMBQuery(className: "message")
        query?.includeKey("user")
        query?.findObjectsInBackground({ (result, error) in
            if error != nil{
                
            }else{
                self.listArray = [[]]
                self.lists = []//初期化
                let objects = result as! [NCMBObject]
                for object in objects{
                    
                    let user = object.object(forKey: "user") as! NCMBUser
                    let memo = object.object(forKey: "memo") as! String
                    let num = object.object(forKey: "number") as! String
                    self.lists.append(memo)
                    self.lists.append(num)
                    // self.members.append(user)
                    self.listArray.append(self.lists)
                    print(self.listArray)
                    print("!!!!!!!")
                }
            }
        })
    }
    
    
    
    
    
    func loadUsers() {
        let query = NCMBUser.query()//アクセスのみ,引っ張らないと意味ない
        //let query = NCMBQuery(className: "user")
        print(NCMBUser.query())
        
        print("yyyyyyyyyy")
        // 自分を除外
         query?.whereKey("objectId", notEqualTo: NCMBUser.current().objectId)
        
        print(NCMBUser.current().objectId)
        
        print("yyyyyyyyyy")

        
        //            // 退会済みアカウントを除外
    query?.whereKey("active", notEqualTo: false)
        // print(query)
        // print("kueri")
        
        //
        //            // 検索ワードがある場合
        //          if let text = searchText {
        //              print(text)
        //              query?.whereKey("userName", equalTo: text)
        //hippatteru
        
        query?.findObjectsInBackground({ (result, error) in
             print(result)
            if error != nil{
                  print(error)
                // print("here")
            }else{
                
                self.users  = []
                for i in result as![NCMBUser] {
                    if self.blockUserIdArray.firstIndex(of: i.objectId) == nil{
                        self.users.append(i)
                    }
                }
                
                
                
                self.searchUserTableView.reloadData()//cellforとnumberofを読み込む
            }
        })
        
        
    }
    
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as! QusetionTableViewCell
        
        let userImageUrl = "https://mbaas.api.nifcloud.com/2013-09-01/applications/2aHeqnwIjOBXNl7F/publicFiles/" + users[indexPath.row].objectId
        cell.userImageView.kf.setImage(with: URL(string: userImageUrl), placeholder: UIImage(named: "placeholder.jpg"))
        // print(userImageUrl)
        // print("qqqqqqqqqqq")
        cell.userImageView.layer.cornerRadius = cell.userImageView.bounds.width / 2.0
        cell.userImageView.layer.masksToBounds = true
        cell.userNameLabel.text = users[indexPath.row].object(forKey: "displayName") as? String
        
        //cell.userNameLabel.text = users[indexPath.row].object(forKey: "displayName") as? String
        return cell
    }
    
    
    //
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "toUser", sender: nil)
        // 選択状態の解除
        tableView.deselectRow(at: indexPath, animated: true)
    }
    //
    
    
    //
}

//
//  EditUserinfoViewController.swift
//  findmyself
//
//  Created by 渡邉寛都 on 2020/04/28.
//  Copyright © 2020 WatanbeHiroto. All rights reserved.
//

import UIKit
import NCMB
import NYXImagesKit

class EditUserinfoViewController: UIViewController, UITextFieldDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    
    @IBOutlet var userImageveiw: UIImageView!
    @IBOutlet var userNameTextField: UITextField!
    @IBOutlet var userIdTextField: UITextField!
    @IBOutlet var schioolnameTextField: UITextField!
    @IBOutlet var ageTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        userNameTextField.delegate = self
        userIdTextField.delegate = self
        schioolnameTextField.delegate = self
        ageTextField.delegate = self
    
        
        if let user = NCMBUser.current() {
            userNameTextField.text = user.object(forKey: "displayName") as? String
            userIdTextField.text = user.userName
            schioolnameTextField.text = user.object(forKey: "scoolName") as? String
            ageTextField.text = user.object(forKey: "Age")as? String
           
            
            
            let file = NCMBFile.file(withName: NCMBUser.current().objectId , data: nil) as!NCMBFile
            file.getDataInBackground { (data, error) in
                if error != nil{
                    print(error)
                }else{
                    if data != nil {
                        let image = UIImage(data: data!)
                        self.userImageveiw.image = image
                    }
                }
            }
        }else{
            let storyboad = UIStoryboard(name: "SignIn", bundle: Bundle.main)
            let rootViewController = storyboad.instantiateViewController(identifier: "RootNavigationController")
            UIApplication.shared.keyWindow?.rootViewController = rootViewController
            
            let ud = UserDefaults.standard
            ud.set(false, forKey: "isLogin")
            ud.synchronize()
            
        }
        
        
        
        // Do any additional setup after loading the view.
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        let selectedImage = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
        
        let resizedImage = selectedImage.scale(byFactor: 0.4)
        
        userImageveiw.image = selectedImage
        
        picker.dismiss(animated: true, completion: nil)
        
        
        let data = resizedImage!.pngData()
        let file = NCMBFile.file(withName:NCMBUser.current()?.objectId, data: data) as! NCMBFile
        file.saveInBackground({(error)in
            if error != nil{
                print(error)            } else {
                self.userImageveiw.image = selectedImage
            }
        }) { (progress) in
            print (progress)
            
        }
        
    }
    
    
    
    @IBAction func selectImage() {
        let actionController = UIAlertController(title: "画像の選択", message: "選択してください", preferredStyle: .actionSheet)
        let cameraAction = UIAlertAction(title: "カメラ", style: .default) { (action) in
            
            if UIImagePickerController.isSourceTypeAvailable(.camera) == true{
                let picker = UIImagePickerController()
                picker.sourceType = .camera
                picker.delegate = self
                self.present(picker,animated: true, completion: nil)
            } else {
                print("この機種では使えません")
            }
        }
        
        let albumAction = UIAlertAction(title: "フォトライブラリ", style: .default) { (action) in
            
            if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) == true {
                
                let picker = UIImagePickerController()
                picker.sourceType = .photoLibrary
                picker.delegate = self
                self.present(picker,animated: true, completion: nil)
            } else {
                print("この機種では使用できません")
            }
        }
        let cancelAction = UIAlertAction(title: "キャンセル", style: .cancel) { (action) in actionController.dismiss(animated: true, completion: nil)
            
        }
        actionController.addAction(cameraAction)
        actionController.addAction(albumAction)
        actionController.addAction(cancelAction)
        self.present(actionController,animated: true, completion: nil)
    }
    
    @IBAction func closeEditViewController() {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func saveUserInfo() {
        
        
        let user = NCMBUser.current()
        user?.setObject(userNameTextField.text, forKey: "displayName")
        user?.setObject(userIdTextField.text, forKey:"userName")
        user?.setObject(ageTextField.text, forKey: "age")
        user?.setObject(schioolnameTextField.text, forKey: "school")
        user?.saveInBackground({ (error) in
            if error != nil{
                print(error)
            }else{
                self.dismiss(animated: true, completion: nil)
            }
        })
        
    }
    
    
    
}

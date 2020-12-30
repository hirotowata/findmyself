//
//  QuestinViewController.swift
//  findmyself
//
//  Created by 渡邉寛都 on 2020/05/04.
//  Copyright © 2020 WatanbeHiroto. All rights reserved.
//

import UIKit
import NCMB

class QuestinViewController: UIViewController {
    
    var point: Int = 0
    var quizNumber: Int = 0
    var quizArray: [Quiz] = []
    
    @IBOutlet var quizImageView: UIImageView!
    @IBOutlet var quizTextField: UITextField!
    @IBOutlet var quizTextView: UITextView!
    @IBOutlet var quizNumberLabel: UILabel!
    
    @IBOutlet var option2Button: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpQuiz()
        showQuiz()
        
        
        // Do any additional setup after loading the view.
    }
    
    
    func setUpQuiz() {
        
        let quiz1 = Quiz( text: "一番モチベが高くて頑張った体験は？",  option2: "保存する" )
        let quiz2 = Quiz(text: "なんで頑張った？きっかけは？",  option2: "保存する")
        let quiz3 = Quiz( text: "その状況に対してどう対処した？",  option2: "保存する")
        let quiz4 = Quiz( text: "今の自分と比べてどう？", option2: "保存する")
        //
        
        quizArray.append(quiz1)
        print(quizArray.count)
        print("hhhhhhhh")
        quizArray.append(quiz2)
        print(quizArray.count)
        print("jjjjjjj")
        quizArray.append(quiz3)
        quizArray.append(quiz4)
        
        
        
       
        
    }
    func showQuiz() {
        
        print(quizNumber)
        print(1)
        
        quizNumberLabel.text = String(quizNumber + 1) + "問目"
        
        quizTextField.text = quizArray[quizNumber].text
        //option1Button.setTitle(quizArray[quizNumber].option1, for: .normal)
        option2Button.setTitle(quizArray[quizNumber].option2, for: .normal)
        
               
    }
    
    func resetQuiz() {
        point = 0
        quizNumber = 0
        //self.quizArray = Quiz.shuffle(quizArray: self.quizArray)
        self.showQuiz()
    }
    
    func updateQuiz() {
        quizNumber = quizNumber + 1
        
        print(quizNumber)
        print(quizArray.count)
        print("ffffffff")
        
        
        if quizNumber == quizArray.count {
            let alertText = "質問コーナーに戻って次へ行こう！"
            let alertController = UIAlertController(title: "結果", message: alertText, preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default, handler: { (action) in
                
            })
            alertController.addAction(okAction)
            self.present(alertController, animated: true, completion: nil)
            self.resetQuiz()
            
        } else {
            showQuiz()
        }
        
    }
    
    
    @IBAction func save(){
        
        let object = NCMBObject(className:"message")
        object?.setObject(quizTextView.text, forKey: "memo")
        object?.setObject(quizNumberLabel.text, forKey: "number")
        object?.setObject(NCMBUser.current(), forKey: "user")
        object?.saveInBackground({ (error) in
            if error != nil {
                print(error)
            } else {
                self.updateQuiz()
            }
        })
        //技術課題 保存 NCMB
        
        
    }
    
}


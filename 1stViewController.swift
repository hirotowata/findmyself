//
//  1stViewController.swift
//  findmyself
//
//  Created by 渡邉寛都 on 2020/05/20.
//  Copyright © 2020 WatanbeHiroto. All rights reserved.
//

import UIKit

class _stViewController: UIViewController {


        var ListArray = [[String]]()
        var point: Int = 0
        var quizNumber: Int = 0
        var quizArray: [Quiz] = []
        
        @IBOutlet var quizImageView: UIImageView!
        @IBOutlet var quizTextField: UITextField!
        @IBOutlet var quizTextView: UITextView!
        @IBOutlet var quizNumberLabel: UILabel!
       
        @IBOutlet var option2Button: UIButton!
        
        var text: String?
        var num: String?
        

        override func viewDidLoad() {
            super.viewDidLoad()
    //        quizNumberLabel.text = num!
     //       quizTextView.text = text!
    //
            
            setUpQuiz()
            showQuiz()
            // Do any additional setup after loading the view.
        }
        
        func setUpQuiz() {
            
            let quiz1 = Quiz( text: "一番モチベが高くて頑張った体験は？", option2: "次を見る" )
            let quiz2 = Quiz(text: "なんで頑張った？きっかけは？",  option2: "次を見る")
            let quiz3 = Quiz( text: "その状況に対してどう対処した？",  option2: "次を見る")
            let quiz4 = Quiz( text: "今の自分と比べてどう？", option2: "戻る")
            //
            
            quizArray.append(quiz1)
            quizArray.append(quiz2)
            quizArray.append(quiz3)
            quizArray.append(quiz4)
            
            
            print("set")
            
        }
        
        
        func showQuiz() {
            
            print(ListArray)
          
            
            
            if  ListArray != [] {
             quizTextView.text = ListArray[quizNumber][0]
                print(ListArray[quizNumber][0])
                 quizTextField.text = quizArray[quizNumber].text
                print(quizArray.capacity)
                print("っっっpーーー")
            } else{
                print("入ってない")
                print("qqqqqqqqqqqq")
            }
            
            quizNumberLabel.text = String(quizNumber + 1) + "問目"
            option2Button.setTitle(quizArray[quizNumber].option2, for: .normal)
            quizTextField.text = quizArray[quizNumber].text
            print(quizTextView.text)
            
            print("wwwwwwwwww")
            
            
            
            
            //option1Button.setTitle(quizArray[quizNumber].option1, for: .normal)
            //option2Button.setTitle(quizArray[quizNumber].option2, for: .normal)
            
        }
        
        func resetQuiz() {
            point = 0
            quizNumber = 0
            //self.quizArray = Quiz.shuffle(quizArray: self.quizArray)
            self.showQuiz()
        }
        
        
        func updateQuiz() {
            quizNumber = quizNumber + 1
            
            print(ListArray.count)
                print(quizNumber)
            
                print("あああああああああああああああ")
            
            if quizNumber == ListArray.count {
                let alertText = "他の答えも見てみよう！"
                let alertController = UIAlertController(title: "結果", message: alertText, preferredStyle: .alert)
                let okAction = UIAlertAction(title: "OK", style: .default, handler: { (action) in
                    
                })
                alertController.addAction(okAction)
                self.present(alertController, animated: true, completion: nil)
                self.resetQuiz()
                
            } else if 0 == ListArray.count {
                let alertText = "他の答えも見てみよう！"
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
    
    
            self.updateQuiz()
        
    }
        
    
    
            //技術課題 保存 NCMB
            
            
}

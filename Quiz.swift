//
//  Quiz.swift
//  findmyself
//
//  Created by 渡邉寛都 on 2020/05/04.
//  Copyright © 2020 WatanbeHiroto. All rights reserved.
//

import UIKit

class Quiz: NSObject {
    
    var text: String
   
    var option2: String
    
    
    init(text:String,  option2: String){
        self.text = text
      
        self.option2 = option2
    }
}

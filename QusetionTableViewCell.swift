//
//  QusetionTableViewCell.swift
//  findmyself
//
//  Created by 渡邉寛都 on 2020/05/08.
//  Copyright © 2020 WatanbeHiroto. All rights reserved.
//

import UIKit

protocol QusetionTableViewCellDelegate {
    func didTapFollowButton(tableViewCell: UITableViewCell, button: UIButton)
}

class QusetionTableViewCell: UITableViewCell {
    
    var delegate: QusetionTableViewCellDelegate?
    
    @IBOutlet var userImageView: UIImageView!
    @IBOutlet var userNameLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
//    @IBAction func openMenu(button: UIButton) {
//        self.delegate?.didTapMenuButton(tableViewCell: self, button: button)
//    }
    
}

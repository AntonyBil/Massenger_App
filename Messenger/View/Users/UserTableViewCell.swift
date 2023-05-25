//
//  UserTableViewCell.swift
//  Messenger
//
//  Created by apple on 25.05.2023.
//

import UIKit

class UserTableViewCell: UITableViewCell {
    
    static let identifire = "UserTableViewCell"
    
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var parentView: UIView!
    @IBOutlet weak var userName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func configCell(_ name: String) {
        userName.text = name
    }
    
    func settingString() {
        parentView.layer.cornerRadius = 10
        userImage.layer.cornerRadius = userImage.frame.width/2
    }
    
}

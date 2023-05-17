//
//  SlideCollectionViewCell.swift
//  Messenger
//
//  Created by apple on 15.05.2023.
//

import UIKit

class SlideCollectionViewCell: UICollectionViewCell {
    
    static let identifire = "SlideCollectionViewCell"
    
    @IBOutlet weak var slideImage: UIImageView!
    @IBOutlet weak var descriptionLbl: UILabel!
    @IBOutlet weak var regBtn: UIButton!
    @IBOutlet weak var authBtn: UIButton!
    
    var delegate: LoginViewControllerDelegate!
    
    func configure(slide: SlideModel) {
        slideImage.image = slide.image
        descriptionLbl.text = slide.text
        if slide.id == 3 {
            regBtn.isHidden = false
            authBtn.isHidden = false
        }
    }
    //use delegete to switch between screens
    @IBAction func regBtnClick(_ sender: Any) {
        delegate.openRegVC()
    }
    
    @IBAction func authBtnClick(_ sender: Any) {
        delegate.openAuthVC()
    }
}

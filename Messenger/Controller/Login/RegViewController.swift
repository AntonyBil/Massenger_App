//
//  RegViewController.swift
//  Messenger
//
//  Created by apple on 16.05.2023.
//

import UIKit

class RegViewController: UIViewController {
    
    var delegate: LoginViewControllerDelegate!

    override func viewDidLoad() {
        super.viewDidLoad()

  
    }
    
    @IBAction func closeVC(_ sender: UIButton) {
        delegate.closeVC()
    }
}

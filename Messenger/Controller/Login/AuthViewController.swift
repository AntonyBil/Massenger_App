//
//  AuthViewController.swift
//  Messenger
//
//  Created by apple on 16.05.2023.
//

import UIKit

class AuthViewController: UIViewController {
    
    @IBOutlet weak var emailView: UIView!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordView: UIView!
    @IBOutlet weak var passwordField: UITextField!
    
    
    var delegate: LoginViewControllerDelegate!
    var service = Service.shared

    override func viewDidLoad() {
        super.viewDidLoad()

        
    }

    @IBAction func closeVC(_ sender: UIButton) {
        delegate.closeVC()
    }
    
    @IBAction func forgotPassword(_ sender: UIButton) {
    }
    
    @IBAction func clickAuthBtn(_ sender: UIButton) {
    }
    
    @IBAction func dontHaveAccountCleeck(_ sender: UIButton) {
        delegate.openRegVC()
    }
}

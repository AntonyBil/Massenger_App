//
//  RegViewController.swift
//  Messenger
//
//  Created by apple on 16.05.2023.
//

import UIKit

class RegViewController: UIViewController {
    
    var delegate: LoginViewControllerDelegate!
    var checkField = CheckField.shared
    var service = Service.shared
    
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var emeilField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var rePasswordField: UITextField!
    
    @IBOutlet weak var emailView: UIView!
    @IBOutlet weak var passwordView: UIView!
    @IBOutlet weak var rePasswordView: UIView!
    
    //Use TapGesture to dismis keyboard when we tap on view
    var tapGest: UITapGestureRecognizer?
    
   

    override func viewDidLoad() {
        super.viewDidLoad()
        tapGest = UITapGestureRecognizer(target: self, action: #selector(endEditing))
        mainView.addGestureRecognizer(tapGest!)
  
    }
    
    @IBAction func closeVC(_ sender: UIButton) {
        delegate.closeVC()
    }
    
    @objc func endEditing() {
        self.view.endEditing(true)
    }
    
    @IBAction func regBtnClick(_ sender: UIButton) {
        if checkField.validField(emailView, emeilField),
           checkField.validField(passwordView, passwordField) {
            if passwordField.text == rePasswordField.text {
                service.createNewUser(LoginField(email: emeilField.text!, password: passwordField.text!)) {[weak self] code in
                    switch code.code {
                    case 0:
                        print("Registration error try again")
                    case 1:
                        print("Registration was successful")
                        self?.service.confirmEmail()
                    default:
                        print("")
                    }
                }
            } else {
                print("Not correct field")
            }
            
        }
    
    }
}

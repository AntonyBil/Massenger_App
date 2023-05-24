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
    @IBOutlet weak var mainView: UIView!
    
    var delegate: LoginViewControllerDelegate!
    var service = Service.shared
    var checkField = CheckField.shared
    var userDefault = UserDefaults.standard
    
    var tapGesture: UITapGestureRecognizer?

    override func viewDidLoad() {
        super.viewDidLoad()
        tapGesture = UITapGestureRecognizer(target: self, action: #selector(endEditing))
        mainView.addGestureRecognizer(tapGesture!)
    }
    
    @objc func endEditing() {
        self.view.endEditing(true)
    }
    

    @IBAction func closeVC(_ sender: UIButton) {
        delegate.closeVC()
    }
    
    @IBAction func forgotPassword(_ sender: UIButton) {
    }
    
    @IBAction func clickAuthBtn(_ sender: UIButton) {
        if checkField.validField(emailView, emailField),
           checkField.validField(passwordView, passwordField) {
            let authData = LoginField(email: emailField.text!, password: passwordField.text!)
            
            service.authInApp(authData) {[weak self] responce in
                switch responce {
                case .success:
                    print("next")
                    self?.userDefault.set(true, forKey: "isLogin")
                    self?.delegate.startApp()
                    self?.delegate.closeVC()
                case .noVerify:
                    let alert = self?.alertController("Error", "You didn't verefy your email. we send you a massege for verefication!")
                    let verefyBtn = UIAlertAction(title: "Ok", style: .cancel)
                    alert?.addAction(verefyBtn)
                    self!.present(alert!, animated: true)
                case .error:
                    let alert = self?.alertController("Error", "Email or password dont corect")
                    let verefyBtn = UIAlertAction(title: "Ok", style: .cancel)
                    alert?.addAction(verefyBtn)
                    self?.present(alert!, animated: true)
                    
                }
            }
        }
        else {
            let alert = self.alertController("Error", "Chek your enter text")
            let verefyBtn = UIAlertAction(title: "Ok", style: .cancel)
            alert.addAction(verefyBtn)
            present(alert, animated: true)
            
        }
    }
    
    func alertController(_ heder: String?, _ massege: String?) -> UIAlertController {
        let alert = UIAlertController(title: heder, message: massege, preferredStyle: .alert)
        return alert
    }
    
    @IBAction func dontHaveAccountCleeck(_ sender: UIButton) {
        delegate.openRegVC()
    }
}

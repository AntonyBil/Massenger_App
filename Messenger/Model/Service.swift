//
//  Service.swift
//  Messenger
//
//  Created by apple on 18.05.2023.
//

import UIKit
import Firebase
import FirebaseAuth
import 

class Service {
    static let shared = Service()
    init() { }
    
    
    
    func createNewUser(_ data: LoginField, completion: @escaping (ResponceCode)->()) {
        Auth.auth().createUser(withEmail: data.email, password: data.password) {[weak self] result, error in
            if error == nil {
                if result != nil {
               //     let userId = result?.user.uid
                    completion(ResponceCode(code: 1))
                }
            } else {
                completion(ResponceCode(code: 0))
            }
        }
    }
    
    func confirmEmail() {
        Auth.auth().currentUser?.sendEmailVerification(completion: { error in
            if error != nil {
                print(error!.localizedDescription)
            }
        })
    }
}

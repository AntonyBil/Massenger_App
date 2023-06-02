//
//  Service.swift
//  Messenger
//
//  Created by apple on 18.05.2023.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseFirestore

class Service {
    static let shared = Service()
    init() { }
    
    
    
    func createNewUser(_ data: LoginField, completion: @escaping (ResponceCode)->()) {
        Auth.auth().createUser(withEmail: data.email, password: data.password) { result, error in
            if error == nil {
                if result != nil {
                    let userId = result?.user.uid
                    let email = data.email
                    let data: [String: Any] = ["email": email]
                    Firestore.firestore().collection("users").document(userId!).setData(data)
                    
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
    
    func authInApp(_ data: LoginField, completion: @escaping(AuthResponse)->()) {
        Auth.auth().signIn(withEmail: data.email, password: data.password) { result, error in
            if error != nil {
                completion(.error)
            } else {
                if let result = result {
                    if result.user.isEmailVerified{
                        completion(.success)
                    } else {
                        self.confirmEmail()
                        completion(.noVerify)
                    }
                }
            }
        }
    }
    
    func getUserStatus() {
        
    }
    
    func getAllUsers(completion: @escaping([CurentUser]) -> ()) {
        
        guard let email = Auth.auth().currentUser?.email else { return }
        
        var curentUsers = [CurentUser]()
        Firestore.firestore().collection("users").whereField("email", isEqualTo: email).getDocuments { snap, error in
            if error == nil {
                if let docs = snap?.documents {
                    for doc in docs {
                        let data = doc.data()
                        let userId = doc.documentID
                        let email = data["email"] as! String
                        curentUsers.append(CurentUser(id: userId, email: email))
                    }
                }
                completion(curentUsers)
            }
        }
    }
    
    
    
    
    //MARK: - Messanger
    
    func sendMessage(otherId: String?, conversationId: String?, text: String, completion: @escaping(Bool)->()) {
        
        let ref = Firestore.firestore()
        if let uid = Auth.auth().currentUser?.uid {
            if conversationId == nil {
                // create new conversation
                let conversId = UUID().uuidString
                
                let selfData: [String: Any] = [
                    "date": Date(),
                    "otherId": otherId ?? ""
                    ]
                
                let otherData: [String: Any] = [
                    "date": Date(),
                    "otherId": uid
                ]
                //у нас є переписка з людиною Х
               ref.collection("users")
                    .document(uid)
                    .collection("conversations")
                    .document(conversId)
                    .setData(selfData)
                
                    //у людини Х є переписка з нами
                ref.collection("users")
                    .document(otherId ?? "")
                    .collection("conversations")
                    .document(conversId)
                    .setData(otherData)
                
                let msg: [String: Any] = [
                    "date": Date(),
                    "sender": uid,
                    "text": text
                ]
                
                let convoInfo: [String: Any] = [
                    "data": Date(),
                    "selfSender": uid,
                    "otherSender": otherId ?? ""
                ]
                
                ref.collection("conversations")
                    .document(conversationId ?? "")
                    .setData(convoInfo) { err in
                        if let err = err {
                            print(err.localizedDescription)
                            return
                        }
                        
                        ref.collection("conversations")
                            .document(conversationId ?? "")
                            .collection("messages")
                            .addDocument(data: msg) { err in
                                if err == nil {
                                    completion(true)
                                } else {
                                    completion(false)
                                }
                            }
                    }
                
            } else {
                let msg: [String: Any] = [
                    "date": Date(),
                    "sender": uid,
                    "text": text
                ]
                
                ref.collection("conversations").document(conversationId!).collection("messages").addDocument(data: msg) { err in
                    if err == nil {
                        completion(true)
                    } else {
                        completion(false)
                    }
                }
            }
        }
        
    }
    
    func updateConversations() {
        
    }
    
    func getConversationID(otherId: String, completion: @escaping(String)-> ()) {
        if let uid = Auth.auth().currentUser?.uid {
            let ref = Firestore.firestore()
            
            ref.collection("users")
                .document(uid)
                .collection("conversations")
                .whereField("otherId", isEqualTo: otherId)
                .getDocuments { snap, err in
                    if err != err {
                        return
                    }
                    if let snap = snap, !snap.documents.isEmpty {
                        let doc = snap.documents.first
                        if let convoId = doc?.documentID{
                            completion(convoId)
                        }
                    }
                }
        }
    }
    
    func getAllMessages() {
        
    }
    
    func getOneMesage() {
        
    }
}

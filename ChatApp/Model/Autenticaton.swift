//
//  Autenticaton.swift
//  ChatApp
//
//  Created by maggie mendez on 03/10/20.
//

import Foundation
import Firebase

class Authentication {
    static public let instance = Authentication()
    var handle: AuthStateDidChangeListenerHandle?
    
    private init(){
        
    }
    func detectCurrentUser(onSuccessfull success: @escaping () -> Void){
        handle = Auth.auth().addStateDidChangeListener { (auth, user) in
            if user != nil{
                success()
            }
        }
    }
    
    func removeHandle(){
        Auth.auth().removeStateDidChangeListener(handle!)
    }
    
    func register(_ user: User, password: String, onSuccessfull success: @escaping () -> Void, onFailure fail: @escaping (String) -> Void){
        Auth.auth().createUser(withEmail: user.email , password: password) { authResult, error in
            
            guard let _ = authResult, error == nil else {
                fail(error!.localizedDescription )
                return
            }
            success()
            let messageDefault = MessageChat(emailEmisor: user.email, emailReceptor: "ChatApp", message: "Welcome to the ChatApp", date: Date())
            
            let friend = Friend( user.email ,  messageDefault.id)
            var user = user
            user.friends.append(friend)
            
            do {
                try Database.instance.addUser(user)
                try Database.instance.addMessage(message: messageDefault)
            }catch let error{
                print("Error writing city to Firestore: \(error)")
            }
        }
    }
    
    func singIn(_ email: String, _ password: String, onSuccessfull success: @escaping () -> Void, onFailure fail: @escaping (String) -> Void){
        Auth.auth().signIn(withEmail: email , password: password) { authResult, error in
            guard let _ = authResult, error == nil else {
                fail(error!.localizedDescription)
                return
            }
            success()
            print(authResult ?? "nananany ")
        }
    }
    
    func signOut() throws {
        try Auth.auth().signOut()
    }
    
    
}

//
//  Database.swift
//  ChatApp
//
//  Created by maggie mendez on 04/10/20.
//

import Foundation
import Firebase
import FirebaseDatabase
import FirebaseFirestore
import FirebaseFirestoreSwift

class DatabaseManager {
    static var instance = DatabaseManager()
    var db = Firestore.firestore()
    
    enum DatabaseCollections: String {
        case users
        case messages
        case friends
    }
    
    enum DatabaseError: Error {
        case noUserLogged
        case errorDocument
    }
    
    func addUser(_ user: User) throws {
        try self.db.collection(DatabaseCollections.users.rawValue).document("\(String(describing: user.email))").setData(from: user)
        try addFriend(user.friends[0], onSuccess: {_ in })
    }
    
    func addMessage(message: MessageChat ) throws {
        try self.db.collection(DatabaseCollections.messages.rawValue).document("\(String(describing: message.id))").setData(from: message)
    }
    
    func addFriend(_ friend: Friend, onSuccess success: @escaping (Bool)->Void) throws {
        guard let user = Auth.auth().currentUser, let email = user.email else{
            throw DatabaseError.noUserLogged
        }
        try self.db.collection(DatabaseCollections.users.rawValue).document(email).collection(DatabaseCollections.friends.rawValue).document(friend.userId ?? "").setData(from: friend)
        success(true)
    }
    
    func getFriends(onSuccess success: @escaping ([Friend]) -> Void ) throws  {
        guard let user = Auth.auth().currentUser, let email = user.email else{
            throw DatabaseError.noUserLogged
        }
        db.collection(DatabaseCollections.users.rawValue ).document("\(email)").collection(DatabaseCollections.friends.rawValue).getDocuments { (querySnapshot, error) in
            guard let query = querySnapshot, error == nil else{
                return
            }
            var friends = [Friend]()
            for document in query.documents{
                let friend = Friend(dictionary: document.data())
                friends.append(friend)
            }
            success(friends)
        }
    }
    
    func getUsers(onSuccesfull success: @escaping ([User])->Void ){
        let userRef = db.collection(DatabaseCollections.users.rawValue)
        userRef.getDocuments { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                var users = [User]()
                for document in querySnapshot!.documents {
                    print("\(document.documentID) => \(document.data())")
                    let user = User(dictionary: document.data())
                    users.append(user)
                }
                success(users)
            }
        }
        
    }
    
    func getMessage(with id: String, onSuccess success: @escaping (MessageChat) -> Void){
        db.collection(DatabaseCollections.messages.rawValue).document(id).addSnapshotListener { (documentSnapshot, error) in
            guard let document = documentSnapshot, error == nil  else {
                print("Error \(error!.localizedDescription)")
                return
            }
            let source = document.metadata.hasPendingWrites ? "Local" : "Server"
            print("\(source) data: \n \(document.data() ?? [:])")
            
            if let data = document.data(){
                let message = MessageChat(dictionary: data)
                success(message)
            }
        }
    }
    
    func getMessages(){
        
    }
    
    
}

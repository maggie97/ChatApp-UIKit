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

class Database {
    static var instance = Database()
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
        try self.db.collection(DatabaseCollections.users.rawValue).document("\(user.email)").setData(from: user)
    }
    
    func addMessage(message: MessageChat ) throws {
        try self.db.collection(DatabaseCollections.messages.rawValue).document("\(message.id)").setData(from: message)
    }
    
    func getFriends(onSuccess success: @escaping (Friends) -> Void ) throws  {
        guard let user = Auth.auth().currentUser, let email = user.email else{
            throw DatabaseError.noUserLogged
        }
        db.collection(DatabaseCollections.users.rawValue).document("\(email)").getDocument { (documentSnapshot, error) in
            guard let document = documentSnapshot, error == nil else{
                return
            }
            
            if let friendsData = document.get("friends") as? [[String: Any]]{
                let friends = Friends(dict: friendsData)
                success(friends)
            }
            else {
                print("error")
            }
        }
    }
}



//
//  File.swift
//  ChatApp
//
//  Created by maggie mendez on 02/10/20.
//

import Foundation
struct User: Codable{
    var id: String? = UUID().uuidString
    let firstName: String?
    let lastName: String?
    let email: String?
    let contactNumber: String?
    var friends: [Friend] = []
    let avatarImage: String?
    
    enum CodingKeys: String, CodingKey{
        case  firstName, lastName, email, contactNumber,avatarImage, friends
    }
    
    init(firstName: String, lastName: String, email: String, contactNumber: String, avatarImg: String) {
        self.firstName = firstName
        self.lastName = lastName
        self.email = email
        self.contactNumber = contactNumber
        self.avatarImage = avatarImg
    }
    
    init(dictionary: [String: Any]) {
        self.id = dictionary[CodingKeys.email.rawValue] as? String
        self.firstName = dictionary[CodingKeys.firstName.rawValue] as? String
        self.lastName = dictionary[CodingKeys.lastName.rawValue] as? String
        self.email = dictionary[CodingKeys.email.rawValue] as? String
        self.contactNumber = dictionary[CodingKeys.contactNumber.rawValue] as? String
        self.avatarImage = dictionary[CodingKeys.avatarImage.rawValue] as? String
    }
}

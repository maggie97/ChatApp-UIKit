
//
//  File.swift
//  ChatApp
//
//  Created by maggie mendez on 02/10/20.
//

import Foundation
struct User: Codable{
    var id: String = UUID().uuidString
    let firstName: String
    let lastName: String
    let email: String
    let contactNumber: String
    let birthday: Date
    var friends: [User] = []
    let avatarImage: String
    
    enum CodingKeys: String, CodingKey{
        case firstName, lastName, email, contactNumber, birthday,avatarImage
    }
}

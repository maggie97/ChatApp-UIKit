
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
    var friends: [Friend] = []
    let avatarImage: String
    
    enum CodingKeys: String, CodingKey{
        case firstName, lastName, email, contactNumber,avatarImage, friends
    }
}

//
//  Friend.swift
//  ChatApp
//
//  Created by maggie mendez on 04/10/20.
//

import Foundation

struct Friend: Codable {
    let userId: String?
    let lastMessageId: String?
    
    enum CodingKeys: String, CodingKey {
        case userId, lastMessageId
    }
    
    init(dictionary: [String:Any]) {
        userId = dictionary[CodingKeys.userId.rawValue] as? String
        lastMessageId = dictionary[CodingKeys.lastMessageId.rawValue] as? String
    }
    
    init(_ userId: String, _ lastMessageId: String?) {
        self.userId = userId
        self.lastMessageId = lastMessageId
    }
}

struct Friends: Codable{
    var friends: [Friend]
    
    enum CodingKeys: String, CodingKey {
        case friends
    }
    init(dict: [[String: Any]]) {
        friends = []
        for item in dict {
            friends.append(Friend(dictionary: item))
        }
    }
}

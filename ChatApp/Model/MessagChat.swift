//
//  MessagChat.swift
//  ChatApp
//
//  Created by maggie mendez on 03/10/20.
//

import Foundation

struct MessageChat: Codable {
    let id: String  = UUID().uuidString
    let emailEmisor: String
    let emailReceptor: String?
    let message: String?
    let date: Date
    
    enum CodingKeys: String, CodingKey{
        case id, emailEmisor, emailReceptor, message, date
    }
}

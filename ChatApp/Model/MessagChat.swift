//
//  MessagChat.swift
//  ChatApp
//
//  Created by maggie mendez on 03/10/20.
//

import Foundation

struct MessageChat: Codable {
    var id: String?  = UUID().uuidString
    let emailEmisor: String?
    let emailReceptor: String?
    let message: String?
    let date: Date?
    
    enum CodingKeys: String, CodingKey{
        case id, emailEmisor, emailReceptor, message, date
    }
    init( by emailEmisor: String, from emailReceptor: String?,_ message: String, date: Date ) {
        self.emailEmisor = emailEmisor
        self.emailReceptor = emailReceptor
        self.message = message
        self.date = date
    }
    
    init(dictionary: [String: Any]) {
        let dateFormatter = DateFormatter()
        self.id = dictionary[CodingKeys.id.rawValue] as? String
        self.emailEmisor = dictionary[CodingKeys.emailEmisor.rawValue] as? String
        self.emailReceptor = dictionary[CodingKeys.emailReceptor.rawValue] as? String
        self.message = dictionary[CodingKeys.message.rawValue] as? String
        if let theDate = dictionary[CodingKeys.date.rawValue] as? String{
            self.date = dateFormatter.date(from: theDate)
        }
        else{
            self.date = Date()
        }
    }
    
    func getDate() -> String {
        let dateFormatter = DateFormatter()
        return dateFormatter.string(from: date ?? Date())
    }
}

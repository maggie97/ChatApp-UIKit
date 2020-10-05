//
//  ContactItemViewCell.swift
//  ChatApp
//
//  Created by maggie mendez on 02/10/20.
//

import UIKit

class ContactItemViewCell: UITableViewCell {

    @IBOutlet weak var nameFriendLabel: UILabel!
    @IBOutlet weak var lastMessageLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setup(){
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}

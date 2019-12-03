//
//  PersonTableController.swift
//  kiwari-ios-test
//
//  Created by farrell mochammad on 03/12/19.
//  Copyright © 2019 farrell mochammad. All rights reserved.
//

import UIKit

class PersonTableController: UITableViewCell {

    @IBOutlet weak var avatarIcon: UIImageView!
    
    @IBOutlet weak var txContactName: UILabel!
    
    @IBOutlet weak var txMessage: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        let url = URL(string: "https://api.adorable.io/avatars/160/ismail@mail.com.png")
        let data = try? Data(contentsOf: url!) //make sure your image in this url does exist, otherwise unwrap in a if let check / try-catch
        avatarIcon.image = UIImage(data: data!)

        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        
        // Configure the view for the selected state
    }
    
    func setContactInfo(contact: Contact){
        let url = URL(string: contact.friend_avatar!)
        let data = try? Data(contentsOf: url!) //make sure your image in this url does exist, otherwise unwrap in a if let check / try-catch
        avatarIcon.image = UIImage(data: data!)
        
        txContactName.text = contact.friend_name
        
        txMessage.text = contact.last_chat

    }
    
   

}

//
//  ContextToTableController.swift
//  kiwari-ios-test
//
//  Created by farrell mochammad on 03/12/19.
//  Copyright © 2019 farrell mochammad. All rights reserved.
//

import UIKit

class ContextToTableController: UITableViewCell {

    @IBOutlet weak var txDate: UILabel!
    @IBOutlet weak var txContext: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setContext(context: Context){
        txDate.text = context.date
        txContext.text = context.context
    }

}

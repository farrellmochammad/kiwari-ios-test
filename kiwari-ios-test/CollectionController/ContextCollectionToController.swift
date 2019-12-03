//
//  ContextCollectionToController.swift
//  kiwari-ios-test
//
//  Created by farrell mochammad on 03/12/19.
//  Copyright © 2019 farrell mochammad. All rights reserved.
//

import UIKit

class ContextCollectionToController: UICollectionViewCell {
    
    @IBOutlet weak var txDate: UILabel!
    @IBOutlet weak var txContext: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.txContext.numberOfLines = 0
        self.txContext.lineBreakMode = .byWordWrapping
        
        self.addSubview(txContext)
        
        self.txContext.translatesAutoresizingMaskIntoConstraints = false
        self.txContext.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        self.txContext.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        self.txContext.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        self.txContext.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}

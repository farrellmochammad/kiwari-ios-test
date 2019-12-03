//
//  Chat.swift
//  kiwari-ios-test
//
//  Created by farrell mochammad on 03/12/19.
//  Copyright © 2019 farrell mochammad. All rights reserved.
//

import UIKit

class Chat: UIViewController {

    @IBOutlet weak var contextTableView: UITableView!
   
    override func viewDidLoad() {
        super.viewDidLoad()
        contextTableView.tableFooterView = UIView()

        self.title = "Isi chat"
    }

}

extension Chat: UITableViewDataSource,UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row % 2 == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "ContextFromTableController") as! ContextFromTableController
            
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "ContextToTableController") as! ContextToTableController
            
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    
}

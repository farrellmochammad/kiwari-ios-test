//
//  Home.swift
//  kiwari-ios-test
//
//  Created by farrell mochammad on 03/12/19.
//  Copyright © 2019 farrell mochammad. All rights reserved.
//

import UIKit
import Firebase
import CryptoSwift

class Home: UIViewController {

    @IBOutlet weak var personTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        personTableView.tableFooterView = UIView()
        
        """
        let salt = "qehn8OVXrL"
        print("qehn8OVXrLjarjit@mail.com123456".sha256())
        print("qehn8OVXrLismail@mail.com123456".sha256())
        """
        
        /*let db = Firestore.firestore()
        var ref: DocumentReference? = nil
        ref = db.collection("users").addDocument(data: [
            "first": "Ada",
            "last": "Lovelace",
            "born": 1815
        ]) { err in
            if let err = err {
                print("Error adding document: \(err)")
            } else {
                print("Document added with ID: \(ref!.documentID)")
            }
        }*/

    }
    
    
    
    @IBAction func onLogout(_ sender: Any) {
        print("Hello logout")
    }
}

extension Home: UITableViewDataSource,UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PersonTableController") as! PersonTableController

        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "Chat") as! Chat
        self.navigationController?.pushViewController(nextViewController, animated: true)

    }
    
}

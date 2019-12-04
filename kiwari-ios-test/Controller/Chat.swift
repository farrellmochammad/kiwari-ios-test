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
    
    var chats: [Context] = []

   
    override func viewDidLoad() {
        super.viewDidLoad()
        contextTableView.tableFooterView = UIView()
        self.title = tempName
        readChat()
    }
    
    func getTimeZone(){
        let date = NSDate();
        let dateFormatter = DateFormatter()
        //To prevent displaying either date or time, set the desired style to NoStyle.
        dateFormatter.dateFormat = "dd-MM-yyyy HH:mm"
        dateFormatter.timeZone = NSTimeZone() as TimeZone
        let localDate = dateFormatter.string(from: date as Date)
        
        print("UTC Time")
        print(date)
        print("Local Time")
        print(localDate)
    }
    
    func readChat(){
        db.collection(chatid!).getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                for document in querySnapshot!.documents {
                    print("\(document.documentID) => \(document.data())")
                    self.chats.append(Context(context: document.data()["context"] as! String, from: document.data()["from"] as! String, date: document.data()["date"] as! String))
                }
                self.contextTableView.reloadData()
            }
        }
    }

}

extension Chat: UITableViewDataSource,UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return chats.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if chats[indexPath.row].from == "sender" {
            let cell = tableView.dequeueReusableCell(withIdentifier: "ContextFromTableController") as! ContextFromTableController
            
            cell.setContext(context: chats[indexPath.row])
            
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

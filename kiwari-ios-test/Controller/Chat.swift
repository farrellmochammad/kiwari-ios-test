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
    
    @IBOutlet weak var txChat: UITextField!
    
    var chats: [Context] = []
    var contact: Contact?

    override func viewDidLoad() {
        super.viewDidLoad()
        contextTableView.tableFooterView = UIView()
        self.title = tempName
    }
    
    override func viewDidAppear(_ animated: Bool) {
        readChat()
    }
    
    @IBAction func onSendChat(_ sender: Any) {
        sendChat(chat: txChat.text!)
        updateChat(chat: txChat.text!)
        txChat.text = ""
    }
    
    func getTimeZone()->String{
        let date = NSDate();
        let dateFormatter = DateFormatter()
        //To prevent displaying either date or time, set the desired style to NoStyle.
        dateFormatter.dateFormat = "dd-MM-yyyy HH:mm"
        dateFormatter.timeZone = NSTimeZone() as TimeZone
        let localDate = dateFormatter.string(from: date as Date)
        
        return localDate
    }
    
    func readChat(){
        db.collection(chatid!).getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                for document in querySnapshot!.documents {
                    self.chats.append(Context(context: document.data()["context"] as! String, from: document.data()["from"] as! String, date: document.data()["date"] as! String, order: document.data()["order"] as! Int ))
                }
                self.chats = self.chats.sorted(by: { $0.order! < $1.order! })
                self.contextTableView.reloadData()
            }
        }
    }
    
    func sendChat(chat:String){
        ref = db.collection(chatid!).addDocument(data: [
            "context": chat,
            "date": getTimeZone(),
            "from": useremail,
            "order": chats.count
        ]) { err in
            if let err = err {
                print("Error adding document: \(err)")
            } else {
                print("Document added with ID: \(ref!.documentID)")
                self.chats = []
                self.readChat()
            }
        }
    }
    
    func updateChat(chat: String){
        db.collection(useremail!).document(chatid!).updateData([
            "last_chat": chat,
        ]) { err in
            if let err = err {
                print("Error writing document: \(err)")
            } else {
                print("Document successfully written!")
            }
        }
        db.collection((contact?.friend_email)!).document(chatid!).updateData([
            "last_chat": chat,
            ]) { err in
                if let err = err {
                    print("Error writing document: \(err)")
                } else {
                    print("Document successfully written!")
                }
        }
    }
    
    

}

extension Chat: UITableViewDataSource,UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return chats.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if chats[indexPath.row].from != useremail {
            let cell = tableView.dequeueReusableCell(withIdentifier: "ContextFromTableController") as! ContextFromTableController
            
            cell.setContext(context: chats[indexPath.row])
            
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "ContextToTableController") as! ContextToTableController
            
            cell.setContext(context: chats[indexPath.row])
            
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    
}

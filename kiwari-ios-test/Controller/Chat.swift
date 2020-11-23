//
//  Chat.swift
//  kiwari-ios-test
//
//  Created by farrell mochammad on 03/12/19.
//  Copyright © 2019 farrell mochammad. All rights reserved.
//

import UIKit
import CoreData

class Chat: UIViewController {

    @IBOutlet weak var contextTableView: UITableView!
    
    @IBOutlet weak var txChat: UITextField!
    
    @IBOutlet var keyboardHeightLayoutConstraint: NSLayoutConstraint?
    
    var chats: [Context] = []
    var contact: Contact?
    var keyboardHeight = CGFloat(0)

    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillShow), name: UIResponder.keyboardWillHideNotification, object: nil)
        contextTableView.tableFooterView = UIView()
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        

        let containView = UIView(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
        let imageview = UIImageView(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
        let url = URL(string: (contact?.friend_avatar)!)
        let data = try? Data(contentsOf: url!)
        imageview.image = UIImage(data: data!)
        imageview.contentMode = UIView.ContentMode.scaleAspectFit
        imageview.layer.masksToBounds = true
        containView.addSubview(imageview)
        let rightBarButton = UIBarButtonItem(customView: containView)
        self.navigationItem.rightBarButtonItem = rightBarButton
        
        
        //make sure your image in this url does exist, otherwise unwrap in a if let check / try-catch
        
        view.addGestureRecognizer(tap)
        
        self.title = tempName
    
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.showSpinner(onView: self.view)
        setUserEmail()
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
                self.removeSpinner()
            }
        }
    }
    
    func setUserEmail(){
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Stat")
        //request.predicate = NSPredicate(format: "age = %@", "12")
        request.returnsObjectsAsFaults = false
        let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext
        
        do {
            let result = try context?.fetch(request)
            for data in result as! [NSManagedObject] {
                if data.value(forKey: "useremail") as? String != nil {
                    useremail = data.value(forKey: "useremail") as? String
                }
            }
        } catch {
            print("Failed")
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
    
    @objc func keyboardWillShow(notification: NSNotification){
        guard let userInfo = notification.userInfo else {return}
        guard let keyboardSize = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else {return}
        let keyboardFrame = keyboardSize.cgRectValue
        if self.view.frame.origin.y == 0{
            self.view.frame.origin.y -= keyboardFrame.height
            keyboardHeight = keyboardFrame.height
        }

    }
    
    @objc func keyboardWillHide(notification: NSNotification){
        guard let userInfo = notification.userInfo else {return}
        guard let keyboardSize = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else {return}
        let keyboardFrame = keyboardSize.cgRectValue
        if self.view.frame.origin.y != 0{
            self.view.frame.origin.y += keyboardFrame.height
            keyboardHeight = keyboardFrame.height

        }
       }
    
    @objc func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
        if self.view.frame.origin.y != 0{
            self.view.frame.origin.y += keyboardHeight
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
            
            cell.selectionStyle = .none
            
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "ContextToTableController") as! ContextToTableController
            
            cell.setContext(context: chats[indexPath.row])
            
            cell.selectionStyle = .none
            
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    
}

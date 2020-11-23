//
//  Home.swift
//  kiwari-ios-test
//
//  Created by farrell mochammad on 03/12/19.
//  Copyright © 2019 farrell mochammad. All rights reserved.
//

import UIKit
import Firebase
import CoreData
import CryptoSwift

class Home: UIViewController {

    @IBOutlet weak var personTableView: UITableView!
    
    var contacts: [Contact] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        personTableView.tableFooterView = UIView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.showSpinner(onView: self.view)
        contacts = []
        setUserEmail()
        readContact()
    }
    
    
    @IBAction func onLogout(_ sender: Any) {
        deleteLogin()
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "Login")
        nextViewController.modalPresentationStyle = .fullScreen
        self.present(nextViewController, animated:true, completion:nil)
    }
    
    func readContact(){
        db.collection(useremail!).getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                for document in querySnapshot!.documents {
                    self.contacts.append(Contact(chat_id: document.documentID,friend_avatar: document.data()["friend_avatar"] as! String, friend_email: document.data()["friend_email"] as! String , friend_name: document.data()["friend_name"] as! String, last_chat: document.data()["last_chat"] as! String))
                }
                self.personTableView.reloadData()
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
    
    func deleteLogin(){
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Stat")
        request.returnsObjectsAsFaults = false
        do {
            let result = try context.fetch(request)
            for data in result as! [NSManagedObject]
            {
                context.delete(data)
            }
            do {
                try context.save()
            }
            catch {
                print(error)
            }
        } catch {
            print("Gagal")
        }
        
    }

}

extension Home: UITableViewDataSource,UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.contacts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PersonTableController") as! PersonTableController
        
        cell.setContactInfo(contact: contacts[indexPath.row])
        
        cell.selectionStyle = .none

        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 75
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tempName = contacts[indexPath.row].friend_name
        chatid = contacts[indexPath.row].chat_id
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "Chat") as! Chat
        nextViewController.contact = contacts[indexPath.row]
        self.navigationController?.pushViewController(nextViewController, animated: true)
    }
    
}

//
//  ViewController.swift
//  kiwari-ios-test
//
//  Created by farrell mochammad on 03/12/19.
//  Copyright © 2019 farrell mochammad. All rights reserved.
//

import UIKit
import CryptoSwift

class Login: UIViewController {

    @IBOutlet weak var txEmail: UITextField!
    
    @IBOutlet weak var txPassword: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    @IBAction func onLogin(_ sender: Any) {
        readUsername(email: txEmail.text!, password: txPassword.text!)
    }
    
    func readUsername(email: String,password: String){
        db.collection("username").getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                for document in querySnapshot!.documents {
                    if document.data()["email"] as! String == email {
                        if self.generateKeyHash(email: email, password: password) == document.data()["password"] as! String{
                            let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                            let nextViewController = storyBoard.instantiateViewController(withIdentifier: "HomeNavigation")
                            self.present(nextViewController, animated:true, completion:nil)
                        }
                    }
                }
                let alert = UIAlertController(title: "Username atau password salah", message: "Coba untuk cek kembali", preferredStyle: .alert)
                
                alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: nil))
                self.present(alert, animated: true)
            }
        }
    }
    
    
    func generateKeyHash(email: String,password: String)->String{
        let salt = "qehn8OVXrL" + email + password
        return salt.sha256()
    }
    
}


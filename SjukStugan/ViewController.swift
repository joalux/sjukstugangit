//
//  ViewController.swift
//  SjukStugan
//
//  Created by joakim lundberg on 2019-02-28.
//  Copyright © 2019 joakim. All rights reserved.
//

import UIKit
import Firebase


class ViewController: UIViewController {
    
    
    var datab : Firestore!
    var handle: AuthStateDidChangeListenerHandle?

   
    @IBOutlet var popOver: UIView!
    @IBOutlet weak var userName: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var newUserName: UITextField!
    @IBOutlet weak var newPassword: UITextField!
    @IBOutlet weak var confirmPassword: UITextField!
    @IBOutlet weak var newUserLabel: UILabel!
    
    
   // let data: [String: Any] = ["]
     var treatments: [String] = []
    var usersArray: [String] = []
    var blue = UIColor(red: 100.0/255.0, green: 130.0/255.0, blue: 230.0/255.0, alpha: 1.0)
    var loginName = ""
    
    
    @IBAction func openSignUp(_ sender: UIButton) {
        self.view.addSubview(popOver)
        popOver.layer.borderColor = blue.cgColor
        popOver.layer.borderWidth = 3.0
        popOver.center = self.view.center
    }
    @IBAction func createUser(_ sender: UIButton) {
        var newName = newUserName.text!
        var newPass = newPassword.text!
        var confirmPass = confirmPassword.text!
        let data: [String: Any] = [:]
    
        if newPass == confirmPass || newPass.count > 6 {
            Auth.auth().createUser(withEmail: newName, password: newPass) { authResult, error in
                if (error == nil) {
                    print("created user")
                    self.datab.collection("users").document("\(newName)").setData(data)
                    
                    print(newName)
                    
                } else {
                    print("error!!! \(error)")
                }
            }
            self.popOver.removeFromSuperview()
        }
        else {
            newUserLabel.text = "Lösenord måste vara lika och minst 6 tecken"
        }
    }
    @IBAction func closeSignIn(_ sender: UIButton) {
        self.popOver.removeFromSuperview()
        
    }
    
    @IBAction func signIn(_ sender: UIButton) {
        
        Auth.auth().signIn(withEmail: userName.text!, password: password.text!) { (user, error) in
            if error == nil{
                self.loginName = self.userName.text!
                self.performSegue(withIdentifier: "loginToHome", sender: self)
            }
            else{
                let alertController = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: .alert)
                let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                
                alertController.addAction(defaultAction)
                self.present(alertController, animated: true, completion: nil)
            }
        
        }
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        handle = Auth.auth().addStateDidChangeListener { (auth, user) in
            
        }
    }
    override func viewWillDisappear(_ animated: Bool) {
        Auth.auth().removeStateDidChangeListener(handle!)

    }
    
    override func viewDidLoad() {
        
        Auth.auth().addStateDidChangeListener { auth, user in
            if let user = user {
                print("User is signed in")
                print(user)
                print(user.email)
                if let unwrapped = user.email {
                    self.loginName = unwrapped
                    self.performSegue(withIdentifier: "loginToHome", sender: self)
                }

            } else {
                print("No user is signed in")
            }
        }
        
        
        let formatter = DateFormatter()
        
        formatter.dateFormat = "yyyy/MM/dd"
        
        let myString = formatter.string(from: Date()) // string purpose I add here
        print("Dateformat string \(myString)")
        // convert your string to date
        let yourDate = formatter.date(from: myString)
        print("date is formatted \(yourDate)")

        
         datab = Firestore.firestore()
       
        super.viewDidLoad()
       
    }
    
    
   override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "loginToHome" {
            if let destination = segue.destination as? profileViewController {
                
                destination.userName = loginName
                print("Going to start totTreatments: \(treatments.count)")
                
                
                
                
            }
            
        }
    }


}


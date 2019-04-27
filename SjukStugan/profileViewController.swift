//
//  profileViewController.swift
//  SjukStugan
//
//  Created by joakim lundberg on 2019-02-28.
//  Copyright © 2019 joakim. All rights reserved.
//

import UIKit
import Firebase

class profileViewController: UIViewController {
    
    var datab: Firestore!

    @IBOutlet weak var diagnosLabel: UILabel!
    @IBOutlet weak var totTreatmentsLabel: UILabel!
    
    @IBOutlet weak var progressCounter: UILabel!
    @IBOutlet weak var divider: UILabel!
    @IBOutlet var newTreatment: [UILabel]!
    @IBOutlet var bokningar: [UIStackView]!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var finishedTreatLabel: UILabel!
    
    @IBOutlet weak var buttonLink1: UIButton!
    @IBOutlet weak var buttonLink2: UIButton!
    @IBOutlet weak var buttonLink3: UIButton!
    
    
    var treatments: [Treatment] = []
    var docRefs: [String] = []
    var meds: [Medicine] = []
    var medRefs: [String] = []
    var timer: Timer!
    var countTreatments = 0
    var i = 0
    var userName = ""
    var loadTreatments = false
    let data: [String: Any] = [:]
    //var label: UILabel
    
    override func viewDidLoad() {
        print(treatments)
        super.viewDidLoad()
        progressCounter.text = ""
        nameLabel.text = userName
        totTreatmentsLabel.font = UIFont.boldSystemFont(ofSize: 16.0)
        //totTreatmentsLabel.text = "Finished \n treatments"
        datab = Firestore.firestore()
        
        print("load is = \(loadTreatments)")
      datab.collection("users").document(userName).collection("treatments").getDocuments() { (querySnapshot, err) in
                if let err = err {
                    print("Error getting documents: \(err)")
                } else {
                    for document in querySnapshot!.documents {
       
                        var docID = document.documentID
                        
                        var newTreat = Treatment(snapshot: document)
                        
                        self.docRefs.append(docID)
                        
                        let formatter = DateFormatter()
                        
                        formatter.dateFormat = "yyyy-MM-dd HH:mm"
                        
                        let myString = formatter.string(from: Date())
                        
                        if(self.i < 6){
                            let myString = formatter.string(from: newTreat.date)
                            self.newTreatment[self.i].text = "\(newTreat.name) \n \(myString)"
                        }
                        if self.loadTreatments == false {
                            self.treatments.append(newTreat)
                        }
                        
                        self.progressCounter.text = "\(self.treatments.count)"
                        self.i = self.i + 1
                    }
                }
            }
            
        datab.collection("users").document(userName).collection("mediciner").getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                for document in querySnapshot!.documents {
                    //print("\(document.documentID) => \(document.data())")
                    var docID = document.documentID
                    
                    var newMed = Medicine(snapshot: document)
                    
                    self.medRefs.append(docID)
                    if self.loadTreatments == false {
                        self.meds.append(newMed)
                    }
               
                    
                }
                //print("mediciner arrayen \(self.meds)")
            }
        }
            
        buttonLink1.layer.cornerRadius = 6
        buttonLink2.layer.cornerRadius = 6
        buttonLink3.layer.cornerRadius = 6


        view.bringSubviewToFront(divider)
        view.bringSubviewToFront(diagnosLabel)
        
   }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "toTreatments"  {
            if let destination = segue.destination as? NumberViewController {
                destination.loadFirstTime = loadTreatments
                destination.treatments = treatments
                print(treatments)
                destination.treatCount = countTreatments
                destination.username = userName
                print("Going to treatments count: \(countTreatments)")
                loadTreatments = true
                destination.loadFirstTime = loadTreatments
                destination.docRefs = docRefs
                destination.medRefs = medRefs
                destination.meds = meds
            }
        }
        if segue.identifier == "toContacts"  {
            if let destination = segue.destination as? contactsViewController {
                
                destination.loadFirstTime = loadTreatments
                destination.treatments = treatments
                print(treatments)
                destination.treatCount = countTreatments
                destination.username = userName
                loadTreatments = true
                destination.loadFirstTime = loadTreatments
                destination.docRefs = docRefs
                destination.medRefs = medRefs
                destination.meds = meds
                
            }
        }
        if segue.identifier == "toMedicine"  {
            
            if let destination = segue.destination as? medTableViewController {
                
                print("Going to medicines")
                
                destination.loadFirstTime = loadTreatments
                destination.treatments = treatments
                destination.meds = meds
                destination.treatCount = countTreatments
                destination.username = userName
                loadTreatments = true
                destination.loadFirstTime = loadTreatments
                destination.docRefs = docRefs
                destination.medRefs = medRefs
            }
        }
        if segue.identifier == "logOut" {
            print("Signng out")
            let firebaseAuth = Auth.auth()
            do {
                try firebaseAuth.signOut()
            } catch let signOutError as NSError {
                print ("Error signing out: %@", signOutError)
        }
        
        }
    }
}



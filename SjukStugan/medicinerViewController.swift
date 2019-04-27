//
//  medicinerViewController.swift
//  SjukStugan
//
//  Created by joakim lundberg on 2019-04-07.
//  Copyright © 2019 joakim. All rights reserved.
//

import UIKit

class medicinerViewController: UIViewController {

    
    @IBOutlet weak var amountOfMeds: UILabel!
    @IBOutlet weak var medStepper: UIStepper!
    @IBOutlet weak var medName: UITextField!
    
    
    @IBOutlet var popOver: UIView!
    @IBOutlet weak var medicinList: UITableView!
    
    var myMedicins: [String] = []
    var treatments: [String] = []
    var countMeds = 0
    var treatCount = 0
    var blue = UIColor(red: 100.0/255.0, green: 130.0/255.0, blue: 230.0/255.0, alpha: 1.0)


    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //medicinList
       
        self.popOver.layer.cornerRadius = 10

        print("is in my medicins _________________________")
        print(treatments)
        
      
    }
    @IBAction func openPopover(_ sender: UIBarButtonItem) {
        self.view.addSubview(popOver)
        popOver.layer.borderColor = blue.cgColor
        popOver.layer.borderWidth = 3.0
        popOver.center = self.view.center
        
    
    }
    
    @IBAction func addAmount(_ sender: UIStepper) {
        countMeds = Int(medStepper.value)
        amountOfMeds.text = "\(countMeds)"
        
    }
    @IBAction func addMed(_ sender: UIButton) {
        
        
        popOver.removeFromSuperview()
    }
    
    
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "backToMain" {
            if let destination = segue.destination as? profileViewController {
                //destination.treatments = treatments
                
                print(treatments)
                destination.countTreatments = treatCount
               
            }
            
        }
    }
    
  
    

}

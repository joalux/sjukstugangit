//
//  contactsViewController.swift
//  SjukStugan
//
//  Created by joakim lundberg on 2019-04-05.
//  Copyright © 2019 joakim. All rights reserved.
//

import UIKit
import SafariServices

class contactsViewController: UIViewController {

    
    @IBOutlet var cityButtons: [UIButton]!
    
    var treatCount = 0
    var treatments: [Treatment] = []
    var docRefs: [String] = []
    var loadFirstTime = false
    var username = ""
    var medRefs: [String] = []
    var meds: [Medicine] = []

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("is in contacts _______________")
        print(meds)
    }
    
    
    
    
    @IBAction func showSjukhus(_ sender: UIButton) {
        showSafariVC(for: "https://www.vardguiden.com/lista-over-sjukhus-i-sverige/")
    }
    @IBAction func showKarolinska(_ sender: UIButton) {
        showSafariVC(for: "https://www.karolinska.se/for-patienter/alla-mottagningar-och-avdelningar-a-o/")
    }
    @IBAction func showSahlgrenska(_ sender: UIButton) {
        showSafariVC(for: "https://www.sahlgrenska.se/avdelningar-och-mottagningar/")
    }
    @IBAction func showSunderby(_ sender: UIButton) {
        showSafariVC(for: "https://www.norrbotten.se/sv/Halsa-och-sjukvard/Sjukhus/Sunderby-sjukhus/Vard-A-till-O-Sunderby-sjukhus/")
    }
    @IBAction func showSkåneuni(_ sender: UIButton) {
        showSafariVC(for: "https://vard.skane.se/skanes-universitetssjukhus-sus/mottagningar-och-avdelningar/")
    }
    
    @IBAction func ASIHStockholm(_ sender: UIButton) {
        showSafariVC(for: "http://asih.sll.se/avancerad-sjukvard-i-hemmet/")
    }
    @IBAction func ASIHGoteborg(_ sender: UIButton) {
        showSafariVC(for: "https://www.sahlgrenska.se/omraden/omrade-6/geriatrik-lungmedicin-och-allergologi/enheter/enhet-for-avancerad-sjukvard-i-hemmet/")
    }
   
    @IBAction func ASIHMalmo(_ sender: UIButton) {
        showSafariVC(for: "https://www.1177.se/hitta-vard/kontaktkort/Palliativ-vard-och-ASIH-Malmo/")
    }
    
    @IBAction func patientforeningar(_ sender: UIButton) {
        showSafariVC(for: "https://www.1177.se/liv--halsa/psykisk-halsa/att-soka-stod-och-hjalp/patient--och-narstaendeforeningar/")
    }
    
    
    @IBAction func forsakringskassan(_ sender: UIButton) {
    showSafariVC(for: "https://forsakringskassan.se")
    }
  
    @IBAction func fardtjanstStockholm(_ sender: UIButton) {
        showSafariVC(for: "https://fardtjansten.sll.se/sv/")
    }
    @IBAction func fardtjanstGoteborg(_ sender: UIButton) {showSafariVC(for: "https://goteborg.se/wps/portal/start/fardtjanst/!ut/p/z1/hY5NC4JAGIR_jdd9X82vutnBSCUtAm0vobKtguvKurXQr8-OQdHchnmGGaBQAR3rR89r3cuxHhZ_of61sJNjuLUjzHfrGPfntIgPaZYXJwfKfwBdYvyhCCEB2jeCmFYQJF7ouX5gB-hgsHLRf89HY7MKOVDFbkwxRe5qedVpPc0bCy00xhAuJR8YaaWw8Fulk7OG6pOESVTPjJXRC4G-9dk!/dz/d5/L2dBISEvZ0FBIS9nQSEh/")
    }
    @IBAction func fardtjanstLulea(_ sender: UIButton) {
    showSafariVC(for: "https://ltnbd.se/trafiken/fardtjanst/")
    }
    @IBAction func fardtjanstMalmo(_ sender: UIButton) {
    showSafariVC(for: "https://malmo.se/Service/Du-och-dina-anhoriga/Fardtjanst-och-riksfardtjanst.html")
    }
    
    @IBAction func vardguiden(_ sender: UIButton) {
   showSafariVC(for: "https://www.1177.se")
    
    }
    
    
    
    
    
    func showSafariVC(for url: String){
        guard let url = URL(string: url) else {
            //show invalid URL error
            return
        }
        let safariVC = SFSafariViewController(url: url)
        present(safariVC, animated: true, completion: nil)
        
        
    }
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "backToMain" {
            
            if let destination = segue.destination as? profileViewController {
                destination.countTreatments = treatCount
                destination.treatments = treatments
                destination.userName = username
                destination.loadTreatments = loadFirstTime
                destination.docRefs = docRefs
                destination.medRefs = medRefs
                destination.meds = meds
            }
            print(treatments)
            print("Going to start totTreatments: \(treatCount)")
        }
    }
    
}

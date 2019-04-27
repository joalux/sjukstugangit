//
//  Medicine.swift
//  SjukStugan
//
//  Created by joakim lundberg on 2019-04-21.
//  Copyright © 2019 joakim. All rights reserved.
//

import Foundation
import Firebase

class Medicine {
    
    var name: String
    var amount: Int
    
    init(name: String, amount: Int ) {
        self.name = name
        self.amount = amount
       
    }
    
    init(snapshot: QueryDocumentSnapshot) {
        let snapshotValue = snapshot.data() as [String : Any]
        name = snapshotValue["name"] as! String
        amount = snapshotValue["amount"] as! Int
        
        
    }
    
    func toDictionary() -> [String: Any] {
        return ["name": name,
                "amount": amount
    ]
    }
}


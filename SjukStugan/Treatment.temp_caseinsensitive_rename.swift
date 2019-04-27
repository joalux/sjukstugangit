//
//  treatment.swift
//  SjukStugan
//
//  Created by joakim lundberg on 2019-04-17.
//  Copyright © 2019 joakim. All rights reserved.
//

import Foundation
import Firebase

class Treatment {
    
    var name: String
    var date: Date
    
    init(name: String, date: Date ) {
        self.name = name
        self.date = date
    }
    
    init(snapshot: QueryDocumentSnapshot) {
        let snapshotValue = snapshot.data() as [String : Any]
        name = snapshotValue["name"] as! String
        date = snapshotValue["done"] as! Date
    }
    
    func toDictionary() -> [String: Any] {
        return ["name": name,
                "date": date]
    }
    
}

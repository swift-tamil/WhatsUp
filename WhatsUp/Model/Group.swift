//
//  Group.swift
//  WhatsUp
//
//  Created by python on 07/11/23.
//

import Foundation
import FirebaseFirestore

struct Group: Codable, Identifiable{
    
    var documentId: String? = nil
    let subject: String
    
    var id: String{
        documentId ?? UUID().uuidString
    }
    
}

extension Group{
    
    func toDictionary() -> [String: Any]{
        return ["subject": subject]
    }
    
    static func fromSnapshot(snapshot: QueryDocumentSnapshot) -> Group?{
        let dictonary = snapshot.data()
        guard let subject = dictonary["subject"] as? String else{
            return nil
        }
        
        return Group(documentId: snapshot.documentID, subject: subject)
    }
}

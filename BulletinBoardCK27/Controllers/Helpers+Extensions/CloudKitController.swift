//
//  CloudKitController.swift
//  BulletinBoardCK27
//
//  Created by Drew Seeholzer on 7/8/19.
//  Copyright © 2019 Drew Seeholzer. All rights reserved.
//

import Foundation
import CloudKit

class CloudKitController {
    // Shared instance
    static let shared = CloudKitController()
    
    // Database instances
    //Creating an instance to the public cloud database
    let publicDatabase = CKContainer.default().publicCloudDatabase
    
    // MARK : - CRUD
    // Create
    // save the record passed in, complete with an optional error
    func saveRecordToCloudKit(record: CKRecord, database: CKDatabase, completion: @escaping (Bool) -> Void) {
        
        database.save(record) { (_, error) in
            if let error = error {
                print ("Error in \(#function) : \(error.localizedDescription) /n---/n \(error)")
                completion(false)
            }
            print(#function)
        }
    }
    
    // Read
     // Conditions of query, conditions to be return all found values
    func fetchRecordsOf(type: String, database: CKDatabase, completion: @escaping ([CKRecord]?, Error?) -> Void) {
       // defines the record type we want to find, applies our predicate conditions
        let predicate = NSPredicate(value: true)
         // Perform query, complete with our records and optional error
        let query = CKQuery(recordType: type, predicate: predicate)
       
        database.perform(query, inZoneWith: nil) { (records, error) in
            if let error = error {
                print("Error in \(#function) : \(error.localizedDescription) /n---/n \(error)")
                completion(nil, error)
            }
            if let records = records {
                completion(records, nil)
            }
        }
    }
}

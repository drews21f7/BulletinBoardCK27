//
//  MessageController.swift
//  BulletinBoardCK27
//
//  Created by Drew Seeholzer on 7/8/19.
//  Copyright © 2019 Drew Seeholzer. All rights reserved.
//

import Foundation

class MessageController {
    //Singleton
    static let shared = MessageController()
    
    //Source of truth
    var messages: [Message] = []
    
    // MARK: - CRUD
    //Create
    func saveMessageRecord(_ text: String) {
        // init a message
        let messageToSave = Message(text: text)
        let database = CloudKitController.shared.publicDatabase
        
        CloudKitController.shared.saveRecordToCloudKit(record: messageToSave.cloudKitRecord, database: database) { (success) in
            if success {
                print("Successfully saved Message to CloudKit")
                self.messages.append(messageToSave)
            }
        }
        
    }
    
    //Read
    func fetchMessageRecords() {
        
        let database = CloudKitController.shared.publicDatabase
        CloudKitController.shared.fetchRecordsOf(type: Message.typeKey, database: database) { (records, error) in
            
            // Handel error
            if let error = error {
                print ("Error in \(#function) : \(error.localizedDescription) /n---/n \(error)")
            }
            
            //verify records exist
            guard let foundRecords = records else { return }
            
            // Iterates through foundRecords, init Messages from the values that can init a Mesaage, creating a new array from successes
            let messages = foundRecords.compactMap( {Message(record: $0)} )
            
            //Set source of truth
            self.messages = messages
        }
    }
    //Update
    
    //Delete
}

//
//  Message.swift
//  BulletinBoardCK27
//
//  Created by Drew Seeholzer on 7/8/19.
//  Copyright © 2019 Drew Seeholzer. All rights reserved.
//

import Foundation
import CloudKit

class Message {
    
    //Keys for CloudKit Storage
    static let typeKey = "Message"
   private let textKey = "Text"
    private let timestampKey = "Timestamp"
    
    //Class properties
    let text: String
    let timestamp: Date
    
    var cloudKitRecord: CKRecord {
        //Define the record type
        let record = CKRecord(recordType: Message.typeKey)
        // Set your key value pairs
        record.setValue(text, forKey: textKey)
        record.setValue(timestamp, forKey: timestampKey)
        //Return the record
        return record
    }
    
    //Class initializer
    init(text: String, timestamp: Date = Date()) {
        self.text = text
        self.timestamp = timestamp
    }
    
    //Failable init to pass in CKRecord
    init?(record: CKRecord) {
        //Guard against keys
        guard let text = record[textKey] as? String, let timestamp = record[timestampKey] as? Date else { return nil }
        // Set values for model properties
        self.text = text
        self.timestamp = timestamp
    }
}

extension Message: Equatable {
    static func == (lhs: Message, rhs: Message) -> Bool {
        return lhs.text == rhs.text && lhs.timestamp == rhs.timestamp
    }
}

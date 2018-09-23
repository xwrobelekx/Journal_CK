//
//  CloudKitManager.swift
//  Journal_CK
//
//  Created by Kamil Wrobel on 9/22/18.
//  Copyright © 2018 Kamil Wrobel. All rights reserved.
//

import Foundation
import CloudKit

//MARK: - Steps for save and fetch functions:

//SAVE

//#1 Initialize new shared object
//#2 Use a CloudKitManager function to save the message's CKRecords
//#3 Check for errors
//#4 If there are no errors, then append the message to the message array

//FETCH

//#1 Use a CloudKitManager function to fetch Message records from the right database
//#2 Check for errors in the completion
//#3 Take the records returned and initialize Message objects from them.
//#4 Set the newly created messages in the MessageController's array of Messages


class CloudKitManager {
    
    //MARK: - CloudKit Shared instance
    static let shared = CloudKitManager()
    
    private init () {}
    
    //MARK: - CloudKit Save Method
    
    func saveRecordToiCloud(record: CKRecord, database: CKDatabase, completion: @escaping (Error?) -> Void = { _ in }) {
        
        database.save(record) { (_, error) in
            completion(error)
        }
        
    }
    
    //MARK: - CloudKit Fetch Method
    
    func fetchRecordsOf(type: String, database: CKDatabase, completion: @escaping ([CKRecord]?, Error?) -> Void) {
        
        let predicate = NSPredicate(value: true)
        let query = CKQuery(recordType: type, predicate: predicate)
        
        database.perform(query, inZoneWith: nil, completionHandler: completion)
    }
    
    //FIXME: - Questions
    // - what is the closure in the first function equals to
    // - what exacly are we looking for in completion for this case
    // - read about NSPredicate
    // - what is inZoneWith
}

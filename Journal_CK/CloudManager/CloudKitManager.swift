//
//  CloudKitManager.swift
//  Journal_CK
//
//  Created by Kamil Wrobel on 9/22/18.
//  Copyright © 2018 Kamil Wrobel. All rights reserved.
//

import Foundation
import CloudKit

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

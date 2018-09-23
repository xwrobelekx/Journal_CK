//
//  EntryController.swift
//  Journal_CK
//
//  Created by Kamil Wrobel on 9/22/18.
//  Copyright © 2018 Kamil Wrobel. All rights reserved.
//

import Foundation
import CloudKit

class EntryController {
    
    
    //MARK: - Shared Instance
    
    static let shared = EntryController()
    private init() {}
    
    //MARK: - Notification
    let entriesWereUpdatedNotification = Notification.Name("entriesWereUpdated")
    
    
    //MARK: - Source of Truth
    var entries: [Entry] = [] {
        didSet{
            //need to reload data in list table view when this changes
            NotificationCenter.default.post(name: entriesWereUpdatedNotification, object: nil)
        }
    }
    
    
    //MARK: CRUD Methods
    
    func createNewEntry(title: String, note: String?){
        let entry = Entry(title: title, note: note)
        saveRecordToiCloud(entry: entry)
    }
    
    
    func updateEntry(entry: Entry, title: String, note: String?, date: Date? = Date()){
        entry.title = title
        entry.note = note
        entry.dateStamp = date
        saveRecordToiCloud(entry: entry)
    }
    
    
    //MARK: Save Record to iCloud

    func saveRecordToiCloud(entry: Entry){
    
        CloudKitManager.shared.saveRecordToiCloud(record: entry.cloudKitRecord, database: CKContainer.default().publicCloudDatabase){ (error) in
            if let error = error {
                print("Error Saving To iCloud Database: \(error.localizedDescription)")
            } else {
                self.entries.append(entry)
            }
        }
    }

    
    //MARK: - Fetch Records from iCloud
    func fetchEntriesFromiCloud() {
        
        CloudKitManager.shared.fetchRecordsOf(type: Entry.TypeKey, database: CKContainer.default().publicCloudDatabase) { (records, error) in
            if let error = error {
                print("Error Fetching From iCloud: \(error.localizedDescription)")
            }
            
            guard let records = records else {
                print("There was no error fetching, but there is no data eather")
                return
            }
            let entries = records.compactMap({Entry(cloudKitRecord: $0)})
            self.entries = entries
        }
    }
    
}


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



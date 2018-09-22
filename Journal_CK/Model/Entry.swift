//
//  Entry.swift
//  Journal_CK
//
//  Created by Kamil Wrobel on 9/22/18.
//  Copyright © 2018 Kamil Wrobel. All rights reserved.
//

import Foundation
import CloudKit

class Entry {
    
    //MARK: - Keys
    
    static  let TypeKey      = "Entry"
    private let TitleKey     = "title"
    private let NoteKey      = "note"
    private let DateStampKey = "dateStamp"
    
    
    //MARK: - Properties
    
    let title     : String
    let note      : String
    let dateStamp : Date
    
    init(title: String, note: String, dateStamp: Date = Date()){
        self.title     = title
        self.note      = note
        self.dateStamp = dateStamp
    }
    
    
    //MARK: - CloudKit Record
    
    var cloudKitRecord: CKRecord {
        
        let record = CKRecord(recordType: Entry.TypeKey)
        record.setValue(note, forKey: NoteKey)
        record.setValue(dateStamp, forKey: DateStampKey)
        return record
    }
    
    
    //MARK: - Failable initializer to turn fetched values into model properties
    
    init?(cloudKitRecord: CKRecord){
        
        guard let title     = cloudKitRecord[TitleKey]     as? String,
              let note      = cloudKitRecord[NoteKey]      as? String,
              let dateStamp = cloudKitRecord[DateStampKey] as? Date else {return nil}
        
        self.title     = title
        self.note      = note
        self.dateStamp = dateStamp
        
        
        
    }
    
    
    
    
    
    
}

//
//  ComposeEntryViewController.swift
//  Journal_CK
//
//  Created by Kamil Wrobel on 9/22/18.
//  Copyright © 2018 Kamil Wrobel. All rights reserved.
//

import UIKit

class ComposeEntryViewController: UIViewController {
    
    //MARK: Outlets
    
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var noteTextField: UITextView!
    
    
    //MARK: - Properties
    
    var entry: Entry? {
        didSet {
            updateViews()
        }
    }
    
    //MARK: - LifeCycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    

    //MARK: - Actions

    @IBAction func saveButtonTapped(_ sender: Any) {
        
        guard titleTextField.text != "" else {return}
        guard let title = titleTextField.text else {return}
        
        if entry != nil {
        //update entry
            guard let entry = entry else {return}
            EntryController.shared.updateEntry(entry: entry, title: title, note: noteTextField.text)
        } else {
        //create new one
        EntryController.shared.createNewEntry(title: title, note: noteTextField.text)
        }
        
        navigationController?.popViewController(animated: true)
        
    }
    
    //MARK: - Helper Methods
    
    func updateViews(){
        guard let entry = entry else {return}
        titleTextField.text = entry.title
        noteTextField.text = entry.note
    }
    
}

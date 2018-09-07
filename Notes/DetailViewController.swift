//
//  DetailViewController.swift
//  Notes
//
//  Created by Jethro Williams on 05/09/2018.
//  Copyright © 2018 Jethro Williams. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet var noteText: UITextView!
    
    var selectedNote: String?
    var notes = [String]()
    var notePath = -1
    
    let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let noteToLoad = selectedNote {
            noteText.text = noteToLoad
        } else {
            noteText.text = ""
        }
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(saveNote))

    }
    
    @objc func saveNote() {
        
        let newNote = noteText.text
        
        if newNote != "" {
            if notePath != -1 {
                notes[notePath] = newNote!
            } else {
                notes.append(newNote!)
            }
        }
        
        print("notes: \(notes)")
        
        defaults.set(notes, forKey: "savedArray")
        
        self.navigationController?.popViewController(animated: true)
        self.dismiss(animated: true, completion: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

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
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .trash, target: self, action: #selector(deleteNote))

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
        
        defaults.set(notes, forKey: "savedArray")
        
        dismissVC()
    }
    
    @objc func deleteNote() {
        
        let ac = UIAlertController(title: "Delete note", message: "Are you sure?", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        ac.addAction(UIAlertAction(title: "Continue", style: .destructive, handler: confirmDeleteNote))
        present(ac, animated: true)
        
    }
    
    func confirmDeleteNote(action: UIAlertAction) {
        
        if notePath == -1 {
            dismissVC()
        } else {
            notes.remove(at: notePath)
            defaults.set(notes, forKey: "savedArray")
            dismissVC()
        }
        
    }
    
    func dismissVC() {
        self.navigationController?.popViewController(animated: true)
        self.dismiss(animated: true, completion: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

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
        navigationItem.rightBarButtonItem =  UIBarButtonItem(barButtonSystemItem: .trash, target: self, action: #selector(deleteNote))
        
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self, selector: #selector(adjustForKeyboard), name: Notification.Name.UIKeyboardWillHide, object: nil)
        notificationCenter.addObserver(self, selector: #selector(adjustForKeyboard), name: Notification.Name.UIKeyboardWillChangeFrame, object: nil)
        notificationCenter.addObserver(self, selector: #selector(keyboardIsVisible), name: Notification.Name.UIKeyboardWillShow, object: nil)
        notificationCenter.addObserver(self, selector: #selector(keyboardIsHidden), name: Notification.Name.UIKeyboardWillHide, object: nil)
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
    
    @objc func adjustForKeyboard(notification: Notification) {
        let userInfo = notification.userInfo!
        
        let keyboardScreenEndFrame = (userInfo[UIKeyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        let keyboardViewEndFrame = view.convert(keyboardScreenEndFrame, from: view.window)
        
        if notification.name == Notification.Name.UIKeyboardWillHide {
            noteText.contentInset = UIEdgeInsets.zero
        } else {
            noteText.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: keyboardViewEndFrame.height, right: 0)
        }
        
        noteText.scrollIndicatorInsets = noteText.contentInset
        
        let selectedRange = noteText.selectedRange
        noteText.scrollRangeToVisible(selectedRange)
    }
    
    @objc func keyboardIsVisible(notification: Notification) {
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(dismissKeyboard))
    }
    
    @objc func keyboardIsHidden(notification: Notification) {
        navigationItem.rightBarButtonItem =  UIBarButtonItem(barButtonSystemItem: .trash, target: self, action: #selector(deleteNote))
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

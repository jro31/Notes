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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let noteToLoad = selectedNote {
            noteText.text = noteToLoad
        } else {
            noteText.text = "This is a new note, homie"
        }

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

//
//  ViewController.swift
//  Notes
//
//  Created by Jethro Williams on 05/09/2018.
//  Copyright © 2018 Jethro Williams. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {
    
    var notes = [String]()
    let defaults = UserDefaults.standard

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Notes"
        
        notes = defaults.object(forKey: "savedArray") as? [String] ?? [String]()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .compose, target: self, action: #selector(addNewNote))

    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notes.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "noteCell", for: indexPath)
        cell.textLabel?.text = notes[indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "Detail") as? DetailViewController {
            vc.selectedNote = notes[indexPath.row]
            vc.notePath = indexPath.row
            vc.notes = notes
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    @objc func addNewNote() {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "Detail") as? DetailViewController {
            vc.notes = notes
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        viewDidLoad()
        tableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}


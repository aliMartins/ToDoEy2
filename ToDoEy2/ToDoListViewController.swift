//
//  ViewController.swift
//  ToDoEy2
//
//  Created by Alieksiei martins on 08/03/2018.
//  Copyright © 2018 Alieksiei martins. All rights reserved.
//

import UIKit

class ToDoListViewController: UITableViewController {

    var itemArray = ["Find Harry","Buy Wand", "Kill Demogorgon"]
       let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        
        if let itens = defaults.array(forKey: "TodoListArray") as? [String] {
            itemArray = itens
        }
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    //MARK - Table View Datasources Methods
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        cell.textLabel?.text = itemArray[indexPath.row]
        return cell
    }
    
    //MARK - TableView Delegates and Methods
    
    // detects which row is selected, adds a check mark and accessory
 
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //print(itemArray[indexPath.row])
        
        if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark {
            tableView.cellForRow(at: indexPath)?.accessoryType = .none
        } else {
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    //MARK - add new itens

    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add a New ToDo Item", message: "", preferredStyle: .alert)
        alert.addTextField { (newtext) in
            newtext.placeholder = "Create New Item"
            textField = newtext
        }
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            //if let newItemText = alert.textFields?.first?.text {
            self.itemArray.append(textField.text!)
            defaults.set(self.itemArray, forKey: "TodoListArray"
            self.tableView.reloadData()
            //}
        }
        
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
        
    }
    
}


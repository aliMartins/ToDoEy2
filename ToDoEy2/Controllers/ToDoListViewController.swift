//
//  ViewController.swift
//  ToDoEy2
//
//  Created by Alieksiei martins on 08/03/2018.
//  Copyright © 2018 Alieksiei martins. All rights reserved.
//

import UIKit

class ToDoListViewController: UITableViewController {

    var itemArray = [Item]()
       let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        let newItem = Item()
        newItem.title = "Find Mike"
        itemArray.append(newItem)

        let newItem2 = Item()
        newItem2.title = "Buy Wand"
        itemArray.append(newItem2)
        
        let newItem3 = Item()
        newItem3.title = "Kill Demogorgon"
        itemArray.append(newItem3)
        
        if let itens = defaults.array(forKey: "TodoListArray") as? [Item] {
            itemArray = itens
        }
    
    }

    //MARK - Table View Datasources Methods
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        cell.textLabel?.text = itemArray[indexPath.row].title
       
        cell.accessoryType = itemArray[indexPath.row].done ? .checkmark : .none
        
        /*
        if  itemArray[indexPath.row].done == true {
            cell.accessoryType = .checkmark
        } else {
            cell.accessoryType = .none
        }*/
        
        return cell
    }
    
    //MARK - TableView Delegates and Methods
    
    // detects which row is selected, adds a check mark and accessory
 
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //print(itemArray[indexPath.row])
        
        itemArray[indexPath.row].done = !itemArray[indexPath.row].done

        tableView.deselectRow(at: indexPath, animated: true)
        tableView.reloadData()
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
            
            let newItem = Item()
            newItem.title = textField.text!
            self.itemArray.append(newItem)
            self.defaults.set(self.itemArray, forKey: "TodoListArray")
            self.tableView.reloadData()
            
        }
        
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
        
    }
    
}


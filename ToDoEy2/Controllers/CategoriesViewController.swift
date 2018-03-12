//
//  CategoriesViewController.swift
//  ToDoEy2
//
//  Created by Alieksiei martins on 12/03/2018.
//  Copyright © 2018 Alieksiei martins. All rights reserved.
//

import UIKit
import CoreData

class CategoriesViewController: UITableViewController {
    
    var categoryArray = [Category]()
    let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Categories.plist")
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    override func viewDidLoad() {
        super.viewDidLoad()
        print(dataFilePath)
        loadCategories()

    }

    // MARK: categories datasources methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categoryArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath)
        cell.textLabel?.text = categoryArray[indexPath.row].name
        return cell
    }
    
    
    @IBAction func newCategoryButPresesd(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        let alert = UIAlertController (title: "Add a New Category", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add Category", style: .default) { (action) in
            
            let newCategory = Category(context: self.context)
            newCategory.name = textField.text
            self.categoryArray.append(newCategory)
            self.saveCategory()
            self.tableView.reloadData()
            
        }
        
        alert.addTextField { (newText) in
            newText.placeholder = "Create Nw Category"
            textField = newText
        }
        
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
        
    }
    
    //MARK: - model manipulation methods
    
    func saveCategory() {
    
    do {
    try context.save()
    } catch {
    }
    
    tableView.reloadData()
        
    }
    
    func loadCategories (with request:NSFetchRequest<Category> = Category.fetchRequest()) {
        
        do {
            categoryArray = try context.fetch(request)
        } catch {
            
        }
        tableView.reloadData()
        
    }
    
}

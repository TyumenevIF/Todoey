//
//  ToDoListViewController.swift
//  Todoey
//
//  Created by Ilyas Tyumenev on 30.05.2023.
//

import UIKit
import CoreData

class ToDoListViewController: UIViewController {
    
    @IBOutlet weak var table: UITableView!
    
    var itemArray = [Item]()
    let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?
        .appendingPathComponent("Items.plist")
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()

        table.dataSource = self
        table.delegate = self
        setNavigationBarColor(textColor: .white, backgroundColor: .systemBlue)
        print(dataFilePath)
        
//        loadItems()
    }
    
    func setNavigationBarColor(textColor: UIColor, backgroundColor: UIColor) {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.titleTextAttributes = [.foregroundColor: textColor]
        appearance.backgroundColor = backgroundColor
        navigationItem.standardAppearance = appearance
        navigationItem.scrollEdgeAppearance = appearance
    }
    
    // MARK: - Add New Items
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add New Todoey Item", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            let newItem = Item(context: self.context)
            newItem.title = textField.text!
            newItem.done = false
            self.itemArray.append(newItem)
            self.saveItems()
        }
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create new item"
            textField = alertTextField
        }
        
        alert.addAction(action)
        present(alert, animated: true)
    }
    
    // MARK: - Model Manupulation Methods
    func saveItems() {
        let encoder = PropertyListEncoder()
        
        do {
            try context.save()
        } catch {
            print("Error saving context \(error)")
        }
        
        self.table.reloadData()
    }
    
//    func loadItems() {
//        let decoder = PropertyListDecoder()
//
//        do {
//            let data = try Data(contentsOf: dataFilePath!)
//            itemArray = try! decoder.decode([Item].self, from: data)
//        } catch {
//            print("Error decoding item array, \(error)")
//        }
//    }
}

// MARK: - UITableViewDataSource
extension ToDoListViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        
        let item = itemArray[indexPath.row]
        cell.textLabel?.text = item.title
        cell.accessoryType = item.done ? .checkmark : .none
        return cell
    }
}

// MARK: - UITableViewDelegate
extension ToDoListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        itemArray[indexPath.row].done = !itemArray[indexPath.row].done
        saveItems()        
        tableView.deselectRow(at: indexPath, animated: true)
    }
}


//
//  ToDoListViewController.swift
//  Todoey
//
//  Created by Ilyas Tyumenev on 30.05.2023.
//

import UIKit

class ToDoListViewController: UIViewController {
    
    @IBOutlet weak var table: UITableView!
    
    let itemArray = ["Find Mike", "Buy Eggos", "Destroy Demogogon"]
    
    override func viewDidLoad() {
        super.viewDidLoad()        
        table.dataSource = self
        table.delegate = self
    }
}

extension ToDoListViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        cell.textLabel?.text = itemArray[indexPath.row]
        return cell
    }
}

extension ToDoListViewController: UITableViewDelegate {

}


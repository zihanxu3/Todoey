//
//  ViewController.swift
//  Todoey
//
//  Created by Hunter Xu on 6/25/19.
//  Copyright © 2019 Hunter Xu. All rights reserved.
//

import UIKit
import CoreData

//EEEEEE inherits from class UITableViewController so that we don't have to create new UIVIEWS and conform to UITableView DataSource / Delegate Protocols again as we did in <i\> flashchat

class TodoViewController: UITableViewController {
//    let defaults = UserDefaults.standard; //WOULD NOT WORK BECAUSE OF LIMITED DATA TYPE IT ACCEPTS
    
    var itemsArray = [Item]();
    
    //Tap into access into Appdelegate
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext;
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask));
        
//        if let items = defaults.array(forKey: "ToDoListArray") as? [Item] {
//            itemsArray = items;
//        }
        loadItemsFromLocal();
    }
    
    //MARK - Table View Data Source Methods
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemsArray.count;
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath);
        let currentItem = itemsArray[indexPath.row];
        cell.textLabel?.text = currentItem.title;
        
        //Ternary Operator => value = [condition] ? [value if true] : [value if false]
        cell.accessoryType = currentItem.done ? .checkmark : .none;
        return cell
    }
    
    
    //TODO: Declare didSelectRowAt here
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        itemsArray[indexPath.row].done = !itemsArray[indexPath.row].done;
        saveDataToLocal();
        //Everytime we click an item make sure we update the array / display (i.e. trigger the methods properly)
        tableView.reloadData();
        //Make it flashes while you click it
        tableView.deselectRow(at: indexPath, animated: true);
    }
    
    
    
    //TODO: Declare configureTableView here:
    func configureTableView() {
        tableView.rowHeight = UITableView.automaticDimension;
        tableView.estimatedRowHeight = 120.0;
    }
    
    //MARK - Add new items
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        var textField = UITextField();
        let alert = UIAlertController(title: "Add New Todoey Item", message: "", preferredStyle: .alert);
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            //Tap into access into Appdelegate
            let newItem = Item(context: self.context);
            newItem.title = textField.text ?? "New Item";
            newItem.done = false;
            self.itemsArray.append(newItem);
            //gets set in plist
            self.saveDataToLocal();
            self.tableView.reloadData();
        }
        alert.addAction(action);
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create new items";
            textField = alertTextField;
        }
        present(alert, animated: true, completion: nil);
    }
    
    //MARK - Model Manipulation Methods
    func saveDataToLocal() {
        do {
            try context.save();
        } catch {
            print("Error saving data to local: \(error.localizedDescription)")
        }
    }
    
    func loadItemsFromLocal() {
        let request : NSFetchRequest<Item> = Item.fetchRequest();
        do {
            itemsArray = try context.fetch(request);
        } catch {
            print("Error loading data from local: \(error.localizedDescription)")
        }
    }
}


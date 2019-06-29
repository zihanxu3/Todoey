//
//  ViewController.swift
//  Todoey
//
//  Created by Hunter Xu on 6/25/19.
//  Copyright © 2019 Hunter Xu. All rights reserved.
//

import UIKit

//EEEEEE inherits from class UITableViewController so that we don't have to create new UIVIEWS and conform to UITableView DataSource / Delegate Protocols again as we did in <i\> flashchat

class TodoViewController: UITableViewController {
//    let defaults = UserDefaults.standard; //WOULD NOT WORK BECAUSE OF LIMITED DATA TYPE IT ACCEPTS
    
    var itemsArray = [Item]();
    
    //Creating our customized plist path (NSCoder)
    let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Items.plist");
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //TELL TODOEY WHAT THE USER HAS STORED IN THE PLIST
        var newItem = Item();
        newItem.itemValue = "First";
        itemsArray.append(newItem)
        tableView.reloadData();
        
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
        cell.textLabel?.text = currentItem.itemValue;
        
        //Ternary Operator => value = [condition] ? [value if true] : [value if false]
        cell.accessoryType = currentItem.itemStatus ? .checkmark : .none;
        return cell
    }
    
    
    //TODO: Declare didSelectRowAt here
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        itemsArray[indexPath.row].itemStatus = !itemsArray[indexPath.row].itemStatus;
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
            var newItem = Item();
            newItem.itemValue = textField.text ?? "New Item";
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
        let encoder = PropertyListEncoder();
        do {
            let data = try encoder.encode(itemsArray);
            try data.write(to: dataFilePath!);
        } catch {
            print("Error encoding into Plist \(error.localizedDescription)");
        }
    }
    
    func loadItemsFromLocal() {
        if let data = try? Data(contentsOf: dataFilePath!) {
            let decoder = PropertyListDecoder()
            do {
                itemsArray = try decoder.decode([Item].self, from: data)
            } catch {
                print("Error decoding the Plist\(error.localizedDescription)")
            }
        }
    }
}


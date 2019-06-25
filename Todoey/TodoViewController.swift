//
//  ViewController.swift
//  Todoey
//
//  Created by Hunter Xu on 6/25/19.
//  Copyright © 2019 Hunter Xu. All rights reserved.
//

import UIKit

class TodoViewController: UITableViewController {
    let itemsArray: [String] = ["bien", "très bien", "comme ci comme ça", "pas mal", "mal"]
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    //MARK - Table View Data Source Methods
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemsArray.count;
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath);
        cell.textLabel?.text = itemsArray[indexPath.row];
        
        return cell
    }
    
    //TODO: Declare didSelectRowAt here
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //print(itemsArray[indexPath.row])
        //Make it flashes while you click it
        if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark {
            tableView.cellForRow(at: indexPath)?.accessoryType = .none;
        } else {
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark;
        }
        tableView.deselectRow(at: indexPath, animated: true);
    }
    
    
    
    //TODO: Declare configureTableView here:
    func configureTableView() {
        tableView.rowHeight = UITableView.automaticDimension;
        tableView.estimatedRowHeight = 120.0;
    }
}


//
//  ViewController.swift
//  Party Planner
//
//  Created by John Gallaugher on 3/12/18.
//  Copyright © 2018 John Gallaugher. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var editBarbutton: UIBarButtonItem!
    @IBOutlet weak var addBarButton: UIBarButtonItem!
        
    var partyItemArray = [PartyItemStruct]()
    
    var peopleResponsible = [String]()
    var partyItems = ["Potato Chips",
                      "Tortilla Chips",
                      "Salsa",
                      "Chili",
                      "Punch",
                      "Sudsy Beverages",
                      "Brownies",
                      "Cupcakes",
                      "Fruit salad",
                      "Ribs",
                      "Corn bread",
                      "Macaroni Salad",
                      "Sandwich Rolls",
                      "Roast Beef",
                      "Ham",
                      "Cheese",
                      "Mayo",
                      "Mustard",
                      "Hummus",
                      "Baby carrots",
                      "Celery",
                      "Veggie Dip",
                      "Napkins",
                      "Plates & Bowls",
                      "Forks and Knives",
                      "Cups"]

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        for _ in partyItems {
            peopleResponsible.append("")
        }
        
        for partyItem in partyItems {
            partyItemArray.append(PartyItemStruct(name: partyItem, personResponsible: ""))
        }
        print("partyItemArray count = \(partyItemArray.count)")
        
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowItemDetail" {
            let destination = segue.destination as! ItemDetailViewController
            let selectedIndexPath = tableView.indexPathForSelectedRow!
            destination.partyItem
                = partyItemArray[selectedIndexPath.row]
        } else {
            if let selectedPath = tableView.indexPathForSelectedRow {
                tableView.deselectRow(at: selectedPath, animated: true)
            }
        }
    }
    
    @IBAction func unwindFromItemDetail(segue: UIStoryboardSegue) {
        let source = segue.source as! ItemDetailViewController
        if let selectedIndexPath = tableView.indexPathForSelectedRow {
            partyItemArray[selectedIndexPath.row] = source.partyItem
            tableView.reloadRows(at: [selectedIndexPath], with: .automatic)
        } else {
            let newIndexPath = IndexPath(row: partyItems.count, section: 0)
            partyItemArray.append(source.partyItem)
            tableView.insertRows(at: [newIndexPath], with: .bottom)
            tableView.scrollToRow(at: newIndexPath, at: .bottom, animated: true)
        }
    }
    
    
    @IBAction func editButtonPressed(_ sender: UIBarButtonItem) {
        if tableView.isEditing { // am in editing mode, so get out of editing
            tableView.setEditing(false, animated: true)
            editBarbutton.title = "Edit"
            addBarButton.isEnabled = true
        } else { // was not in editing mode, so get in editing mode
            tableView.setEditing(true, animated: true)
            editBarbutton.title = "Done"
            addBarButton.isEnabled = false
        }
    }
}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return partyItemArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = partyItemArray[indexPath.row].name
        cell.detailTextLabel?.text = partyItemArray[indexPath.row].personResponsible
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            partyItemArray.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let itemToMove = partyItemArray[sourceIndexPath.row]
        partyItemArray.remove(at: sourceIndexPath.row)
        partyItemArray.insert(itemToMove, at: destinationIndexPath.row)
    }
    
}


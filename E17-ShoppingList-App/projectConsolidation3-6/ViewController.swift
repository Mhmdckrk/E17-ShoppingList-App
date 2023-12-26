//
//  ViewController.swift
//  projectConsolidation3-6
//
//  Created by Mahmud CIKRIK on 6.10.2023.
//

import UIKit

class ViewController: UITableViewController {
    
    var shoppingList = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "My Shopping List"
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addToList))
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(resetList))
        
        // resette are you sure alerti eklenebilir
        // tek ürünü silmek üstüne basılı tutunca sorsun
        // tıklayınca yazıyı düzeltmek eklenebilir.

        
        startShopping()


    }
    
    func startShopping () {
        
        shoppingList.removeAll(keepingCapacity: true)
        tableView.reloadData()
        
    }
    
    @objc func resetList () {
        
        shoppingList.removeAll(keepingCapacity: true)
        tableView.reloadData()
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        shoppingList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Item", for: indexPath)
        cell.textLabel?.text = shoppingList[indexPath.row]
        return cell
    }
    
    @objc func addToList() {
        
        let ac = UIAlertController(title: "Enter Item Name", message: "Please Enter the item name to add list", preferredStyle: .alert)
        ac.addTextField()
        
        let addToListAction = UIAlertAction(title: "Add", style: .default ) {
            [weak self, weak ac] _ in
            guard let addedItem = ac?.textFields?[0].text else {return}
            self?.addItem(addedItem)
            
        }
        
        ac.addAction(addToListAction)
        present(ac, animated: true)
        
    }
    
    func addItem (_ addedItem: String) {
        
        let lowerCasedItem = addedItem.lowercased()
        
        let errorTitle: String
        let errorMessage: String
        
        if isReal(item: lowerCasedItem) {
            shoppingList.insert(lowerCasedItem, at: 0)
            let indexPath = IndexPath(row: 0, section: 0)
            tableView.insertRows(at: [indexPath], with: .automatic)
    
        } else {
            
            errorTitle = "Incorrect Spell"
            errorMessage = "Please rewrite item"
            showErrorMessage(title: errorTitle, message:errorMessage)
        }
        
    }
    
    func showErrorMessage (title: String, message: String) {
        
        let ac = UIAlertController(title: title, message: message, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default))
        present(ac, animated: true)
        
    }

    func isReal(item: String) -> Bool {
        
        let checker = UITextChecker()
        let range = NSRange(location: 0, length: item.utf16.count)
        let misspelledRange = checker.rangeOfMisspelledWord(in: item, range: range, startingAt: 0, wrap: false, language: "en")
        return misspelledRange.location == NSNotFound
        
    }

}


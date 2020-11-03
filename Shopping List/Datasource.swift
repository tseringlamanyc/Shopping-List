//
//  Datasource.swift
//  Shopping List
//
//  Created by Tsering Lama on 11/2/20.
//

import UIKit

// conforms to UITableViewDataSource
class DataSource: UITableViewDiffableDataSource<Category, Item> {
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        if Category.allCases[section] == .shoppingcart {
            return "🛒" + Category.allCases[section].rawValue
        } else {
            return Category.allCases[section].rawValue
        }
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // current snapshot
            var snapshot = self.snapshot()
            
            // get item using the item identifier
            if let item = itemIdentifier(for: indexPath) {
                // delete the item from the snapshot
                snapshot.deleteItems([item])
                
                // apply
                apply(snapshot, animatingDifferences: true)
            }
        }
    }
}

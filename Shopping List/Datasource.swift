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
            if let item = itemIdentifier(for: indexPath) { // from diffable datasource
                // delete the item from the snapshot
                snapshot.deleteItems([item])
                
                // apply
                apply(snapshot, animatingDifferences: true)
            }
        }
    }
    
    //MARK:- REORDER
    // 1)
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    // 2)
    override func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        // get the source item
        guard let sourceItem = itemIdentifier(for: sourceIndexPath) else {return}
        
        // case 1) - moving to self
        guard sourceIndexPath != destinationIndexPath else {return}
        
        // get the destination item
        let destinationItem = itemIdentifier(for: destinationIndexPath)
        
        // current snapshot
        var snapshot = self.snapshot()
        
        // case 2 and 3) - before or after destination
        if let destinationItem = destinationItem {
            // get source and destination index
            if let sourceIndex = snapshot.indexOfItem(sourceItem), let destinationIndex = snapshot.indexOfItem(destinationItem) {
                
                // what order should we be inserting the source item
                let isAfter = destinationIndex > sourceIndex && snapshot.sectionIdentifier(containingItem: sourceItem) == snapshot.sectionIdentifier(containingItem: destinationItem)
                
                // first delete the source item from the snapshot
                snapshot.deleteItems([sourceItem])
                
                if isAfter {
                    snapshot.insertItems([sourceItem], afterItem: destinationItem)
                } else {
                    snapshot.insertItems([sourceItem], beforeItem: destinationItem)
                }
            }
        } else {
            // case 4) - no destination
            let destinationSection = snapshot.sectionIdentifiers[destinationIndexPath.section]
            
            // delete the source item before reinserting it
            snapshot.deleteItems([sourceItem])
            
            // append the source item at the new section
            snapshot.appendItems([sourceItem], toSection: destinationSection)
        }
        
        apply(snapshot, animatingDifferences: false)
    }
}

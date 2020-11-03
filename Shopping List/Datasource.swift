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
}

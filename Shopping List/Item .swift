//
//  Item .swift
//  Shopping List
//
//  Created by Tsering Lama on 11/2/20.
//

import Foundation

struct Item: Hashable {
    let name: String
    let price: Double
    let category: Category
    let identifier = UUID()
    
    // implement hashable property for Item
    func hash(hasher: inout Hasher) {
        hasher.combine(identifier)
    }
    
    // create a test data
    static func testData() -> [Item] {
        return [
            Item(name: "Nike Shoes", price: 32, category: .running),
            Item(name: "Sweats", price: 10, category: .running),
            Item(name: "Vitamin", price: 10, category: .health),
            Item(name: "Milk", price: 40, category: .health),
            Item(name: "Coke", price: 98.4, category: .health),
            Item(name: "Books", price: 10000, category: .education),
            Item(name: "Stocks", price: 59.1, category: .money),
            Item(name: "Skins", price: 15, category: .league),
            Item(name: "LP", price: 0.00, category: .league)
        ]
    }
}

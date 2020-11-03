//
//  ViewController.swift
//  Shopping List
//
//  Created by Tsering Lama on 11/2/20.
//

import UIKit

class ItemFeedVC: UIViewController {
    
    private var tableView: UITableView!
    
    private var dataSource: DataSource!  // subclass we created
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        configureDataSource()
        configureNavBar()
    }
    
    private func configureNavBar() {
        navigationItem.title = "Shopping Cart"
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Edit", style: .plain, target: self, action: #selector(toggleEditState))
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(presentAddVC))
    }

    private func configureTableView() {
        tableView = UITableView(frame: view.bounds, style: .insetGrouped)
        tableView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.backgroundColor = .systemGroupedBackground
        view.addSubview(tableView)
    }
    
    private func configureDataSource() {
        dataSource = DataSource(tableView: tableView, cellProvider: { (tableView, indexPath, item) -> UITableViewCell? in
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
            let formattedPrice = String(format: "%.2f", item.price)
            cell.textLabel?.text = "\(item.name)\nPrice: $\(formattedPrice)"
            cell.textLabel?.numberOfLines = 0
            return cell
        })
        
        dataSource.defaultRowAnimation = .fade
        
        // set up initial snapshot
        var snapshot = NSDiffableDataSourceSnapshot<Category, Item>()
        
        // populate snapshot with sections and items for each section
        for category in Category.allCases {
            // filter the data for a particular category
            
            let items = Item.testData().filter {$0.category == category}
            snapshot.appendSections([category]) // add section to tableview
            snapshot.appendItems(items)
        }
        
        dataSource.apply(snapshot, animatingDifferences: false)
    }
    
    @objc
    private func toggleEditState() {
        tableView.setEditing(!tableView.isEditing, animated: true)
        navigationItem.leftBarButtonItem?.title = tableView.isEditing ? "Done" : "Edit"
    }
    
    @objc
    private func presentAddVC() {
        guard let addItemVC = storyboard?.instantiateViewController(identifier: "AddItemVC") as? AddItemVC else {
            return
        }
        addItemVC.delegate = self
        present(addItemVC, animated: true)
    }

}

extension ItemFeedVC: AddItemVCDelegate {
    func addNewItem(VC: AddItemVC, item: Item) {
        var snapshot = dataSource.snapshot()
        snapshot.appendItems([item], toSection: item.category)
        dataSource.apply(snapshot, animatingDifferences: false)
    }
}

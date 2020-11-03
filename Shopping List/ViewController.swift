//
//  ViewController.swift
//  Shopping List
//
//  Created by Tsering Lama on 11/2/20.
//

import UIKit

class ViewController: UIViewController {
    
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
            cell.textLabel?.text = "\(item.name)"
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
        
        dataSource.apply(snapshot, animatingDifferences: true)
    }
    
    @objc
    private func toggleEditState() {
        
    }
    
    @objc
    private func presentAddVC() {
        
    }

}


//
//  ItemListViewController.swift
//  TDDRecipe
//
//  Created by junwoo on 2017. 9. 14..
//  Copyright © 2017년 junwoo. All rights reserved.
//

import UIKit

class ItemListViewController: UIViewController {
  
  var didSetupConstraints = false
  
  var tableView: UITableView = {
    let tabelView = UITableView()
    return tabelView
  }()
  var dataProvider: (UITableViewDataSource & UITableViewDelegate & ItemManagerSettable) = {
    let dataProvider = ItemListDataProvider()
    return dataProvider
  }()
  var addButton: UIBarButtonItem = {
    let item = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.add, target: nil, action: nil)
    return item
  }()
  let itemManager = ItemManager()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    tableView.register(ItemCell.self, forCellReuseIdentifier: "ItemCell")
    tableView.dataSource = dataProvider
    tableView.delegate = dataProvider
    view.addSubview(tableView)
    
    self.navigationItem.rightBarButtonItem = addButton
    addButton.target = self
    addButton.action = #selector(addItem)
    dataProvider.itemManager = itemManager
    
    NotificationCenter.default.addObserver(self, selector: #selector(showDetails(sender:)), name: NSNotification.Name("ItemSelectedNotification"), object: nil)
    
    view.setNeedsUpdateConstraints()
  }
  
  override func updateViewConstraints() {
    if !didSetupConstraints {
      
      tableView.snp.makeConstraints { make in
        make.edges.equalTo(self.view)
      }
      
      didSetupConstraints = true
    }
    super.updateViewConstraints()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    
    tableView.reloadData()
  }
  
  func addItem() {
    let inputViewController = InputViewController()
    inputViewController.itemManager = self.itemManager
    self.present(inputViewController, animated: true, completion: nil)
  }
  
  func showDetails(sender: NSNotification) {
    guard let index = sender.userInfo!["index"] as? Int else { fatalError() }
    
    let nextViewController = DetailViewController()
    nextViewController.itemInfo = (itemManager, index)
    navigationController?.pushViewController(nextViewController, animated: true)
  }
  
}

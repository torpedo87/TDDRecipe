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
  var dataProvider: (UITableViewDataSource & UITableViewDelegate) = {
    let dataProvider = ItemListDataProvider()
    return dataProvider
  }()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    tableView.register(ItemCell.self, forCellReuseIdentifier: "ItemCell")
    tableView.dataSource = dataProvider
    tableView.delegate = dataProvider
    view.addSubview(tableView)
    
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
}

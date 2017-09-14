//
//  ItemListViewController.swift
//  TDDRecipe
//
//  Created by junwoo on 2017. 9. 14..
//  Copyright © 2017년 junwoo. All rights reserved.
//

import UIKit

class ItemListViewController: UIViewController {
  var tableView: UITableView!
  var dataProvider: (UITableViewDataSource & UITableViewDelegate)!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    tableView = UITableView()
    dataProvider = ItemListDataProvider()
    
    tableView.dataSource = dataProvider
    tableView.delegate = dataProvider
    
    self.view.addSubview(tableView)
    
    tableView.snp.makeConstraints { (make) -> Void in
      make.edges.equalTo(self.view)
    }
  }
}

//
//  ItemCellTests.swift
//  TDDRecipe
//
//  Created by junwoo on 2017. 9. 15..
//  Copyright © 2017년 junwoo. All rights reserved.
//

import XCTest
@testable import TDDRecipe

class ItemCellTests: XCTestCase {
  
  override func setUp() {
    super.setUp()
    // Put setup code here. This method is called before the invocation of each test method in the class.
  }
  
  override func tearDown() {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    super.tearDown()
  }
  
  //titlelabel
  func test_HasNameLabel() {
    let controller = ItemListViewController()
    _ = controller.view
    
    let tableView = controller.tableView
    let dataSource = FakeDataSource()
    tableView?.dataSource = dataSource
    
    let cell = tableView?.dequeueReusableCell(withIdentifier: "ItemCell", for: IndexPath(row: 0, section: 0)) as! ItemCell
    
    XCTAssertNotNil(cell.titleLabel)
  }
}

extension ItemCellTests {
  
  class FakeDataSource: NSObject, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      return UITableViewCell()
    }
  }
}

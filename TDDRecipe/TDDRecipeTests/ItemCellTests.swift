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
  
  var tableView: UITableView!
  let dataSource = FakeDataSource()
  var cell: ItemCell!
  
  override func setUp() {
    super.setUp()
    
    let controller = ItemListViewController()
    _ = controller.view
    
    tableView = controller.tableView
    tableView.dataSource = dataSource
    
    //dequeue 호출
    cell = tableView.dequeueReusableCell(withIdentifier: "ItemCell", for: IndexPath(row: 0, section: 0)) as! ItemCell
  }
  
  override func tearDown() {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    super.tearDown()
  }
  
  //titlelabel
  func test_HasNameLabel() {
    
    XCTAssertNotNil(cell.titleLabel)
  }
  
  //locationlabel
  func test_HasLocationLabel() {
    
    XCTAssertNotNil(cell.locationLabel)
  }
  
  //datelabel
  func test_HasDateLabel() {
    XCTAssertNotNil(cell.dateLabel)
  }
  
  //label text
  func test_ConfigCell_SetsLabelTexts() {
    let location = Location(name: "Bar")
    let item = ToDoItem(title: "Foo", itemDescription: nil, timestamp: 1456150025, location: location)
    cell.configCell(with: item)
    
    XCTAssertEqual(cell.titleLabel.text, "Foo")
    XCTAssertEqual(cell.locationLabel.text, "Bar")
    XCTAssertEqual(cell.dateLabel.text, "02/22/2016")
  }
  
  //체크된 item의 configcell (title 줄긋기, location nil, date nil)
  func test_Title_WhenItemIsChecked_IsStrokeThrough() {
    let location = Location(name: "Bar")
    let item = ToDoItem(title: "Foo", itemDescription: nil, timestamp: 1456150025, location: location)
    
    cell.configCell(with: item, checked: true)
    
    //줄그어진 string
    let attributedString = NSAttributedString(string: "Foo", attributes: [NSStrikethroughStyleAttributeName: NSUnderlineStyle.styleSingle.rawValue])
    
    XCTAssertEqual(cell.titleLabel.attributedText, attributedString)
    XCTAssertNil(cell.locationLabel.text)
    XCTAssertNil(cell.dateLabel.text)
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

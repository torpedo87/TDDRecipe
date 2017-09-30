//
//  ItemListDataProviderTests.swift
//  TDDRecipe
//
//  Created by junwoo on 2017. 9. 14..
//  Copyright © 2017년 junwoo. All rights reserved.
//

import XCTest
@testable import TDDRecipe

class ItemListDataProviderTests: XCTestCase {
  
  var sut: ItemListDataProvider!
  var tableView: UITableView!
  var controller: ItemListViewController!

  
  override func setUp() {
    super.setUp()
    sut = ItemListDataProvider()
    sut.itemManager = ItemManager()
    
    controller = ItemListViewController()
    
    //viewdidload 호출
    _ = controller.view
    
    tableView = controller.tableView
    tableView.dataSource = sut
    tableView.delegate = sut
  }
  
  override func tearDown() {
    sut.itemManager?.removeAll()
    
    super.tearDown()
  }
  
  //numberofsections = 2
  func test_NumberOfSections_IsTwo() {
    
    let numberOfSections = tableView.numberOfSections
    XCTAssertEqual(numberOfSections, 2)
  }
  
  //numberofrowsinfirstsection = itemmanager.todocount
  func test_NumberOfRows_InFirstSection_IsToDoCount() {
    
    sut.itemManager?.add(ToDoItem(title: "Foo"))
    XCTAssertEqual(tableView.numberOfRows(inSection: 0), 1)
    
    sut.itemManager?.add(ToDoItem(title: "Bar"))
    //tableview 변했다고 알려주어야한다
    tableView.reloadData()
    XCTAssertEqual(tableView.numberOfRows(inSection: 0), 2)
  }
  
  //numberofrowsinsecondsection = donecount
  func test_NumberOfRows_InSecondSection_IsDoneCount() {
    sut.itemManager?.add(ToDoItem(title: "Foo"))
    sut.itemManager?.add(ToDoItem(title: "Bar"))
    
    sut.itemManager?.checkItem(at: 0)
    XCTAssertEqual(tableView.numberOfRows(inSection: 1), 1)
    
    sut.itemManager?.checkItem(at: 0)
    tableView.reloadData()
    XCTAssertEqual(tableView.numberOfRows(inSection: 1), 2)
  }
  
  //cellforrow return customcell
  func test_CellForRow_ReturnsItemCell() {
    sut.itemManager?.add(ToDoItem(title: "Foo"))
    tableView.reloadData()
    
    let cell = tableView.cellForRow(at: IndexPath(row: 0, section: 0))
    XCTAssertNotNil(cell)
    XCTAssertTrue(cell is ItemCell)
  }
  
  //dequeuecell
  func test_CellForRow_DequeuesCellFromTableView() {
    let mockTableView = MockTableView.mockTableView(withDataSource: sut)
    
    sut.itemManager?.add(ToDoItem(title: "Foo"))
    mockTableView.reloadData()
    
    //cellforrowat 호출
    _ = mockTableView.cellForRow(at: IndexPath(row: 0, section: 0))
    
    XCTAssertTrue(mockTableView.cellGotDequeued)
  }
  
  //configcell in section1
  func test_CellForRow_CallsConfigCell() {
    let mockTableView = MockTableView.mockTableView(withDataSource: sut)
    let item = ToDoItem(title: "Foo")
    sut.itemManager?.add(item)
    mockTableView.reloadData()
    
    //cellforrowat 호출
    let cell = mockTableView.cellForRow(at: IndexPath(row: 0, section: 0)) as! MockItemCell
    
    //XCTAssertTrue(cell.configCellGotCalled)
    XCTAssertEqual(cell.catchedItem, item)
  }
  
  //configcell in section2
  func test_CellForRow_InSectionTwo_CallsConfigCellWithDoneItem() {
    
    let mockTableView = MockTableView.mockTableView(withDataSource: sut)
    
    sut.itemManager?.add(ToDoItem(title: "Foo"))
    let second = ToDoItem(title: "Bar")
    sut.itemManager?.add(second)
    sut.itemManager?.checkItem(at: 1)
    mockTableView.reloadData()
    
    let cell = mockTableView.cellForRow(at: IndexPath(row: 0, section: 1)) as! MockItemCell
    
    XCTAssertEqual(cell.catchedItem, second)
    
  }
  
  //deletebutton in section1
  func test_DeleteButton_InFirstSection_ShowsTitleCheck() {
    let deleteButtonTitle = tableView.delegate?.tableView?(tableView, titleForDeleteConfirmationButtonForRowAt: IndexPath(row: 0, section: 0))
    
    XCTAssertEqual(deleteButtonTitle, "Check")
  }
  
  func test_DeleteButton_InSecondSection_ShowsTitleUUncheck() {
    let deleteButtonTitle = tableView.delegate?.tableView?(tableView, titleForDeleteConfirmationButtonForRowAt: IndexPath(row: 0, section: 1))
    
    XCTAssertEqual(deleteButtonTitle, "Uncheck")
  }
  
  //check event
  func test_CheckingAnItem_ChecksItInTheItemManager() {
    sut.itemManager?.add(ToDoItem(title: "Foo"))
    
    //check 시뮬레이션
    tableView.dataSource?.tableView?(tableView, commit: .delete, forRowAt: IndexPath(row: 0, section: 0))
    
    XCTAssertEqual(sut.itemManager?.toDoCount, 0)
    XCTAssertEqual(sut.itemManager?.doneCount, 1)
    XCTAssertEqual(tableView.numberOfRows(inSection: 0), 0)
    XCTAssertEqual(tableView.numberOfRows(inSection: 1), 1)
    
  }
  
  //uncheck event
  func test_UncheckingAnItem_UncheckItInTheItemManager() {
    sut.itemManager?.add(ToDoItem(title: "First"))
    sut.itemManager?.checkItem(at: 0)
    tableView.reloadData()
    
    //check 시뮬레이션
    tableView.dataSource?.tableView?(tableView, commit: .delete, forRowAt: IndexPath(row: 0, section: 1))
    
    XCTAssertEqual(sut.itemManager?.toDoCount, 1)
    XCTAssertEqual(sut.itemManager?.doneCount, 0)
    XCTAssertEqual(tableView.numberOfRows(inSection: 0), 1)
    XCTAssertEqual(tableView.numberOfRows(inSection: 1), 0)
  }
  
  //notification sender
  func test_SelectingACell_SendsNotification() {
    let item = ToDoItem(title: "First")
    sut.itemManager?.add(item)
    
    expectation(forNotification: "ItemSelectedNotification", object: nil) { (notification) -> Bool in
      guard let index = notification.userInfo?["index"] as? Int else {
        return false
      }
      return index == 0
      
    }
    
    tableView.delegate?.tableView!(tableView, didSelectRowAt: IndexPath(row: 0, section: 0))
    waitForExpectations(timeout: 3, handler: nil)
  }
}


extension ItemListDataProviderTests {
  
  class MockTableView: UITableView {
    var cellGotDequeued = false
    
    override func dequeueReusableCell(withIdentifier identifier: String, for indexPath: IndexPath) -> UITableViewCell {
      
      cellGotDequeued = true
      return super.dequeueReusableCell(withIdentifier: identifier, for: indexPath)
    }
    
    class func mockTableView(withDataSource dataSource: UITableViewDataSource) -> MockTableView {
      
      let mockTableView = MockTableView(frame: CGRect(x: 0, y: 0, width: 320, height: 480), style: .plain)
      mockTableView.dataSource = dataSource
      mockTableView.register(MockItemCell.self, forCellReuseIdentifier: "ItemCell")
      
      return mockTableView
      
    }
  }
  
  class MockItemCell: ItemCell {
    //var configCellGotCalled = false
    var catchedItem: ToDoItem?
    
    override func configCell(with item: ToDoItem, checked: Bool = false) {
      //configCellGotCalled = true
      catchedItem = item
    }
  }
  
  
}

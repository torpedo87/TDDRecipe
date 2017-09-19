//
//  ItemListViewControllerTests.swift
//  TDDRecipe
//
//  Created by junwoo on 2017. 9. 14..
//  Copyright © 2017년 junwoo. All rights reserved.
//

import XCTest
@testable import TDDRecipe

class ItemListViewControllerTests: XCTestCase {
  
  var sut: ItemListViewController!
  
  override func setUp() {
    super.setUp()
    sut = ItemListViewController()
    // 간접적으로 viewDidLoad 호출하는 방법
    _ = sut.view
  }
  
  override func tearDown() {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    super.tearDown()
  }
  
  //tableview
  func test_TableViewIsNotNilAfterViewDidLoad() {
    
    XCTAssertNotNil(sut.tableView)
  }
  
  //datasource
  func test_LoadingView_SetsTableViewDataSource() {
    
    XCTAssertTrue(sut.tableView.dataSource is ItemListDataProvider)
  }
  
  //delegate
  func test_LoadingView_SetsTableViewDelegate() {
    XCTAssertTrue(sut.tableView.delegate is ItemListDataProvider)
  }
  
  //datasource 랑 delegate가 같은지
  func test_LoadingView_SetsDataSourceAndDelegateToSameObject() {
    XCTAssertEqual(sut.tableView.dataSource as? ItemListDataProvider, sut.tableView.delegate as? ItemListDataProvider)
  }
  
}

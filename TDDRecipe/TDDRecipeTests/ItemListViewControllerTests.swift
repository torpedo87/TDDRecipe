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
  
  //add button target
  func test_ItemListViewController_HasAddBarButtonWithSelfAsTarget() {
    let target = sut.navigationItem.rightBarButtonItem?.target
    XCTAssertEqual(target as? UIViewController, sut)
  }
  
  //add button action
  func test_AddItem_PresentAddItemViewController() {
    XCTAssertNil(sut.presentedViewController)
    
    //view를 띄워야 버튼이 있으므로
    UIApplication.shared.keyWindow?.rootViewController = sut
    
    guard let addButton = sut.navigationItem.rightBarButtonItem else {
      XCTFail(); return
    }
    guard let action = addButton.action else { XCTFail(); return }
    
    //버튼 클릭
    sut.performSelector(onMainThread: action, with: addButton, waitUntilDone: true)
    
    XCTAssertNotNil(sut.presentedViewController)
    XCTAssertTrue(sut.presentedViewController is InputViewController)
    
    let inputViewController = sut.presentedViewController as? InputViewController
    XCTAssertNotNil(inputViewController?.titleTextField)
  }
  
  //itemManager
  func test_ItemListVC_SharesItemManagerWithInputVC() {
    
    guard let addButton = sut.navigationItem.rightBarButtonItem else {
      XCTFail(); return
    }
    guard let action = addButton.action else { XCTFail(); return }
    
    UIApplication.shared.keyWindow?.rootViewController = sut
    //버튼 클릭
    sut.performSelector(onMainThread: action, with: addButton, waitUntilDone: true)
    
    guard let inputViewController = sut.presentedViewController as? InputViewController else { XCTFail(); return }
    guard let inputItemManager = inputViewController.itemManager else
    { XCTFail(); return }
    XCTAssertTrue(sut.itemManager === inputItemManager)
  }
  
  //itemManager
  func test_ViewDidLoad_SetsItemManagerToDataProvider() {
    XCTAssertTrue(sut.itemManager === sut.dataProvider.itemManager)
  }
  
  //tableview reload
  func test_TableView_WhenAddedItem_ReloadData() {
    
    let mockTableView = MockTableView()
    sut.tableView = mockTableView
    let item = ToDoItem(title: "Foo")
    sut.itemManager.add(item)
    
    //viewwillappear
    sut.beginAppearanceTransition(true, animated: true)
    sut.endAppearanceTransition()
    
    XCTAssertTrue(mockTableView.reloadDataGotCalled)
  }
  
  //notification receiver
  func testItemSelectedNotification_PushesDetailVC() {

    let mockNavigationController = MockNavigationController(rootViewController: sut)
    let firstItem = ToDoItem(title: "First")
    let secondItem = ToDoItem(title: "Second")
    sut.itemManager.add(firstItem)
    sut.itemManager.add(secondItem)

    //view hierarchy
    UIApplication.shared.keyWindow?.rootViewController = mockNavigationController

    //viewdidload
    _ = sut.view

    //임시 노티 전송
    NotificationCenter.default.post(name: NSNotification.Name("ItemSelectedNotification"), object: self, userInfo: ["index" : 1])

    guard let detailViewController = mockNavigationController.pushedViewController as? DetailViewController else { XCTFail(); return }
    
    guard let detailItemManager = detailViewController.itemInfo?.0 else { XCTFail(); return }

    guard let index = detailViewController.itemInfo?.1 else { XCTFail(); return }
    
    //viewdidload
    _ = detailViewController.view

    //XCTAssertNotNil(detailViewController.titleLabel)
    XCTAssertTrue(detailItemManager === sut.itemManager)
    XCTAssertEqual(index, 1)
    
    //다 끝나고 viewwillappear 왜 호출되는거지????????
  }
  
}

extension ItemListViewControllerTests {
  
  class MockTableView: UITableView {
    var reloadDataGotCalled: Bool = false
    
    override func reloadData() {
      reloadDataGotCalled = true
    }
    
  }
  
  class MockNavigationController: UINavigationController {
    var pushedViewController: UIViewController?
    
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
      pushedViewController = viewController
      super.pushViewController(viewController, animated: animated)
    }
  }
}

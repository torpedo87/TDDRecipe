//
//  ItemManagerTests.swift
//  TDDRecipe
//
//  Created by junwoo on 2017. 9. 13..
//  Copyright © 2017년 junwoo. All rights reserved.
//

import XCTest
@testable import TDDRecipe

class ItemManagerTests: XCTestCase {
  
  var sut: ItemManager!
  
  override func setUp() {
    super.setUp()
    
    sut = ItemManager()
    
  }
  
  override func tearDown() {
    sut.removeAll()
    sut = nil
    
    super.tearDown()
  }
  
  //todocount
  func test_ToDoCount_Initially_IsZero() {
    
    XCTAssertEqual(sut.toDoCount, 0)
  }
  
  //donecount
  func test_DoneCount_Initially_IsZero() {
    
    XCTAssertEqual(sut.doneCount, 0)
  }
  
  //func add
  func test_AddItem_IncreasesToDoCountToOne() {
    sut.add(ToDoItem(title: ""))
    
    XCTAssertEqual(sut.toDoCount, 1)
  }
  
  //func itemat
  func test_ItemAt_AfterAddingAnItem_ReturnsThatItem() {
    let item = ToDoItem(title: "Foo")
    sut.add(item)
    
    let returnedItem = sut.item(at: 0)
    
    XCTAssertEqual(returnedItem.title, item.title)
  }
  
  //func checkitemat
  func test_checkItemAt_ChangesCounts() {
    sut.add(ToDoItem(title: ""))
    
    sut.checkItem(at: 0)
    XCTAssertEqual(sut.toDoCount, 0)
    XCTAssertEqual(sut.doneCount, 1)
  }
  
  //func checkitemat
  func test_CheckItemAt_RemoveItFromToDoItems() {
    let first = ToDoItem(title: "First")
    let second = ToDoItem(title: "Second")
    sut.add(first)
    sut.add(second)
    
    sut.checkItem(at: 0)
    
    XCTAssertEqual(sut.item(at: 0).title, "Second")
  }
  
  //func doneitemat
  func test_DoneItemAt_ReturnsCheckedItem() {
    let item = ToDoItem(title: "Foo")
    sut.add(item)
    
    sut.checkItem(at: 0)
    let returnedItem = sut.doneItem(at: 0)
    
    XCTAssertEqual(returnedItem.title, item.title)
  }
  
  //func removeall
  func test_RemoveAll_ResultsCountsBeZero() {
    sut.add(ToDoItem(title: "Foo"))
    sut.add(ToDoItem(title: "Bar"))
    sut.checkItem(at: 0)
    
    XCTAssertEqual(sut.toDoCount, 1)
    XCTAssertEqual(sut.doneCount, 1)
    
    sut.removeAll()
    
  }
  
  //func add 수정
  func test_Add_WhenItemsAlreadyAdded_DoesNotIncreaseCount() {
    sut.add(ToDoItem(title: "Foo"))
    sut.add(ToDoItem(title: "Foo"))
    
    XCTAssertEqual(sut.toDoCount, 1)
  }
  
  //serialize
  func test_ToDoItemsGetSerialized() {
    var itemManager: ItemManager? = ItemManager()
    
    let firstItem = ToDoItem(title: "First")
    itemManager?.add(firstItem)
    
    let secondItem = ToDoItem(title: "Second")
    itemManager?.add(secondItem)
    
    //앱 비활성화
    NotificationCenter.default.post(name: .UIApplicationWillResignActive, object: nil)
    itemManager = nil
    XCTAssertNil(itemManager)
    
    itemManager = ItemManager()
    XCTAssertEqual(itemManager?.toDoCount, 2)
    XCTAssertEqual(itemManager?.item(at: 0), firstItem)
    XCTAssertEqual(itemManager?.item(at: 1), secondItem)
    
  }
}

//
//  CardManagerTests.swift
//  TDDRecipe
//
//  Created by junwoo on 2017. 9. 12..
//  Copyright © 2017년 junwoo. All rights reserved.
//

import XCTest
@testable import TDDRecipe

class ItemManagerTests: XCTestCase {
  
  var sut: ItemManager!
  
  override func setUp() {
    super.setUp()
    sut = ItemManager()
    // Put setup code here. This method is called before the invocation of each test method in the class.
  }
  
  override func tearDown() {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    super.tearDown()
  }
  
  //처음에 0개
  func test_Item_Initially_IsZero() {
    XCTAssertEqual(sut.itemCount, 0)
  }
  
  //추가하면 1개씩 증가
  func test_AddItem_IncreasesCardCountToOne() {
    sut.add(Item(url: ""))
    XCTAssertEqual(sut.itemCount, 1)
  }
  
  //추가한 아이템이 맞는지 확인
  func test_ItemAt_AfterAddingAnItem_ReturnsThatItem() {
    let item = Item(url: "Foo")
    sut.add(item)
    let returnedItem = sut.item(at: 0)
    
    XCTAssertEqual(returnedItem.url, item.url)
  }
  
  //체크시 1개씩 감소
  func test_CheckItemAt_ChangesCount() {
    sut.add(Item(url: ""))
    sut.checkItem(at: 0)
    
    XCTAssertEqual(sut.itemCount, 0)
  }
  
  //체크시 삭제
  func test_CheckItemAt_RemovesItFromItems() {
    let first = Item(url: "first.com")
    let second = Item(url: "second.com")
    sut.add(first)
    sut.add(second)
    
    sut.checkItem(at: 0)
    XCTAssertEqual(sut.item(at: 0).url, "second.com")
  }
}

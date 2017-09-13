//
//  URLCardTests.swift
//  TDDRecipe
//
//  Created by junwoo on 2017. 9. 11..
//  Copyright © 2017년 junwoo. All rights reserved.
//

import XCTest
@testable import TDDRecipe

class ItemTests: XCTestCase {
  
  override func setUp() {
    super.setUp()
    // Put setup code here. This method is called before the invocation of each test method in the class.
  }
  
  override func tearDown() {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    super.tearDown()
  }
  
  //url
  func test_Init_WhenGivenURL_SetsURL() {
    let item = Item(url: "testurl.com")
    XCTAssertEqual(item.url, "testurl.com", "should set url")
  }
  
  //title
  func test_Init_WhenGivenTitle_SetsTitle() {
    let item = Item(url: "", title: "test")
    XCTAssertEqual(item.title, "test", "should set title")
  }
  
  //timestamp
  func test_Init_WhenGivenTimestamp_SetsTimestamp() {
    let item = Item(url: "", timestamp: 0.0)
    XCTAssertEqual(item.timestamp, 0.0, "should set timestamp")
  }
  
  //item 비교
  func test_EqualItems_AreEqual() {
    let first = Item(url: "Foo")
    let second = Item(url: "Foo")
    
    XCTAssertEqual(first, second)
  }
  
  //title이 다르면 다르다
  func test_Items_WhenTitleDiffers_AreNotEqual() {
    let first = Item(url: "", title: "title1")
    let second = Item(url: "", title: "title2")
    
    XCTAssertNotEqual(first, second)
  }
  
  
}

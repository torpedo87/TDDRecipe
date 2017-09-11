//
//  URLCardTests.swift
//  TDDRecipe
//
//  Created by junwoo on 2017. 9. 11..
//  Copyright © 2017년 junwoo. All rights reserved.
//

import XCTest
@testable import TDDRecipe

class URLCardTests: XCTestCase {
  
  override func setUp() {
    super.setUp()
    // Put setup code here. This method is called before the invocation of each test method in the class.
  }
  
  override func tearDown() {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    super.tearDown()
  }
  
  func test_Init_TakesURL() {
    URLCard(url: "testurl.com")
  }
}

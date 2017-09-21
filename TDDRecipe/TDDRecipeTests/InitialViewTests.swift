//
//  StoryboardTests.swift
//  TDDRecipeTests
//
//  Created by junwoo on 2017. 9. 20..
//  Copyright © 2017년 junwoo. All rights reserved.
//

import XCTest
@testable import TDDRecipe

class InitialViewTests: XCTestCase {
  
  override func setUp() {
    super.setUp()
    // Put setup code here. This method is called before the invocation of each test method in the class.
  }
  
  override func tearDown() {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    super.tearDown()
  }
  
  //initial viewcontroller
  func test_InitialViewController_IsItemListViewController() {
    
    let navigationController = UIApplication.shared.keyWindow?.rootViewController as! UINavigationController
    let rootViewController = navigationController.viewControllers[0]
    
    XCTAssertTrue(rootViewController is ItemListViewController)
    
  }
  
}

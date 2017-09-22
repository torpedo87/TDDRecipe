//
//  TDDRecipeUITests.swift
//  TDDRecipeUITests
//
//  Created by junwoo on 2017. 9. 22..
//  Copyright © 2017년 junwoo. All rights reserved.
//

import XCTest

class TDDRecipeUITests: XCTestCase {
  
  override func setUp() {
    super.setUp()
    
    // Put setup code here. This method is called before the invocation of each test method in the class.
    
    // In UI tests it is usually best to stop immediately when a failure occurs.
    continueAfterFailure = false
    // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
    XCUIApplication().launch()
    
    // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
  }
  
  override func tearDown() {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    super.tearDown()
  }
  
  //save item
  func testExample() {
    
    let app = XCUIApplication()
    app.navigationBars["TDDRecipe.ItemListView"].buttons["Add"].tap()
    
    let titleTextField = app.textFields["title"]
    titleTextField.tap()
    titleTextField.typeText("title")
    
    let dateTextField = app.textFields["date"]
    dateTextField.tap()
    dateTextField.typeText("11/11/2016")
    
    let locationTextField = app.textFields["location"]
    locationTextField.tap()
    locationTextField.typeText("loc")
    app.buttons["Save"].tap()
    
    
    XCTAssertTrue(app.tables.staticTexts["title"].exists)
    XCTAssertTrue(app.tables.staticTexts["11/11/2016"].exists)
    XCTAssertTrue(app.tables.staticTexts["loc"].exists)
  }
  
}

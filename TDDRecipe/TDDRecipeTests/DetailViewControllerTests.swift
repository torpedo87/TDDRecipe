//
//  DetailViewControllerTests.swift
//  TDDRecipeTests
//
//  Created by junwoo on 2017. 9. 15..
//  Copyright © 2017년 junwoo. All rights reserved.
//

import XCTest
@testable import TDDRecipe
import CoreLocation

class DetailViewControllerTests: XCTestCase {
  
  var sut: DetailViewController!
  
  override func setUp() {
    super.setUp()
    sut = DetailViewController()
    
    //viewdidload 호출
    _ = sut.view
  }
  
  override func tearDown() {
    sut.itemInfo?.0.removeAll()
    
    super.tearDown()
  }
  
  //titlelabel
  func test_HasTitleLabel() {
    
    XCTAssertNotNil(sut.titleLabel)
  }
  
  //locationlabel
  func test_HasLocationLabel() {
    
    XCTAssertNotNil(sut.locationLabel)
  }
  
  //datelabel
  func test_HasDateLabel() {
    
    XCTAssertNotNil(sut.dateLabel)
  }
  
  //descriptionlabel
  func test_HasDescriptionLabel() {
    
    XCTAssertNotNil(sut.descriptionLabel)
  }
  
  //mapview
  func test_HasMapView() {
    XCTAssertNotNil(sut.mapView)
  }
  
  //checkbutton
  func test_HasCheckButton() {
    XCTAssertNotNil(sut.checkButton)
  }
  
  //label.text, mapview.region
  func test_SettingItemInfo_SetsTextsToLabels() {
    let coordinate = CLLocationCoordinate2DMake(51.2277, 6.7735)
    
    let location = Location(name: "Foo", coordinate: coordinate)
    let item = ToDoItem(title: "Bar",
                        itemDescription: "Baz",
                        timestamp: 1456150025,
                        location: location)
    
    let itemManager = ItemManager()
    itemManager.add(item)
    
    sut.itemInfo = (itemManager, 0)
    
    //frame 값을 줘야 테스트 통과하는데 뭐지...???
    sut.mapView.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
    
    //viewwillappear 호출
    sut.beginAppearanceTransition(true, animated: true)
    sut.endAppearanceTransition()
    XCTAssertEqual(sut.titleLabel.text, "Bar")
    XCTAssertEqual(sut.dateLabel.text, "02/22/2016")
    XCTAssertEqual(sut.locationLabel.text, "Foo")
    XCTAssertEqual(sut.descriptionLabel.text, "Baz")
    XCTAssertEqual(sut.mapView.centerCoordinate.latitude,
                               coordinate.latitude,
                               accuracy: 0.001)
    XCTAssertEqual(sut.mapView.centerCoordinate.longitude,
                               coordinate.longitude,
                               accuracy: 0.001)
  }
  
  //check
  func test_CheckItem_ChecksItemInItemManager() {
    let itemManager = ItemManager()
    itemManager.add(ToDoItem(title: "Foo"))
    
    sut.itemInfo = (itemManager, 0)
    sut.checkItem()
    
    XCTAssertEqual(itemManager.toDoCount, 0)
    XCTAssertEqual(itemManager.doneCount, 1)
  }
  
  //checkbutton 과 func checkitem 연결
  func test_CheckButtonHasCheckItemAction() {
    let checkButton: UIButton = sut.checkButton
    
    guard let actions = checkButton.actions(forTarget: sut, forControlEvent: .touchUpInside) else {
      XCTFail(); return
    }
    
    XCTAssertTrue(actions.contains("checkItem"))
  }
  
}

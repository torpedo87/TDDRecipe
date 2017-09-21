//
//  InputViewControllerTests.swift
//  TDDRecipeTests
//
//  Created by junwoo on 2017. 9. 18..
//  Copyright © 2017년 junwoo. All rights reserved.
//

import XCTest
@testable import TDDRecipe
import CoreLocation

class InputViewControllerTests: XCTestCase {
  
  var sut: InputViewController!
  var placemark: MockPlacemark!
  
  override func setUp() {
    super.setUp()
    sut = InputViewController()
    _ = sut.view
  }
  
  override func tearDown() {
    sut.itemManager?.removeAll()
    
    super.tearDown()
  }
  
  func test_HasTitleLabel() {
    
    XCTAssertNotNil(sut.titleLabel)
  }
  
  func test_HasDateLabel() {
    
    XCTAssertNotNil(sut.dateLabel)
  }
  
  func test_HasLocationLabel() {
    
    XCTAssertNotNil(sut.locationLabel)
  }
  
  func test_HasAddressLabel() {
    
    XCTAssertNotNil(sut.addressLabel)
  }
  
  func test_HasDescriptionLabel() {
    
    XCTAssertNotNil(sut.descriptionLabel)
  }
  
  //title
  func test_HasTitleTextField() {
    XCTAssertNotNil(sut.titleTextField)
  }
  
  //date
  func test_HasDateTextField() {
    XCTAssertNotNil(sut.dateTextField)
  }
  
  //location
  func test_HasLocationTextField() {
    XCTAssertNotNil(sut.locationTextField)
  }
  
  //address
  func test_HasAddressTextField() {
    XCTAssertNotNil(sut.addressTextField)
  }
  
  //description
  func test_HasDescriptionTextField() {
    XCTAssertNotNil(sut.descriptionTextField)
  }
  
  //saveButton
  func test_HasSaveButton() {
    XCTAssertNotNil(sut.saveButton)
  }
  
  //cancelButton
  func test_HasCancelButton() {
    XCTAssertNotNil(sut.cancelButton)
  }
  
  //geocoder for coordinate
  func test_Save_UsesGeocoderToGetCoordinateFromAddress() {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "MM/dd/yyyy"
    let date = dateFormatter.date(from: "02/22/2016")!
    let timestamp = date.timeIntervalSince1970
    sut.titleTextField.text = "Foo"
    sut.dateTextField.text = dateFormatter.string(from: date)
    sut.locationTextField.text = "Bar"
    sut.addressTextField.text = "Infinite Loop 1, Cupertino"
    sut.descriptionTextField.text = "Baz"
    
    let mockGeocoder = MockGeocoder()
    sut.geocoder = mockGeocoder
    sut.itemManager = ItemManager()
    sut.save()
    
    placemark = MockPlacemark()
    let coordinate = CLLocationCoordinate2DMake(37.3316851,
                                                -122.0300674)
    placemark.mockCoordinate = coordinate
    mockGeocoder.completionHandler?([placemark], nil)
    let item = sut.itemManager?.item(at: 0)
    let testItem = ToDoItem(title: "Foo",
                            itemDescription: "Baz",
                            timestamp: timestamp,
                            location: Location(name: "Bar",
                                               coordinate: coordinate))
    
    XCTAssertEqual(item, testItem)
  }
  
  //savebutton 과 func save 연결
  func test_SaveButtonHasSaveAction() {
    let saveButton: UIButton = sut.saveButton
    
    guard let actions = saveButton.actions(forTarget: sut, forControlEvent: .touchUpInside) else {
      XCTFail(); return
    }
    
    XCTAssertTrue(actions.contains("save"))
  }
  
  //비동기 geocoder
  func test_Geocoder_FetchesCoordinates() {
    let geocoderAnswered = expectation(description: "Geocoder")
    
    CLGeocoder().geocodeAddressString("Infinite Loop 1, Cupertino") {
      (placemarks, error) -> Void in
      
      let coordinate = placemarks?.first?.location?.coordinate
      guard let latitude = coordinate?.latitude else {
        XCTFail()
        return
      }
      
      guard let longitude = coordinate?.longitude else {
        XCTFail()
        return
      }
      
      XCTAssertEqual(latitude, 37.3316, accuracy: 0.0001)
      XCTAssertEqual(longitude, -122.0300, accuracy: 0.001)
      
      geocoderAnswered.fulfill()
    }
    
    waitForExpectations(timeout: 3, handler: nil)
  }
  
  //save
  func test_Save_DismissedViewController() {
    let mockInputViewController = MockInputViewController()
    mockInputViewController.titleTextField = UITextField()
    mockInputViewController.dateTextField = UITextField()
    mockInputViewController.locationTextField = UITextField()
    mockInputViewController.addressTextField = UITextField()
    mockInputViewController.descriptionTextField = UITextField()
    mockInputViewController.titleTextField.text = "Test Title"
    
    mockInputViewController.save()
    
    XCTAssertTrue(mockInputViewController.dismissGotCalled)
  }
  
}

extension InputViewControllerTests {
  
  class MockGeocoder: CLGeocoder {
    var completionHandler: CLGeocodeCompletionHandler?
    
    override func geocodeAddressString(_ addressString: String, completionHandler: @escaping CLGeocodeCompletionHandler) {
      self.completionHandler = completionHandler
    }
  }
  
  class MockPlacemark: CLPlacemark {
    var mockCoordinate: CLLocationCoordinate2D?
    
    override var location: CLLocation? {
      guard let coordinate = mockCoordinate else { return CLLocation() }
      
      return CLLocation(latitude: coordinate.latitude, longitude: coordinate.longitude)
    }
  }
  
  class MockInputViewController: InputViewController {
    
    var dismissGotCalled = false
    
    override func dismiss(animated flag: Bool, completion: (() -> Void)? = nil) {
      dismissGotCalled = true
    }
  }
  
}

//
//  InputViewController.swift
//  TDDRecipe
//
//  Created by junwoo on 2017. 9. 18..
//  Copyright © 2017년 junwoo. All rights reserved.
//

import UIKit
import CoreLocation

class InputViewController: UIViewController {
  
  var didSetupConstraints = false
  
  var titleTextField: UITextField = {
    let textField = UITextField()
    return textField
  }()
  var dateTextField: UITextField = {
    let textField = UITextField()
    return textField
  }()
  var locationTextField: UITextField = {
    let textField = UITextField()
    return textField
  }()
  var addressTextField: UITextField = {
    let textField = UITextField()
    return textField
  }()
  var descriptionTextField: UITextField = {
    let textField = UITextField()
    return textField
  }()
  
  var saveButton: UIButton = {
    let button = UIButton()
    return button
  }()
  var cancelButton: UIButton = {
    let button = UIButton()
    return button
  }()
  
  lazy var geocoder = CLGeocoder()
  var itemManager: ItemManager?
  let dateFormatter: DateFormatter = {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "MM/dd/yyyy"
    return dateFormatter
  }()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    view.addSubview(titleTextField)
    view.addSubview(dateTextField)
    view.addSubview(locationTextField)
    view.addSubview(addressTextField)
    view.addSubview(descriptionTextField)
    view.addSubview(saveButton)
    view.addSubview(cancelButton)
    
    saveButton.addTarget(self, action: #selector(save), for: .touchUpInside)
    
    view.setNeedsUpdateConstraints()
    
  }
  
  override func updateViewConstraints() {
    if !didSetupConstraints {
      
      
      
      didSetupConstraints = true
    }
    super.updateViewConstraints()
  }
  
  //입력한 정보를 item 형태로 추가
  func save() {
    
    //title
    guard let titleString = titleTextField.text,
      titleString.characters.count > 0 else { return }
    
    //date
    let date: Date?
    if let dateText = self.dateTextField.text,
      dateText.characters.count > 0 {
      date = dateFormatter.date(from: dateText)
    } else {
      date = nil
    }
    
    //description
    let descriptionString = descriptionTextField.text
    
    //location, address
    if let locationName = locationTextField.text,
      locationName.characters.count > 0 {
      if let address = addressTextField.text,
        address.characters.count > 0 {
        
        geocoder.geocodeAddressString(address) {
          [unowned self] (placeMarks, error) -> Void in
          
          let placeMark = placeMarks?.first
          
          let item = ToDoItem(
            title: titleString,
            itemDescription: descriptionString,
            timestamp: date?.timeIntervalSince1970,
            location: Location(
              name: locationName,
              coordinate: placeMark?.location?.coordinate))
          
          self.itemManager?.add(item)
        }
      }
    }
  }
  
}

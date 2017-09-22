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
  
  var titleLabel: UILabel = {
    let label = UILabel()
    label.text = "Title"
    return label
  }()
  var dateLabel: UILabel = {
    let label = UILabel()
    label.text = "Date"
    return label
  }()
  var locationLabel: UILabel = {
    let label = UILabel()
    label.text = "Location"
    return label
  }()
  var addressLabel: UILabel = {
    let label = UILabel()
    label.text = "Address"
    return label
  }()
  var descriptionLabel: UILabel = {
    let label = UILabel()
    label.text = "Description"
    return label
  }()
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
    view.backgroundColor = UIColor.white
    
    view.addSubview(titleLabel)
    view.addSubview(dateLabel)
    view.addSubview(locationLabel)
    view.addSubview(addressLabel)
    view.addSubview(descriptionLabel)
    view.addSubview(titleTextField)
    view.addSubview(dateTextField)
    view.addSubview(locationTextField)
    view.addSubview(addressTextField)
    view.addSubview(descriptionTextField)
    view.addSubview(saveButton)
    view.addSubview(cancelButton)
    
    saveButton.addTarget(self, action: #selector(save), for: .touchUpInside)
    cancelButton.addTarget(self, action: #selector(cancel), for: .touchUpInside)
    titleTextField.placeholder = "title"
    dateTextField.placeholder = "date"
    locationTextField.placeholder = "location"
    addressTextField.placeholder = "address"
    descriptionTextField.placeholder = "description"
    cancelButton.setTitle("Cancel", for: .normal)
    cancelButton.backgroundColor = UIColor.darkGray
    saveButton.setTitle("Save", for: .normal)
    saveButton.backgroundColor = UIColor.red
    
    view.setNeedsUpdateConstraints()
    
  }
  
  override func updateViewConstraints() {
    if !didSetupConstraints {
      
      titleLabel.snp.makeConstraints { make in
        make.left.top.equalTo(self.view).offset(10)
        make.height.equalTo(50)
        make.width.equalTo(100)
      }
      titleTextField.snp.makeConstraints { make in
        make.right.equalTo(self.view).offset(-10)
        make.top.equalTo(self.view).offset(10)
        make.left.equalTo(titleLabel.snp.right).offset(10)
        make.height.equalTo(50)
      }
      
      dateLabel.snp.makeConstraints { make in
        make.left.equalTo(self.view).offset(10)
        make.top.equalTo(titleLabel.snp.bottom).offset(10)
        make.height.equalTo(50)
        make.width.equalTo(100)
      }
      dateTextField.snp.makeConstraints { make in
        make.right.equalTo(self.view).offset(-10)
        make.top.equalTo(titleTextField.snp.bottom).offset(10)
        make.left.equalTo(dateLabel.snp.right).offset(10)
        make.height.equalTo(50)
      }
      
      locationLabel.snp.makeConstraints { make in
        make.left.equalTo(self.view).offset(10)
        make.top.equalTo(dateLabel.snp.bottom).offset(10)
        make.height.equalTo(50)
        make.width.equalTo(100)
      }
      locationTextField.snp.makeConstraints { make in
        make.right.equalTo(self.view).offset(-10)
        make.top.equalTo(dateTextField.snp.bottom).offset(10)
        make.left.equalTo(locationLabel.snp.right).offset(10)
        make.height.equalTo(50)
      }
      
      addressLabel.snp.makeConstraints { make in
        make.left.equalTo(self.view).offset(10)
        make.top.equalTo(locationLabel.snp.bottom).offset(10)
        make.height.equalTo(50)
        make.width.equalTo(100)
      }
      addressTextField.snp.makeConstraints { make in
        make.right.equalTo(self.view).offset(-10)
        make.top.equalTo(locationTextField.snp.bottom).offset(10)
        make.left.equalTo(addressLabel.snp.right).offset(10)
        make.height.equalTo(50)
      }
      
      descriptionLabel.snp.makeConstraints { make in
        make.left.equalTo(self.view).offset(10)
        make.top.equalTo(addressLabel.snp.bottom).offset(10)
        make.height.equalTo(50)
        make.width.equalTo(100)
      }
      descriptionTextField.snp.makeConstraints { make in
        make.right.equalTo(self.view).offset(-10)
        make.top.equalTo(addressTextField.snp.bottom).offset(10)
        make.left.equalTo(descriptionLabel.snp.right).offset(10)
        make.height.equalTo(50)
      }
      cancelButton.snp.makeConstraints { make in
        make.left.equalTo(self.view).offset(10)
        make.top.equalTo(descriptionLabel.snp.bottom).offset(10)
        make.height.equalTo(50)
        make.width.equalTo(150)
      }
      saveButton.snp.makeConstraints { make in
        make.left.equalTo(cancelButton.snp.right).offset(5)
        make.top.equalTo(descriptionTextField.snp.bottom).offset(10)
        make.height.width.equalTo(cancelButton)
      }
      
      didSetupConstraints = true
    }
    super.updateViewConstraints()
  }
  
  //입력한 정보를 item 형태로 추가
  func save() {
    
    guard let titleString = titleTextField.text,
      titleString.characters.count > 0 else { return }
    
    let date: Date?
    if let dateText = self.dateTextField.text,
      dateText.characters.count > 0 {
      date = dateFormatter.date(from: dateText)
    } else {
      date = nil
    }
    
    let descriptionString = descriptionTextField.text
    
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
          
          DispatchQueue.main.async(execute: {
            self.itemManager?.add(item)
            self.dismiss(animated: true, completion: nil)
          })
          
        }
      } else {
        let item = ToDoItem(title: titleString,
                            itemDescription: descriptionString,
                            timestamp: date?.timeIntervalSince1970,
                            location: Location(name: locationName))
        self.itemManager?.add(item)
        dismiss(animated: true, completion: nil)
      }
    } else {
      let item = ToDoItem(title: titleString,
                          itemDescription: descriptionString,
                          timestamp: date?.timeIntervalSince1970,
                          location: nil)
      self.itemManager?.add(item)
      dismiss(animated: true, completion: nil)
    }
    
    //self.dismiss(animated: true, completion: nil)
    
  }
  
  func cancel() {
    dismiss(animated: true, completion: nil)
  }
  
}

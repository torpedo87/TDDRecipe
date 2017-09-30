//
//  DetailViewController.swift
//  TDDRecipe
//
//  Created by junwoo on 2017. 9. 15..
//  Copyright © 2017년 junwoo. All rights reserved.
//

import UIKit
import MapKit

class DetailViewController: UIViewController {
  
  var didSetupConstraints = false
  
  lazy var titleLabel: UILabel = {
    let label = UILabel()
    return label
  }()
  lazy var locationLabel: UILabel = {
    let label = UILabel()
    return label
  }()
  lazy var dateLabel: UILabel = {
    let label = UILabel()
    return label
  }()
  lazy var descriptionLabel: UILabel = {
    let label = UILabel()
    return label
  }()
  lazy var mapView: MKMapView = {
    var view = MKMapView()
    return view
  }()
  var checkButton: UIButton = {
    let button = UIButton()
    return button
  }()
  
  var itemInfo: (ItemManager, Int)?
  let dateFormatter: DateFormatter = {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "MM/dd/yyyy"
    return dateFormatter
  }()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    view.addSubview(mapView)
    view.addSubview(titleLabel)
    view.addSubview(locationLabel)
    view.addSubview(dateLabel)
    view.addSubview(descriptionLabel)
    view.addSubview(checkButton)
    
    checkButton.addTarget(self, action: #selector(checkItem), for: .touchUpInside)

    view.setNeedsUpdateConstraints()

  }
  
  override func updateViewConstraints() {
    if !didSetupConstraints {
      
      mapView.snp.makeConstraints { make in
        make.top.equalTo(self.view).offset(50)
        make.height.equalTo(200)
        make.left.equalTo(self.view).offset(50)
        make.right.equalTo(self.view).offset(-50)
        make.centerX.equalTo(self.view)
      }
      titleLabel.snp.makeConstraints { make in
        make.height.equalTo(50)
        make.left.right.width.equalTo(mapView)
        make.centerX.equalTo(self.view)
        make.top.equalTo(mapView.snp.bottom).offset(10)
      }
      
      dateLabel.snp.makeConstraints { make in
        make.height.width.centerX.equalTo(titleLabel)
        make.top.equalTo(titleLabel.snp.bottom).offset(10)
      }
      
      locationLabel.snp.makeConstraints { make in
        make.height.width.centerX.equalTo(dateLabel)
        make.top.equalTo(dateLabel.snp.bottom).offset(10)
      }
      
      descriptionLabel.snp.makeConstraints { make in
        make.width.centerX.equalTo(locationLabel)
        make.height.equalTo(150)
        make.top.equalTo(locationLabel.snp.bottom).offset(10)
      }
      
      checkButton.snp.makeConstraints { make in
        make.height.width.centerX.equalTo(locationLabel)
        make.top.equalTo(descriptionLabel.snp.bottom).offset(10)
      }
      
      didSetupConstraints = true
    }
    super.updateViewConstraints()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    print(#function)
    super.viewWillAppear(animated)
    
    guard let itemInfo = itemInfo
      else { fatalError() }
    let item = itemInfo.0.item(at: itemInfo.1)

    titleLabel.text = item.title
    locationLabel.text = item.location?.name
    descriptionLabel.text = item.itemDescription

    if let timestamp = item.timestamp {
      let date = Date(timeIntervalSince1970: timestamp)
      dateLabel.text = dateFormatter.string(from: date)
    }

    if let coordinate = item.location?.coordinate {
      let region = MKCoordinateRegionMakeWithDistance(coordinate,
                                                      100, 100)
      mapView.region = region
    }
    
  }
  
  func checkItem() {
    if let itemInfo = itemInfo {
      itemInfo.0.checkItem(at: itemInfo.1)
    }
  }
}

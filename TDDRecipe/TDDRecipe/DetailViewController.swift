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
  
  var itemInfo: (ItemManager, Int)?
  let dateFormatter: DateFormatter = {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "MM/dd/yyyy"
    return dateFormatter
  }()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.view.addSubview(mapView)
    self.view.addSubview(titleLabel)
    self.view.addSubview(locationLabel)
    self.view.addSubview(dateLabel)
    self.view.addSubview(descriptionLabel)

    view.setNeedsUpdateConstraints()

  }
  
  override func updateViewConstraints() {
    if !didSetupConstraints {
      
      mapView.snp.makeConstraints { make in
        make.height.equalTo(100)
        make.width.equalTo(200)
        make.center.equalTo(self.view)
      }
      titleLabel.snp.makeConstraints { make in
        make.height.equalTo(50)
        make.width.equalTo(self.view)
        make.top.equalTo(mapView.snp.bottom)
      }
      
      dateLabel.snp.makeConstraints { make in
        make.height.equalTo(50)
        make.width.equalTo(self.view)
        make.top.equalTo(titleLabel.snp.bottom)
      }
      
      locationLabel.snp.makeConstraints { make in
        make.height.equalTo(50)
        make.width.equalTo(self.view)
        make.top.equalTo(dateLabel.snp.bottom)
      }
      
      descriptionLabel.snp.makeConstraints { make in
        make.height.equalTo(50)
        make.width.equalTo(self.view)
        make.top.equalTo(locationLabel.snp.bottom)
      }
      
      didSetupConstraints = true
    }
    super.updateViewConstraints()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    
    guard let itemInfo = itemInfo else { return }
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

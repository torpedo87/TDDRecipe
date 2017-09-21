//
//  Location.swift
//  TDDRecipe
//
//  Created by junwoo on 2017. 9. 13..
//  Copyright © 2017년 junwoo. All rights reserved.
//

import Foundation
import CoreLocation

struct Location {
  let name: String
  let coordinate: CLLocationCoordinate2D?
  
  private let nameKey = "nameKey"
  private let latitudeKey = "latitudeKey"
  private let longitudeKey = "longitudeKey"
  
  //연산프로퍼티
  var plistDict: [String:Any] {
    var dict = [String:Any]()
    dict[nameKey] = name
    if let coordinate = coordinate {
      dict[latitudeKey] = coordinate.latitude
      dict[longitudeKey] = coordinate.longitude
    }
    return dict
  }
  
  init(name: String, coordinate: CLLocationCoordinate2D? = nil) {
    self.name = name
    self.coordinate = coordinate
  }
  
  init?(dict: [String:Any]) {
    guard let name = dict[nameKey] as? String else { return nil }
    
    let coordinate: CLLocationCoordinate2D?
    if let latitude = dict[latitudeKey] as? Double,
      let longitude = dict[longitudeKey] as? Double {
      coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
      
    } else {
      coordinate = nil
    }
    self.name = name
    self.coordinate = coordinate
  }
}

extension Location: Equatable {
  static func ==(lhs: Location, rhs: Location) -> Bool {
    if lhs.coordinate?.latitude != rhs.coordinate?.latitude {
      return false
    }
    
    if lhs.coordinate?.longitude != rhs.coordinate?.longitude {
      return false
    }
    
    if lhs.name != rhs.name {
      return false
    }
    
    return true
  }
}

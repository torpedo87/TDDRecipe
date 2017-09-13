//
//  URLCard.swift
//  TDDRecipe
//
//  Created by junwoo on 2017. 9. 11..
//  Copyright © 2017년 junwoo. All rights reserved.
//

import UIKit

//struct는 자동으로 arguemt를 전부 포함하는 init를 갖는다
struct Item {
  let url: String
  var title: String?
  let timestamp: Double?
  
  //tagArr에 default 값을 주면 나중에 생성시 tagArr 생략해도 만들 수 있다
  init(url: String, title: String? = nil, timestamp: Double? = nil) {
    self.url = url
    self.title = title
    self.timestamp = timestamp
  }
}

extension Item: Equatable {
  static func ==(lhs: Item, rhs: Item) -> Bool {
    if lhs.title != rhs.title {
      return false
    }
    
    return true
  }

}

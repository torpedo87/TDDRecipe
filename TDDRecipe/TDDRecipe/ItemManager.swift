//
//  CardManager.swift
//  TDDRecipe
//
//  Created by junwoo on 2017. 9. 12..
//  Copyright © 2017년 junwoo. All rights reserved.
//

import UIKit

class ItemManager {
  private var items: [Item] = []
  var itemCount: Int { return items.count }
  
  func add(_ item: Item) {
    
    items.append(item)
  }
  
  func item(at index: Int) -> Item {
    return items[index]
  }
  
  func checkItem(at index: Int) {
    items.remove(at: index)
  }
  
}

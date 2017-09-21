//
//  ItemCell.swift
//  TDDRecipe
//
//  Created by junwoo on 2017. 9. 14..
//  Copyright © 2017년 junwoo. All rights reserved.
//

import UIKit

class ItemCell: UITableViewCell {
  
  var titleLabel: UILabel = {
    let label = UILabel()
    return label
  }()
  var locationLabel:  UILabel = {
    let label = UILabel()
    return label
  }()
  var dateLabel: UILabel = {
    let label = UILabel()
    return label
  }()
  
  lazy var dateFormatter: DateFormatter = {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "MM/dd/yyyy"
    return dateFormatter
  }()
  
  override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    
    contentView.addSubview(titleLabel)
    contentView.addSubview(locationLabel)
    contentView.addSubview(dateLabel)
    
    titleLabel.snp.makeConstraints { make in
      make.width.equalTo(100)
      make.height.equalTo(50)
      make.left.top.equalTo(self.contentView).offset(10)
    }
    
    locationLabel.snp.makeConstraints { make in
      make.top.equalTo(titleLabel.snp.bottom).offset(5)
      make.width.equalTo(100)
      make.centerX.equalTo(titleLabel)
    }
    
    dateLabel.snp.makeConstraints { make in
      make.width.equalTo(100)
      make.right.equalTo(self.contentView).offset(-10)
      make.center.equalTo(self.contentView)
    }
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }
  
  func configCell(with item: ToDoItem, checked: Bool = false) {
    
    if checked {
      let attributedString = NSAttributedString(string: item.title, attributes: [NSStrikethroughStyleAttributeName: NSUnderlineStyle.styleSingle.rawValue])
      titleLabel.attributedText = attributedString
      locationLabel.text = nil
      dateLabel.text = nil
    } else {
      titleLabel.text = item.title
      locationLabel.text = item.location?.name
      
      if let timestamp = item.timestamp {
        let date = Date(timeIntervalSince1970: timestamp)
        dateLabel.text = dateFormatter.string(from: date)
      }
    }
    
  }
}

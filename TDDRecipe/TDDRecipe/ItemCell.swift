//
//  ItemCell.swift
//  TDDRecipe
//
//  Created by junwoo on 2017. 9. 14..
//  Copyright © 2017년 junwoo. All rights reserved.
//

import UIKit

class ItemCell: UITableViewCell {
  
  var titleLabel: UILabel!
  var locationLabel:  UILabel!
  var dateLabel: UILabel!
  lazy var dateFormatter: DateFormatter = {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "MM/dd/yyyy"
    return dateFormatter
  }()
  
  override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    titleLabel = UILabel()
    locationLabel = UILabel()
    dateLabel = UILabel()
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }
  
  override func layoutSubviews() {
    self.contentView.addSubview(titleLabel)
    self.contentView.addSubview(locationLabel)
    self.contentView.addSubview(dateLabel)
    
    titleLabel.snp.makeConstraints { make in
      make.width.equalTo(100)
      make.height.equalTo(50)
      make.left.top.equalTo(self.contentView)
    }
    
    locationLabel.snp.makeConstraints { make in
      make.top.equalTo(titleLabel.snp.bottom)
      make.width.equalTo(100)
      make.left.bottom.equalTo(self.contentView)
    }
    
    dateLabel.snp.makeConstraints { make in
      make.top.bottom.equalTo(self.contentView)
      make.rightMargin.equalTo(-10)
    }
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

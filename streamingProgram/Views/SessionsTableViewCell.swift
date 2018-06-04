//
//  SessionsTableViewCell.swift
//  streamingProgram
//
//  Created by Antonio Giaquinto on 01/06/2018.
//  Copyright © 2018 Antonio Giaquinto. All rights reserved.
//

import UIKit

class SessionsTableViewCell: UITableViewCell {
  
  @IBOutlet weak var roomLabel: UILabel!
  @IBOutlet weak var countdownLabel: UILabel!
  @IBOutlet weak var topicLabel: UILabel!
  
  
  override func awakeFromNib() {
    super.awakeFromNib()
  }
  
  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
  }
  
}

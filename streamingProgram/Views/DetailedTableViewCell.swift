//
//  DetailedTableViewCell.swift
//  streamingProgram
//
//  Created by Antonio Giaquinto on 01/06/2018.
//  Copyright © 2018 Antonio Giaquinto. All rights reserved.
//

import UIKit

class DetailedTableViewCell: UITableViewCell {

    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var responsibleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UITextView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}

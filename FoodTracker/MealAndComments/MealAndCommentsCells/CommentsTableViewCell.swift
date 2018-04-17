//
//  CommentsTableViewCell.swift
//  FoodTracker
//
//  Created by Yaroslav Skachkov on 11.04.2018.
//  Copyright © 2018 Yaroslav Skachkov. All rights reserved.
//

import UIKit

class CommentsTableViewCell: UITableViewCell {

    //@IBOutlet weak var commentTextField: UITextField!
    @IBOutlet weak var commentTextLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

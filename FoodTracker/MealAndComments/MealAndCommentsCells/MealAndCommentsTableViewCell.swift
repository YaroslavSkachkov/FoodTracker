//
//  MealAndCommentsTableViewCell.swift
//  FoodTracker
//
//  Created by Yaroslav Skachkov on 11.04.2018.
//  Copyright © 2018 Yaroslav Skachkov. All rights reserved.
//

import UIKit


protocol MealAndCommentsTableViewCellDelegate: class {
    func pickPhoto()
}

class MealAndCommentsTableViewCell: UITableViewCell, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate  {

    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var ratingControl: RatingControl!
    @IBOutlet weak var changePhotoButton: UIButton!
    
    @IBAction func changePhotoFunc(_ sender: UIButton) {
        nameTextField.resignFirstResponder()
        delegate?.pickPhoto()
    }
    
    
    weak var delegate: MealAndCommentsTableViewCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

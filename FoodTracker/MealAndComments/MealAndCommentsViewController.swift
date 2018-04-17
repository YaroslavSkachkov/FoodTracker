//
//  MealAndCommentsViewController.swift
//  FoodTracker
//
//  Created by Yaroslav Skachkov on 11.04.2018.
//  Copyright © 2018 Yaroslav Skachkov. All rights reserved.
//

import UIKit
import os.log

class MealAndCommentsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate, MealAndCommentsTableViewCellDelegate, UITextFieldDelegate {
    
    var meal: Meal?
    
    
    @IBOutlet weak var saveButton: UIBarButtonItem!
    @IBOutlet weak var subView: UIView!
    @IBOutlet weak var MealAndCommentsTableView: UITableView!
    @IBOutlet weak var commentTextFieldView: UIView!
    @IBOutlet var keyboardHeightLayoutConstraint: NSLayoutConstraint?
    @IBOutlet weak var commentTextField: UITextField!
    @IBOutlet weak var sendCommentButtonOutlet: UIButton!
    
    
    
    
    // Cancel Button
    
    @IBAction func cancel(_ sender: UIBarButtonItem) {
        //        Depending on style of presentation (modal or push presentation), this view controller needs to be dismissed in two different ways.
        let isPresentingInAddMealMode = presentingViewController is UINavigationController
        if isPresentingInAddMealMode {
            dismiss(animated: true, completion: nil)
        } else if let owningNavigationController = navigationController{
            owningNavigationController.popViewController(animated: true)
        } else {
            fatalError("The MealViewController is not inside a navigation controller.")
        }
    }
    
    
    // var MEAL CELL
    
    var storeForMealCell: MealAndCommentsTableViewCell?
    
    
    func pickPhoto() {
        let imagePickerController = UIImagePickerController()
        imagePickerController.sourceType = .photoLibrary
        imagePickerController.delegate = self
        present(imagePickerController, animated: true, completion: nil)
    }
    
    //MARK: UITextFieldDelegate
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        saveButton.isEnabled = false
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        updateSaveButtonState()
        navigationItem.title = storeForMealCell?.nameTextField.text
    }
    
    // MARK: ImagePickerControllerDelegate
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        guard let selectedImage = info[UIImagePickerControllerOriginalImage] as? UIImage else {
            fatalError("Expected a dictionary containin an image, but was provided the following: \(info)")
        }
        storeForMealCell?.photoImageView.image = selectedImage
        dismiss(animated: true, completion: nil)
    }
    
    //MARK: TableView Methods
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1 + commentsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row == 0 {
            let mealCell = tableView.dequeueReusableCell(withIdentifier: "MealAndCommentsCell", for: indexPath) as! MealAndCommentsTableViewCell
            mealCell.delegate = self
            storeForMealCell = mealCell
            mealCell.nameTextField.delegate = self
            if let meal = meal {
                navigationItem.title = meal.name
                mealCell.nameTextField.text   = meal.name
                mealCell.photoImageView.image = meal.photo
                mealCell.ratingControl.rating = meal.rating
            }
            
            updateSaveButtonState()
            
            return mealCell
        } else {
            let commentCell = tableView.dequeueReusableCell(withIdentifier: "CommentsCell", for: indexPath) as! CommentsTableViewCell
            commentCell.commentTextLabel.text = commentsArray[indexPath.row - 1]
            commentCell.dateLabel.text = dateArray[indexPath.row - 1]
            return commentCell
        }
    }
    
    
    // Sendig Comment COMMENTS ARRAY
    var commentsArray: Array<String> = []
    var dateArray: Array<String> = []
    @IBAction func sendCommentButton(_ sender: UIButton) {
        
        if let nonNilText = commentTextField.text {
            
            let formatter = DateFormatter()
            formatter.dateFormat = "dd-MMM-yyyy HH:mm"
            let dateString = formatter.string(from: Date())
            dateArray.append(dateString)
            
            commentsArray.append(nonNilText)
            self.MealAndCommentsTableView.reloadData()
            commentTextField.resignFirstResponder()
        }
        commentTextField.text = ""
    }
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        commentTextField.delegate = self
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardNotification(notification:)), name: NSNotification.Name.UIKeyboardWillChangeFrame, object: nil)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    @objc func keyboardNotification(notification: NSNotification) {
        if let userInfo = notification.userInfo {
            let endFrame = (userInfo[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue
            let endFrameY = endFrame?.origin.y ?? 0
            let duration:TimeInterval = (userInfo[UIKeyboardAnimationDurationUserInfoKey] as? NSNumber)?.doubleValue ?? 0
            let animationCurveRawNSN = userInfo[UIKeyboardAnimationCurveUserInfoKey] as? NSNumber
            let animationCurveRaw = animationCurveRawNSN?.uintValue ?? UIViewAnimationOptions.curveEaseInOut.rawValue
            let animationCurve:UIViewAnimationOptions = UIViewAnimationOptions(rawValue: animationCurveRaw)
            if endFrameY >= UIScreen.main.bounds.size.height {
                self.keyboardHeightLayoutConstraint?.constant = 0.0
            } else {
                self.keyboardHeightLayoutConstraint?.constant = endFrame?.size.height ?? 0.0
            }
            UIView.animate(withDuration: duration, delay: TimeInterval(0), options: animationCurve, animations: { self.view.layoutIfNeeded() }, completion: nil)
        }
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? ZoomedMealViewController {
            destination.photoImage = storeForMealCell?.photoImageView.image
        }
        super.prepare(for: segue, sender: sender)
        //         Configure the destination view controller only when the save button is pressed.
        guard let button = sender as? UIBarButtonItem, button === saveButton else {
            os_log("The save button was not pressed, cancelling", log: OSLog.default, type: .debug)
            return
        }
        
        let name = storeForMealCell?.nameTextField.text ?? ""
        let photo = storeForMealCell?.photoImageView.image
        let rating = storeForMealCell?.ratingControl.rating
        
        // Set the meal to be passed to MealTableViewController after the unwind segue.
        meal = Meal(name: name, photo: photo, rating: rating!)
    }
    
    
    private func updateSaveButtonState() {
        let text = storeForMealCell?.nameTextField.text ?? ""
        saveButton.isEnabled = !text.isEmpty
    }
    
}

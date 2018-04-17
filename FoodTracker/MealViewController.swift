////
////  MealViewController.swift
////  FoodTracker
////
////  Created by Yaroslav Skachkov on 29.12.2017.
////  Copyright © 2017 Yaroslav Skachkov. All rights reserved.
////
//
//import UIKit
//import os.log
//
//// A delay function
//func delay(_ seconds: Double, completion: @escaping ()->Void) {
//    DispatchQueue.main.asyncAfter(deadline: .now() + seconds, execute: completion)
//}
//
//class MealViewController: UIViewController, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
//    
//    
//    
//    //MARK: Properties
//    
////    @IBOutlet weak var nameTextField: UITextField!
////    @IBOutlet weak var photoImageView: UIImageView!
////    @IBOutlet weak var ratingControl: RatingControl!
////    @IBOutlet weak var saveButton: UIBarButtonItem!
////    @IBOutlet weak var changePhotoButton: UIButton!
//    
//    
//    var meal: Meal?
//    
//    
//    //MARK: UITextFieldDelegate
//    
//    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
//        //Hide the keyboard
//        textField.resignFirstResponder()
//        return true
//    }
//    
//    func textFieldDidBeginEditing(_ textField: UITextField) {
//        saveButton.isEnabled = false
//    }
//    
//    func textFieldDidEndEditing(_ textField: UITextField) {
//        updateSaveButtonState()
//        navigationItem.title = textField.text
//    }
//    
//    
//    //MARK: UIImageControllerDelegate
//    
//    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
//        dismiss(animated: true, completion: nil)
//    }
//    
//    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
//        guard let selectedImage = info[UIImagePickerControllerOriginalImage] as? UIImage else {
//            fatalError("Expected a dictionary containin an image, but was provided the following: \(info)")
//        }
//        photoImageView.image = selectedImage
//        dismiss(animated: true, completion: nil)
//    }
//    
//    
//    //MARK: Navigation
//    
//    @IBAction func cancel(_ sender: UIBarButtonItem) {
//        
//        // Depending on style of presentation (modal or push presentation), this view controller needs to be dismissed in two different ways.
//        let isPresentingInAddMealMode = presentingViewController is UINavigationController
//        
//        if isPresentingInAddMealMode {
//            dismiss(animated: true, completion: nil)
//        } else if let owningNavigationController = navigationController{
//            owningNavigationController.popViewController(animated: true)
//        } else {
//            fatalError("The MealViewController is not inside a navigation controller.")
//        }
//    }
//    
//    
//    // This method lets you configure a view controller before it's presented.
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        
//        if let destination = segue.destination as? ZoomedMealViewController {
//            destination.photoImage = photoImageView.image
//        }
//        
//        super.prepare(for: segue, sender: sender)
//        // Configure the destination view controller only when the save button is pressed.
//        guard let button = sender as? UIBarButtonItem, button === saveButton else {
//            os_log("The save button was not pressed, cancelling", log: OSLog.default, type: .debug)
//            return
//        }
//        
//        let name = nameTextField.text ?? ""
//        let photo = photoImageView.image
//        let rating = ratingControl.rating
//        
//        // Set the meal to be passed to MealTableViewController after the unwind segue.
//        meal = Meal(name: name, photo: photo, rating: rating)
//    }
//    
//    
//    //MARK: Actions
//
//    @IBAction func selectImageFromPhotoLibrary(_ sender: UIButton) {
//        nameTextField.resignFirstResponder()
//        let imagePickerController = UIImagePickerController()
//        imagePickerController.sourceType = .photoLibrary
//        imagePickerController.delegate = self
//        present(imagePickerController, animated: true, completion: nil)
//    }
//    
//    @IBAction func openZoomingController(_ sender: AnyObject) {
//        self.performSegue(withIdentifier: "zoomedVC", sender: nil)
//    }
//    
//    
//    //MARK: View Controller methods
//    
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(animated)
//        nameTextField.center.x  -= view.bounds.width
//        ratingControl.center.x -= view.bounds.width
//        photoImageView.center.x += view.bounds.width
//        changePhotoButton.center.x += view.bounds.width
//    }
//    
//    override func viewDidLayoutSubviews() {
//        super.viewDidLayoutSubviews()
//        nameTextField.center.x  -= view.bounds.width
//        ratingControl.center.x -= view.bounds.width
//        photoImageView.center.x += view.bounds.width
//        changePhotoButton.center.x += view.bounds.width
//    }
//    
//    override func viewDidAppear(_ animated: Bool) {
//        super.viewDidAppear(animated)
//        UIView.animate(withDuration: 0.3, delay: 0, options: [], animations: { self.nameTextField.center.x += self.view.bounds.width }, completion: nil)
//        UIView.animate(withDuration: 0.3, delay: 0, options: [], animations: { self.ratingControl.center.x += self.view.bounds.width }, completion: nil)
//        UIView.animate(withDuration: 0.3, delay: 0, options: [], animations: { self.photoImageView.center.x -= self.view.bounds.width }, completion: nil)
//        UIView.animate(withDuration: 0.3, delay: 0, options: [], animations: { self.changePhotoButton.center.x -= self.view.bounds.width }, completion: nil)
//        
//    }
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        // Do any additional setup after loading the view, typically from a nib.
//        
//        //Handle the text field's user input through delegate callbacks
//        nameTextField.delegate = self
//        
//        // Set up views if editing an existing Meal.
//        if let meal = meal {
//            navigationItem.title = meal.name
//            nameTextField.text   = meal.name
//            photoImageView.image = meal.photo
//            ratingControl.rating = meal.rating
//            
//        }
//        
//        // Enable the Save button only if the text field has a valid Meal name.
//        updateSaveButtonState()
//        
//    }
//    
//    override func didReceiveMemoryWarning() {
//        super.didReceiveMemoryWarning()
//        // Dispose of any resources that can be recreated.
//    }
//    
//    
//    //MARK: Private methods
//    
//    private func updateSaveButtonState() {
//        let text = nameTextField.text ?? ""
//        saveButton.isEnabled = !text.isEmpty
//    }
//    
//}
//

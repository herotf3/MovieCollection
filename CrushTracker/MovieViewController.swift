//
//  ViewController.swift
//  CrushTracker
//
//  Created by MacBook on 8/9/18.
//  Copyright © 2018 MacBook. All rights reserved.
//

import UIKit
import os.log

class MovieViewController: UIViewController,UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    //MARK: Properties
    var movie: Movie?
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var saveBtn: UIBarButtonItem!
    @IBOutlet weak var ratingControl: RatingControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        // Handle the text field’s user input through delegate callbacks.
        nameField.delegate=self
        //enable save btn only if name field is not empty
        updateSaveBtnState()
        
        //display movie data if existing (use case: view detail )
        if let movie=movie {
            navigationItem.title=movie.name
            nameField.text=movie.name
            photoImageView.image=movie.image
            ratingControl.rating=movie.rating
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    //MARK: Navigations
    // This method lets you configure a view controller before it's presented.
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        guard let button = sender as? UIBarButtonItem, button === saveBtn else {
            os_log("The save button was not pressed, cancelling", log: OSLog.default, type: .debug)
            return
        }
        //
        let name = nameField.text ?? ""
        let img = photoImageView.image
        let rating = ratingControl.rating
        // Set the meal to be passed to MealTableViewController after the unwind segue.
        movie=Movie(name: name, rating: rating, image: img)
        
    }
    
    //MARK: Actions
    @IBAction func btnReset(_ sender: UIButton) {
        nameField.text="Valena"
        
    }
    @IBAction func selectImageFromLib(_ sender: UITapGestureRecognizer) {
        //hide the keyboard
        nameField.resignFirstResponder()
        // UIImagePickerController is a view controller that lets a user pick media from their photo library.
        let imgPickerCtrl=UIImagePickerController()
        imgPickerCtrl.sourceType = .photoLibrary
        
        //Make sure ViewController is notified when the user picks an img
        imgPickerCtrl.delegate=self
        present(imgPickerCtrl, animated: true, completion: nil)
    }
    
    //On click Save
    @IBAction func saveNewMovie(_ sender: UIBarButtonItem) {
        print("Saved a movie!")
    }
    //Cancel action
    @IBAction func cancel(_ sender: UIBarButtonItem) {
        let isInAddMealMode = presentingViewController is UINavigationController
        
        if isInAddMealMode {
            dismiss(animated: true, completion: nil )
        }else {
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    //MARK: UITextFieldDelegate
    func textFieldShouldReturn(_ textField: UITextField) -> Bool{
        textField.resignFirstResponder()
        return true
    }
    func textFieldDidBeginEditing(_ textField: UITextField) {
        saveBtn.isEnabled=false
    }
    private func updateSaveBtnState(){
        //Disable save btn if nameField is empty
        let text=nameField.text ?? ""
        saveBtn.isEnabled = !text.isEmpty
    }
    func textFieldDidEndEditing(_ textField: UITextField){
        updateSaveBtnState()
        self.navigationItem.title=nameField.text
    }
    
    //MARK: UIPickerController delegate
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        guard let selectedImg=info[UIImagePickerControllerOriginalImage] as? UIImage
            else{
                fatalError("Expected a dictionary containing an img but was provided the following:\(info)")
        }
        
        photoImageView.image=selectedImg
        dismiss(animated: true, completion: nil)
    }
    
}


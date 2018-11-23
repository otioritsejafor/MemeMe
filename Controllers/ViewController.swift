//
//  ViewController.swift
//  imagePicker
//
//  Created by Oti Oritsejafor on 10/13/18.
//  Copyright © 2018 Magloboid. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    //MARK: Properties
    let memeTextDelegate = MemeTextFieldDelegate()
    
    
    // MARK: Outlets
    @IBOutlet weak var imagePickerView: UIImageView!
    @IBOutlet weak var pickImageButton: UIBarButtonItem!
    @IBOutlet weak var cameraButton: UIBarButtonItem!
    @IBOutlet weak var topText: UITextField!
    @IBOutlet weak var bottomText: UITextField!
    @IBOutlet weak var shareButton: UIBarButtonItem!
    
    // Adjust height based on screen size and orientation
    @IBOutlet weak var constraintHeight: NSLayoutConstraint!
    
    // Reference outlet for Tool Bar
    @IBOutlet weak var toolBar: UIToolbar!
    
    //Reference outlet for Navigation Bar
    @IBOutlet weak var navBar: UINavigationBar!
    
    
    //var meme: Meme?
    // MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.topText.delegate = self.memeTextDelegate
        self.bottomText.delegate = self.memeTextDelegate
        topText.placeholder = "TOP"
        bottomText.placeholder = "BOTTOM"
        
        topText.textAlignment = .center
        bottomText.textAlignment = .center
        
        topText.defaultTextAttributes = memeTextAttributes
        bottomText.defaultTextAttributes = memeTextAttributes
        
        self.tabBarController?.tabBar.isHidden = true
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
       //self.toolBar.isHidden = false
        super.viewWillAppear(animated)
        subscribeToKeyboardNotifications()
        cameraButton.isEnabled = UIImagePickerController.isSourceTypeAvailable(.camera)
        shareButton.isEnabled = (imagePickerView.image != nil)
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        unsubscribeFromKeyboardNotifications()
        self.tabBarController?.tabBar.isHidden = false
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        if UIDevice.current.orientation.isLandscape {
            self.toolBar.isHidden = true
        } else {
            self.toolBar.isHidden = false
        }
    }
    
    // MARK: Meme Text Delegate
    
    @IBAction func shareImage(_ sender: Any) {
        let memedImage = [generateMemedImage()]
        let activityVC = UIActivityViewController(activityItems: memedImage, applicationActivities: nil)
        activityVC.completionWithItemsHandler = { activity, success, items, error in
            self.save()
            self.dismiss(animated: true, completion: nil)
        }
        present(activityVC, animated: true, completion: nil)
        //self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func pickAnImageFromAlbum(_ sender: Any) {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .photoLibrary
        present(imagePicker, animated: true, completion: nil)
        
        
        //dismiss(animated: true, completion: nil)
    }
    
    @IBAction func pickAnImageFromCamera(_ sender: Any) {
        
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .camera
        present(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]){
        
        guard let image = info[.originalImage] as? UIImage else {
            fatalError("Expected a dictionary containing an image, but was provided the following: \(info)")
        }
        
        // Set photoImageView to display the selected image.
        imagePickerView.image = image
        imagePickerView.contentMode = .scaleAspectFit
        
        // Set the Image View's size depending on image height
        let ratio = image.size.width / image.size.height
        
        let newHeight = imagePickerView.frame.width / ratio
        constraintHeight.constant = newHeight
        view.layoutIfNeeded()
        
        
        
        // Dismiss the picker.
        dismiss(animated: true, completion: nil)
    }
    
    @objc func keyboardWillShow(_ notification: Notification) {
        
        if(view.frame.origin.y == 0) {
            view.frame.origin.y = -getKeyboardHeight(notification)
        }
    }
    
    @objc func keyboardWillHide(_ notification: Notification) {
        if(view.frame.origin.y != 0) {
            view.frame.origin.y = 0
        }
    }
    
    
    
    func getKeyboardHeight(_ notification: Notification)-> CGFloat {
        let userInfo = notification.userInfo
        let keyboardSize = userInfo![UIResponder.keyboardFrameEndUserInfoKey] as! NSValue
        return keyboardSize.cgRectValue.height
    }
    
    func subscribeToKeyboardNotifications() {
        
        
        NotificationCenter.default.addObserver(self, selector: #selector(ViewController.keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(ViewController.keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        
    }
    
    func unsubscribeFromKeyboardNotifications() {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
        
    }
    
    func save() {
        // Create the meme
        
        let memedImage = generateMemedImage()
        let meme = Meme(topText: topText.text!, bottomText: bottomText.text!, originalImage: imagePickerView.image!, memedImage: memedImage)
        
        // Add it to the memes array in the Application Delegate
        (UIApplication.shared.delegate as! AppDelegate).memes.append(meme)
    }
    
    func generateMemedImage() -> UIImage {
        
        // TODO: Hide toolbar and navbar
        self.toolBar.isHidden = true
        //        self.navBar.isHidden = true
        
        
        UIGraphicsBeginImageContext(self.view.frame.size)
        view.drawHierarchy(in: self.view.frame, afterScreenUpdates: true)
        let memedImage:UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        // Render view to an image
        
       // UIGraphicsBeginImageContext(self.view.frame.size)
        //view.drawHierarchy(in: self.view.frame, afterScreenUpdates: true)
        //view.drawHierarchy(in: self.imagePickerView.frame, afterScreenUpdates: true)
       // let memedImage:UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        
        self.toolBar.isHidden = false
        
        return memedImage
    }
    
    
    @objc func image(_ image: UIImage, didFinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer) {
        if let error = error {
            // we got back an error!
            showAlertWith(title: "Save error", message: error.localizedDescription)
        } else {
            showAlertWith(title: "Saved!", message: "Your image has been saved to your photos.")
        }
    }
    
    func showAlertWith(title: String, message: String){
        let ac = UIAlertController(title: title, message: message, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default))
        present(ac, animated: true)
    }
    
    
    
    
}



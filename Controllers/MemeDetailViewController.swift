//
//  MemeDetailViewController.swift
//  MemeMe
//
//  Created by Oti Oritsejafor on 11/22/18.
//  Copyright © 2018 Magloboid. All rights reserved.
//

import Foundation
import UIKit

class MemeDetailViewController: UIViewController {
    var meme: Meme!
    @IBOutlet weak var detailImageView: UIImageView!
    @IBOutlet weak var constraintHeight: NSLayoutConstraint!
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        let image = meme.memedImage
        
        detailImageView.image = image
        detailImageView.contentMode = .scaleAspectFit
        
        // Set the Image View's size depending on image height
        let ratio = image!.size.width / image!.size.height
        /*guard let ratio = info[.originalImage] as? UIImage else {
            fatalError("Expected a dictionary containing an image, but was provided the following: \(info)")
        }
        */
        let newHeight = detailImageView.frame.width / ratio
        constraintHeight.constant = newHeight
        view.layoutIfNeeded()
    }
}

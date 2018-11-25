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
    @IBOutlet weak var image: UIImage!
    @IBOutlet weak var constraintHeight: NSLayoutConstraint!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
    }
}

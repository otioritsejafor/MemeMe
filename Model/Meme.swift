//
//  Meme.swift
//  MemeMe
//
//  Created by Oti Oritsejafor on 11/17/18.
//  Copyright © 2018 Magloboid. All rights reserved.
//

import Foundation
import UIKit

struct Meme {
    var topText: String?
    var bottomText: String?
    var originalImage: UIImage?
    var memedImage: UIImage?
}

let memeTextAttributes:[NSAttributedString.Key: Any] = [
    NSAttributedString.Key(rawValue: NSAttributedString.Key.strokeColor.rawValue): UIColor.black,
    NSAttributedString.Key(rawValue: NSAttributedString.Key.foregroundColor.rawValue): UIColor.white,
    NSAttributedString.Key(rawValue: NSAttributedString.Key.font.rawValue): UIFont(name: "HelveticaNeue-CondensedBlack", size: 40)!,
    NSAttributedString.Key(rawValue: NSAttributedString.Key.strokeWidth.rawValue): -4.5 ]

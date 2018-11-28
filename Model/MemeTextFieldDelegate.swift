//
//  MemeTextFieldDelegate.swift
//  imagePicker
//
//  Created by Oti Oritsejafor on 10/23/18.
//  Copyright © 2018 Magloboid. All rights reserved.
//

import Foundation
import UIKit

class MemeTextFieldDelegate: NSObject, UITextFieldDelegate {

    
    var activeField: UITextField?
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let maxLength = 35
        let currentString: NSString = textField.text! as NSString
        let newString: NSString =
            currentString.replacingCharacters(in: range, with: string) as NSString
        return newString.length <= maxLength
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if(textField.text == (textField.placeholder)!) {
            textField.text = ""
        }
        activeField = textField
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        textField.resignFirstResponder()
        
        return true
    }
    
}

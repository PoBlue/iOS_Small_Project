//
//  textDelegate.swift
//  meme1.0
//
//  Created by blues on 15/8/21.
//  Copyright (c) 2015年 blues. All rights reserved.
//

import Foundation
import UIKit

class textDelegate: NSObject,UITextFieldDelegate {
    func textFieldShouldBeginEditing(textField: UITextField) -> Bool {
        if textField.text == "顶部"{
           isTop = true
        } else {
           isTop = false
        }
        
        return true
    }
    func textFieldDidBeginEditing(textField: UITextField) {
        textField.text = ""
    }
    func textFieldShouldReturn(textField: UITextField) -> Bool{
        textField.resignFirstResponder()
        return true
    }
}
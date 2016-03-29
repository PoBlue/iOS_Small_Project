//
//  Meme.swift
//  meme1.0
//
//  Created by blues on 15/8/22.
//  Copyright (c) 2015年 blues. All rights reserved.
//

import Foundation
import UIKit
class Meme {
    var topText: String!
    var bottomText: String!
    var original:UIImage!
    var memeImage:UIImage!
    init(toptext:String!,bottomtext:String!,Original:UIImage!,MemeImage:UIImage!){
        topText = toptext
        bottomText = bottomtext
        original = Original
        memeImage = MemeImage
    }
}
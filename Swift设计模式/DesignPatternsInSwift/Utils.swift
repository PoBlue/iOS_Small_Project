//
//  Utils.swift
//  DesignPatternsInSwift
//
//  Created by iosdev on 10/14/14.
//  Copyright (c) 2014 RepublicOfApps, LLC. All rights reserved.
//

import Foundation
import UIKit

class Utils {
  class func randomBetweenLower(lower: CGFloat, andUpper: CGFloat) -> CGFloat {
    return lower + CGFloat(arc4random_uniform(101)) / 100.0 * (andUpper - lower)
  }
}

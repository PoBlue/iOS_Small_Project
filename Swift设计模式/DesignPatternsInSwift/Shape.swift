//
//  Shape.swift
//  DesignPatternsInSwift
//
//  Created by Joel Shapiro on 9/23/14.
//  Copyright (c) 2014 RepublicOfApps, LLC. All rights reserved.
//

import Foundation
import UIKit

class Shape {
  var area: CGFloat { return 0 }
}

class SquareShape: Shape {
  var sideLength: CGFloat!
  override var area: CGFloat { return sideLength * sideLength }
}

class CircleShape: Shape {
  var diameter: CGFloat!
  override var area: CGFloat { return CGFloat(M_PI) * diameter * diameter / 4.0 }
}

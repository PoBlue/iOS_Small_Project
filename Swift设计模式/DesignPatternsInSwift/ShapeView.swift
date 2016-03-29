//
//  ShapeView.swift
//  DesignPatternsInSwift
//
//  Created by Joel Shapiro on 9/23/14.
//  Copyright (c) 2014 RepublicOfApps, LLC. All rights reserved.
//

import Foundation
import UIKit

class ShapeView: UIView {
  var shape: Shape!

  var showFill: Bool = true {
    didSet {
      setNeedsDisplay()
    }
  }
  var fillColor: UIColor = UIColor.orangeColor() {
    didSet {
      setNeedsDisplay()
    }
  }

  var showOutline: Bool = true {
    didSet {
      setNeedsDisplay()
    }
  }
  var outlineColor: UIColor = UIColor.grayColor() {
    didSet {
      setNeedsDisplay()
    }
  }

  var tapHandler: ((ShapeView) -> ())?

  override init(frame: CGRect) {
    super.init(frame: frame)

    let tapRecognizer = UITapGestureRecognizer(target: self, action: Selector("handleTap"))
    addGestureRecognizer(tapRecognizer)
  }

  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  func handleTap() {
    tapHandler?(self)
  }

  let halfLineWidth: CGFloat = 3.0
}

class SquareShapeView: ShapeView {
  override func drawRect(rect: CGRect) {
    super.drawRect(rect)

    if showFill {
      fillColor.setFill()
      let fillPath = UIBezierPath(rect: bounds)
      fillPath.fill()
    }

    if showOutline {
      outlineColor.setStroke()
      let outlinePath = UIBezierPath(rect: CGRect(x: halfLineWidth, y: halfLineWidth, width: bounds.size.width - 2 * halfLineWidth, height: bounds.size.height - 2 * halfLineWidth))
      outlinePath.lineWidth = 2.0 * halfLineWidth
      outlinePath.stroke()
    }
  }
}

class CircleShapeView: ShapeView {
  override init(frame: CGRect) {
    super.init(frame: frame)
    self.opaque = false
    self.contentMode = UIViewContentMode.Redraw
  }

  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  override func drawRect(rect: CGRect) {
    super.drawRect(rect)

    if showFill {
      fillColor.setFill()
      let fillPath = UIBezierPath(ovalInRect: self.bounds)
      fillPath.fill()
    }

    if showOutline {
      outlineColor.setStroke()
      let outlinePath = UIBezierPath(ovalInRect: CGRect(x: halfLineWidth, y: halfLineWidth, width: self.bounds.size.width - 2 * halfLineWidth, height: self.bounds.size.height - 2 * halfLineWidth))
      outlinePath.lineWidth = 2.0 * halfLineWidth
      outlinePath.stroke()
    }
  }
}

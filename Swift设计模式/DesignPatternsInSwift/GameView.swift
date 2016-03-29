//
//  GameView.swift
//  DesignPatternsInSwift
//
//  Created by Joel Shapiro on 9/23/14.
//  Copyright (c) 2014 RepublicOfApps, LLC. All rights reserved.
//

import Foundation
import UIKit

class GameView: UIView {
  var score: Int = 0 {
    didSet {
      scoreLabel.attributedText = attributedTextForScore(score)
      setNeedsLayout()
      setNeedsDisplay()
    }
  }
  let padding: CGFloat = 20.0

  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)

    backgroundColor = UIColor(red: 0x7c/255.0, green: 0xbb/255.0, blue: 0xf2/255.0, alpha: 1)

    scoreLabel = UILabel(frame: CGRectZero)
    scoreLabel.attributedText = attributedTextForScore(0)
    addSubview(scoreLabel)
    scoreLabel.sizeToFit()
  }

  override func layoutSubviews() {
    scoreLabel.sizeToFit()
    scoreLabel.center.x = bounds.size.width / 2.0
    scoreLabel.frame.origin.y = padding
  }

  func sizeAvailableForShapes() -> CGSize {
    let topY    = CGRectGetMaxY(scoreLabel.frame) + padding
    let bottomY = bounds.size.height - padding
    let leftX  = padding
    let rightX = bounds.size.width - padding
    let smallestDimension = min(rightX - leftX, (bottomY - topY - 2 * padding) / 2.0)
    return CGSize(width: smallestDimension, height: smallestDimension)
  }

  func addShapeViews(newShapeViews: (ShapeView, ShapeView)) {
    shapeViews?.0.removeFromSuperview()
    shapeViews?.1.removeFromSuperview()

    shapeViews = newShapeViews

    newShapeViews.0.center.x = bounds.size.width / 2.0
    newShapeViews.0.center.y = center.y - padding - newShapeViews.0.frame.size.height / 2.0
    addSubview(newShapeViews.0)

    newShapeViews.1.center.x = bounds.size.width / 2.0
    newShapeViews.1.center.y = center.y + padding + newShapeViews.1.frame.size.height / 2.0
    addSubview(newShapeViews.1)
  }

  private final func attributedTextForScore(aScore: Int) -> NSAttributedString? {
    return NSAttributedString(string: "Score: \(aScore)",
      attributes: [ NSFontAttributeName : UIFont.boldSystemFontOfSize(32),
        NSForegroundColorAttributeName : aScore < 0 ? UIColor.redColor() : UIColor.blackColor()])
  }

  private var scoreLabel: UILabel!
  private var shapeViews: (ShapeView, ShapeView)?
}

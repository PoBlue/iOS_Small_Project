//
//  ShapeViewBuilder.swift
//  DesignPatternsInSwift
//
//  Created by Joel Shapiro on 10/15/14.
//  Copyright (c) 2014 RepublicOfApps, LLC. All rights reserved.
//

import Foundation
import UIKit

class ShapeViewBuilder {
  var showFill  = true
  var fillColor = UIColor.orangeColor()

  var showOutline  = true
  var outlineColor = UIColor.grayColor()

  init(shapeViewFactory: ShapeViewFactory) {
    self.shapeViewFactory = shapeViewFactory
  }

  func buildShapeViewsForShapes(shapes: (Shape, Shape)) -> (ShapeView, ShapeView) {
    let shapeViews = shapeViewFactory.makeShapeViewsForShapes(shapes)
    configureShapeView(shapeViews.0)
    configureShapeView(shapeViews.1)
    return shapeViews
  }

  private func configureShapeView(shapeView: ShapeView) {
    shapeView.showFill  = showFill
    shapeView.fillColor = fillColor
    shapeView.showOutline  = showOutline
    shapeView.outlineColor = outlineColor
  }

  private var shapeViewFactory: ShapeViewFactory
}

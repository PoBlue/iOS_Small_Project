//
//  ShapeViewFactory.swift
//  DesignPatternsInSwift
//
//  Created by Joel Shapiro on 10/15/14.
//  Copyright (c) 2014 RepublicOfApps, LLC. All rights reserved.
//

import Foundation
import UIKit

// This is an example of the Abstract Factory pattern.
// http://en.wikipedia.org/wiki/Abstract_factory_pattern
protocol ShapeViewFactory {
  var size: CGSize { get set }
  func makeShapeViewsForShapes(shapes: (Shape, Shape)) -> (ShapeView, ShapeView)
}

class SquareShapeViewFactory: ShapeViewFactory {
  var size: CGSize

  init(size: CGSize) {
    self.size = size
  }

  func makeShapeViewsForShapes(shapes: (Shape, Shape)) -> (ShapeView, ShapeView) {
    let squareShape1 = shapes.0 as! SquareShape
    let shapeView1 = SquareShapeView(frame: CGRect(x: 0, y: 0, width: squareShape1.sideLength * size.width, height: squareShape1.sideLength * size.height))
    shapeView1.shape = squareShape1

    let squareShape2 = shapes.1 as! SquareShape
    let shapeView2 = SquareShapeView(frame: CGRect(x: 0, y: 0, width: squareShape2.sideLength * size.width, height: squareShape2.sideLength * size.height))
    shapeView2.shape = squareShape2

    return (shapeView1, shapeView2)
  }
}

class CircleShapeViewFactory: ShapeViewFactory {
  var size: CGSize

  init(size: CGSize) {
    self.size = size
  }

  func makeShapeViewsForShapes(shapes: (Shape, Shape)) -> (ShapeView, ShapeView) {
    let circleShape1 = shapes.0 as! CircleShape
    let shapeView1 = CircleShapeView(frame: CGRect(x: 0, y: 0, width: circleShape1.diameter * size.width, height: circleShape1.diameter * size.height))
    shapeView1.shape = circleShape1

    let circleShape2 = shapes.1 as! CircleShape
    let shapeView2 = CircleShapeView(frame: CGRect(x: 0, y: 0, width: circleShape2.diameter * size.width, height: circleShape2.diameter * size.height))
    shapeView2.shape = circleShape2

    return (shapeView1, shapeView2)
  }
}

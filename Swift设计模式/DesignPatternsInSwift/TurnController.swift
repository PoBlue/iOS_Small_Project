//
//  TurnController.swift
//  DesignPatternsInSwift
//
//  Created by Joel Shapiro on 10/15/14.
//  Copyright (c) 2014 RepublicOfApps, LLC. All rights reserved.
//

import Foundation

class TurnController {
  var currentTurn: Turn?
  var pastTurns: [Turn] = [Turn]()

  init(turnStrategy: TurnStrategy) {
    self.turnStrategy = turnStrategy
    scorer = MatchScorer()
    scorer.nextScorer = StreakScorer()
  }

  func beginNewTurn() -> (ShapeView, ShapeView) {
    let shapeViews = turnStrategy.makeShapeViewsForNextTurnGivenPastTurns(pastTurns)
    currentTurn = Turn(shapes: [shapeViews.0.shape, shapeViews.1.shape])
    return shapeViews
  }

  func endTurnWithTappedShape(tappedShape: Shape) -> Int {
    currentTurn!.turnCompletedWithTappedShape(tappedShape)
    pastTurns.append(currentTurn!)

    let scoreIncrement = scorer.computeScoreIncrement(Array(pastTurns.reverse()))

    return scoreIncrement
  }

  private let turnStrategy: TurnStrategy
  private let scorer: Scorer
}

//
//  Scorer.swift
//  DesignPatternsInSwift
//
//  Created by Joel Shapiro on 10/16/14.
//  Copyright (c) 2014 RepublicOfApps, LLC. All rights reserved.
//

import Foundation

protocol Scorer {
  func computeScoreIncrement<S: SequenceType where Turn == S.Generator.Element>(pastTurnsReversed: S) -> Int
  var nextScorer: Scorer? { get set }
}

class MatchScorer: Scorer {
  var nextScorer: Scorer? = nil

  func computeScoreIncrement<S : SequenceType where Turn == S.Generator.Element>(pastTurnsReversed: S) -> Int {
    var scoreIncrement: Int?
    for turn in pastTurnsReversed {
      if scoreIncrement == nil {
        scoreIncrement = turn.matched! ? 1 : -1
        break
      }
    }

    return (scoreIncrement ?? 0) + (nextScorer?.computeScoreIncrement(pastTurnsReversed) ?? 0)
  }
}

class StreakScorer: Scorer {
  var nextScorer: Scorer? = nil

  func computeScoreIncrement<S : SequenceType where Turn == S.Generator.Element>(pastTurnsReversed: S) -> Int {
    var streakLength = 0
    for turn in pastTurnsReversed {
      if turn.matched! {
        ++streakLength
      } else {
        break
      }
    }

    let streakBonus = streakLength >= 5 ? 10 : 0
    return streakBonus + (nextScorer?.computeScoreIncrement(pastTurnsReversed) ?? 0)
  }
}

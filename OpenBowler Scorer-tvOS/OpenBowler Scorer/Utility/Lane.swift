//
//  Lane.swift
//  OpenBowler Scorer
//
//  Created by Ethan Hanlon on 7/6/21.
//

import Foundation

struct Lane {
    /// The current game, if there is one
    var currentGame: Game?
    /// Whether or not the lane is currently active (ie displaying a game)
    var isActive: Bool
    /// Whether or not a service call is active
    var isServiceCall: Bool
}

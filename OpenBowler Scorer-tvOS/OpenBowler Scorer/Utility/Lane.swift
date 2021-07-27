//
//  Lane.swift
//  OpenBowler Scorer
//
//  Created by Ethan Hanlon on 7/6/21.
//

import Foundation

/// Contains info on the state of the current game
struct Lane {
    /// The current game, if there is one
    var currentGame: Game?
    /// Whether or not the lane is currently active (ie displaying a game)
    var isActive: Bool
    /// Whether or not a service call is active
    var isServiceCall: Bool
    
    func testGame() -> Game {
        return Game(players: [
            Player(name: "John Doe", currentFrame: 1, currentScore: 0, cumulativeScore: 0),
            Player(name: "Jane Doe", currentFrame: 1, currentScore: 0, cumulativeScore: 0)
        ], currentPlayer: 0, gamesRemaining: 2.0)
    }
    
    mutating func startGame() {
        self.currentGame = testGame()
        self.isActive = true
    }
}

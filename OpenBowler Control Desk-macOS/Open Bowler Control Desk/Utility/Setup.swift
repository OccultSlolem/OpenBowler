//
//  Setup.swift
//  Open Bowler Control Desk
//
//  Created by Ethan Hanlon on 7/29/21.
//

import Foundation

/// Contains methods to get the setup of the bowling alley (for example, how many lanes the facility has)
struct Setup {
    // TODO: Pull from OpenBowler Back Desk
    // Debug value
    static private var numLanes = 32
    
    /// Returns the number of lanes that are physically present in the facility
    /// - Returns: Number of lanes the facility has
    static func getLanes() -> Int {
        return numLanes
    }
}

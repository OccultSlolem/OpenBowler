//
//  Lane.swift
//  Open Bowler Control Desk
//
//  Created by Ethan Hanlon on 7/29/21.
//

import Foundation

enum PinStatus {
    /// Pin is standing
    case standing
    /// Pin was knocked down in the first frame
    case knockedDownFirst
    /// Pin was knocked down in the second frame
    case knockedDownSecond
    /// Generic pin knocked down status, useful for non-10 pin bowling situations
    case knockedDown
}

// MARK: - Lane
/// Contains the information for a lane
class Lane {
    
    // MARK: - Initializers
    /// Initializes a lane
    /// - Parameters:
    ///   - laneNumber: Lane number
    ///   - isGameActive: Whether or not a game is currently active on this lane
    ///   - isPinsetterActive: Whether or not the pinsetter on this lane is active
    ///   - isServiceCall: Whether or not there is a service call from this lane
    ///   - numGames: The number of games on this lane. 0.1 games = 1 frame. 1.0 games = 10 frames. Make sure this is set proportional to the desired number of players and rounds for this lane
    ///   - maxPlayers: The maximum number of players allowed on this lane
    ///   - players: Array of players on this lane
    ///   - crosslaneWith: Lane that this lane is crossed with, if any
        init(laneNumber: Int, isGameActive: Bool, isPinsetterActive: Bool, isServiceCall: Bool, numGames: Double, maxPlayers: Int, players: [Player], crosslaneWith: Int? = nil) {
        self.laneNumber = laneNumber
        self.isGameActive = isGameActive
        self.isPinsetterActive = isPinsetterActive
        self.isServiceCall = isServiceCall
        self.numGames = numGames
        self.maxPlayers = maxPlayers
        self.players = players
        self.crosslaneWith = crosslaneWith
    }
    
    /// Initializes a lane with default values
    /// - Parameter laneNumber: Lane number
    convenience init(laneNumber: Int) {
        self.init(laneNumber: laneNumber, isGameActive: false, isPinsetterActive: false, isServiceCall: false, numGames: 0.0, maxPlayers: 0, players: [], crosslaneWith: nil)
    }
    
    // MARK: Values
    /// Number of lanes physically present in the facility
    // This is a debug value
    static var numLanes = 32
    // Refer to memberwise initializer for value definitions
    private var laneNumber: Int
    private var isGameActive: Bool
    private var isPinsetterActive: Bool
    private var isServiceCall: Bool
    private var numGames: Double
    private var maxPlayers: Int
    private var players: [Player]
    private var crosslaneWith: Int?
    
    // MARK: - Functions
    
    /// Resets the lane, clearing any games and players on it
    func reset() {
        isGameActive = false
        isPinsetterActive = false
        isServiceCall = false
        numGames = 0.0
        maxPlayers = 0
        players = []
        crosslaneWith = nil
    }
    
    /// Starts a game with the given number of games and max players
    /// - Parameters:
    ///   - maximumPlayers: The maximum number of players the customer can add on
    ///   - games: The number of games on this lane
    func startGame(maximumPlayers: Int, games: Double) {
        reset()
        
        self.maxPlayers = maximumPlayers
        self.numGames = games
    }
    
    
    // MARK: Getters
    
    /// Returns the lane number
    /// - Returns: Lane number
    func getLaneNumber() -> Int {
        return self.laneNumber
    }
    
    /// Returns if there is an active game on this lane.
    /// - Returns: True if there is an active game on this lane, false otherwise.
    func getIsGameActive() -> Bool {
        return self.isGameActive
    }
    
    /// Returns if there is a service call on this lane.
    /// - Returns: True if there is a service call on this lane.
    func getIsServiceCall() -> Bool {
        return self.isGameActive
    }
    
    /// Returns the number of games.
    /// - Returns: The number of games.
    func getNumGames() -> Double {
        return self.numGames
    }
    
    /// Returns the players array.
    /// - Returns: An array containing all players
    func getPlayers() -> [Player] {
        return self.players
    }
    
    /// Returns a list of player names, ordered by game order
    /// - Returns: A list of player names
    func getPlayerNames() -> [String] {
        var returnValue = [String]()
        let sortedPlayers = players.sorted {
            $0.num < $1.num
        }
        for player in sortedPlayers {
            returnValue.append(player.name)
        }
        
        return returnValue
    }
    
    // MARK: Setters
    
    /// Sets crosslane with another lane. The target lane must be exactly one lane away from the current lane.
    /// - Parameter with: Lane to crosslane with.
    /// - Returns: True if the operation was successful, false otherwise.
    func setCrosslane(with: Int) -> Bool {
        // Check if lane is in facility           Check that target lane is exactly one lane away
        if (with > 0 && with <= Lane.numLanes) && (abs(with - laneNumber) == 1) {
            crosslaneWith = with
            return true
        }
        
        return false
    }
    
    /// Sets the maximum number of players on this lane. Returns a false value if there is not enough games for each player on this lane, but does not prevent the operation.
    /// - Parameter maximumPlayers: The maximum number of players to have on this lane.
    /// - Returns: True if there are enough games on this lane for each player to complete, false if there are not enough.
    func setMaxPlayers(maximumPlayers: Int) -> Bool {
        self.maxPlayers = maximumPlayers
        
        // If there is an imbalance of players and games
        // (ie there are not enough frames on this lane for each player to complete their games)
        // FIXME: This will probably be inaccurate if players were added on midway through the game
        if Double(maximumPlayers) / numGames != 0 {
            // The operator should see a warning message if a true value is returned
            return false
        }
        
        return true
    }
    
    /// Sets the amount of games to the desired value. Disables pinsetter if the number is less than or equal to 0.
    /// - Parameter num: Number of games on this lane.
    func setGames(num: Double) {
        // TODO: This should generate a receipt
        self.numGames = num
        
        if self.numGames <= 0 {
            setPinsetter(active: false)
        }
    }
    
    /// Disables service call
    func cancelServiceCall() {
        self.isServiceCall = false
    }
    
    /// Enable or disable the pinsetter, regardless if there is an active game or not.
    /// - Parameter active: True if you want the pinsetter turned on, false if you want it turned off.
    func setPinsetter(active: Bool) {
        self.isPinsetterActive = active
    }
    
    /// Disables crosslane
    func disableCrosslane() {
        crosslaneWith = nil
    }
    
}

// MARK: - Player
/// Stores info regarding a given player.
struct Player {
    /// Player name.
    var name: String
    /// Player order (a value of 2 would cause a player to go second in line).
    var num: Int
    /// Completed frames of the player. Call .length on this array to get the number of completed frames for this player.
    var completedFrames: [Frame]
}

// MARK: - Frame
/// Stores the scores for a given frame.
struct Frame {
    init(pins: [Pin]) {
        self.pins = pins
    }
    
    /// Sets up a default 10-pin bowling frame.
    init() {
        var pinSetup = [Pin]()
        
        for i in 0...9 {
            pinSetup[i] = Pin(number: i + 1, state: .standing)
        }
        
        self.pins = pinSetup
    }
    
    var pins: [Pin]
    
    
}

// MARK: - Pin
/// Stores the info for a given pin
struct Pin {
    var number: Int
    var state: PinStatus
}

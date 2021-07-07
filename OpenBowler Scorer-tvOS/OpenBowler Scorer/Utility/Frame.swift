//
//  Frame.swift
//  OpenBowler-tvOS
//
//  Created by Ethan Hanlon on 7/6/21.
//

import Foundation

struct Frame {
    /// Generates a fresh 10-pin bowling frame
    init(num: Int) {
        self.frameNum = num
        self.currentRoll = 1
        self.maxRolls = 2
        self.rollOneScore = 0
        self.rollTwoScore = 0
        self.rollThreeScore = 0
        self.isSplit = false
        self.isStrike = false
        self.isSpare = false
        
        var pinSetup = [Pin]()
        for index in 1...10 {
            pinSetup.insert(Pin(num: index), at: index)
        }
        self.pins = pinSetup
    }
    
    /// Frame number (ie, frame 1, frame 2, etc)
    private var frameNum: Int
    /// This will either be one if the frame is at the first roll, or two if the frame is at the second roll
    private var currentRoll: Int
    /// Maximum rolls. Default is two.
    private var maxRolls: Int
    /// Score of the first roll
    private var rollOneScore: Int
    /// Score of the second roll
    private var rollTwoScore: Int
    /// Score of the third roll. Should only be set if this is the tenth frame.
    private var rollThreeScore: Int
    /// Set to true if first roll resulted in a split
    private var isSplit: Bool
    /// Set to true if frame is a strike
    private var isStrike: Bool
    /// Set to true if frame is a spare
    private var isSpare: Bool
    /// This array contains all the pins of the frame
    private var pins: [Pin]
    
    /// Knocks down the specified pins.
    /// - Returns Whether or not the operation was succesful
    /// - Parameter knockedDown:knockedDown should be an integer array with the pins to be knocked down - for example, if the player knocked down the 3,4,5, and 10 pins, the parameter should be [3,4,5,10]
    mutating func roll(knockedDown: [Int]) -> Bool {
        for pin in knockedDown {
            // Make sure that the index is not out of range
            // Subtract pin by one because we are going by pin number, not array index
            if pins.indices.contains(pin - 1) {
                self.pins[pin - 1].knockedDown = true
            } else {
                print("Tried to roll for a pin that doesn't exist!")
                return false
            }
        }
        
        return true
    }
    
    // Mostly just getters at this point
    /// Returns the frame number
    func getFrameNumber() -> Int {
        return frameNum
    }
    
    func getPin(num: Int) -> Pin? {
        for pin in pins {
            return pin
        }
        
        return nil
    }
    
    /// Returns the given frame score
    /// - Parameter frame: Should be 1, 2, or 3.
    /// - Returns: Returns the roll for the corresponding score. Will return -1 for values out of range.
    func getFrameScore(frame: Int) -> Int {
        switch frame {
        case 1:
            return rollOneScore
        case 2:
            return rollTwoScore
        case 3:
            return rollThreeScore
        default:
            return -1
        }
    }
    
    /// Returns whether or not the first roll is a split
    func getIsSplit() -> Bool {
        return isSplit
    }
    
    /// Returns whether or not the frame resulted in a strike
    func getIsStrike() -> Bool {
        return isStrike
    }
    
    /// Returns whether or not the frame resulted in a spare
    func getIsSpare() -> Bool {
        return isSpare
    }
    
    /// Returns the pins array
    func getPins() -> [Pin] {
        return pins
    }
}

struct Pin {
    init(num: Int) {
        self.init(num: num, knockedDown: false)
    }
    
    init(num: Int, knockedDown: Bool) {
        self.num = num
        self.knockedDown = knockedDown
    }
    
    /// Pin number
    var num: Int
    /// Whether or not the pin has been knocked down
    var knockedDown: Bool
}

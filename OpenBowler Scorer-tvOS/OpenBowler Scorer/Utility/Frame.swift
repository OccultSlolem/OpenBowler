//
//  Frame.swift
//  OpenBowler-tvOS
//
//  Created by Ethan Hanlon on 7/6/21.
//
//  The reason this is a class is because nonstandard frames like 9-tap will inherit from this class

import Foundation


/// Represents a frame of 10-pin bowling
class Frame {
    /// Generates a fresh 10-pin bowling frame
    init(num: Int) {
        self.frameNum = num
        self.currentRoll = 1
        self.maxRolls = 2
        self.scores = [Int]()
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
    /// Int array containing the scores of the frame. Indexes are in order of rolls.
    private var scores: [Int]
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
    func roll(knockedDown: [Int]) -> Bool {
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
        scores.append(knockedDown.count)
        currentRoll += 1
        return true
    }
    
    
    // Mostly just getters at this point
    /// Returns the frame number
    func getFrameNumber() -> Int {
        return frameNum
    }
    
    
    /// Returns the specified pin
    /// - Parameter pinNumber: The number of the pin to return (ie a value of 5 would return the 5 pin)
    /// - Returns: The pin specified with pinNumber
    func getPin(pinNumber: Int) -> Pin {
        pins.sort {
            $0.num < $1.num
        }
        return pins[pinNumber]
    }
    
    /// Returns the scores for the frame
    func getFrameScore() -> [Int] {
        return scores
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

class Pin {
    convenience init(num: Int) {
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

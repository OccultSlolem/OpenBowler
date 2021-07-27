//
//  AuthService.swift
//  Open Bowler Control Desk
//
//  Created by Ethan Hanlon on 7/27/21.
//

import Foundation
import LocalAuthentication

class AuthService {
    /// LocalAuthentication context
    static let context = LAContext()
    
    /// This will be true if Touch ID is available on the host system
    static var biometricsAvailable: Bool {
        var error: NSError?
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            return true
        }
        return false
    }
    
    /// Attempt to verify the user with biometrics
    /// - Parameter completionHandler: Completion handler. Bool will be true if successful.
    static func authenticateUserWithBiometrics(completionHandler: @escaping (Bool) -> Void) {
        var error: NSError?
        
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            let reason = "sign in using Touch ID/Face ID"
            
            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { success, authError in
                DispatchQueue.main.async {
                    if success {
                        completionHandler(true)
                    } else {
                        completionHandler(false)
                    }
                }
            }
        }
    }
}

//
//  AuthView.swift
//  Open Bowler Control Desk
//
//  Created by Ethan Hanlon on 7/7/21.
//

import SwiftUI

struct AuthView: View {
    @State private var username = ""
    @State private var password = ""
    
    var body: some View {
        VStack {
            Spacer()
            
            Text("OpenBowler")
                .font(.largeTitle)
                .fontWeight(.ultraLight)
                
            // Username
            CustomStyledTextField(text: $username, placeholder: "Username", symbolName: "person.circle", isSecure: false)
            
            // Password
            CustomStyledTextField(text: $password, placeholder: "Password", symbolName: "lock.circle", isSecure: true)
            
            Button(action: {
                // TODO: Implement username/password sign in
            }, label: {
                Text("Log in")
            })
            
            Group {
                // Detect Touch ID Availability
                if AuthService.biometricsAvailable {
                    Button(action: {
                        // Show Touch ID Prompt
                        AuthService.authenticateUserWithBiometrics { success in
                            if success {
                                // TODO
                                print(":)")
                            } else {
                                // TODO
                                print(":(")
                            }
                        }
                    }, label: {
                        Image(systemName: "touchid")
                        Text("Touch ID")
                    })
                        .padding(.top)
                }
                Spacer()
            }
            
            Divider()
            
            Text("© 2021 Ethan Hanlon")
                .padding(.bottom)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

struct AuthView_Previews: PreviewProvider {
    static var previews: some View {
        AuthView()
            .previewDevice(PreviewDevice(rawValue: "Mac"))
    }
}

//
//  CustomStyledTextField.swift
//  Open Bowler Control Desk
//
//  Created by Ethan Hanlon on 7/7/21.
//

import SwiftUI

struct CustomStyledTextField: View {
    @Binding var text: String
    let placeholder: String
    let symbolName: String
    let isSecure: Bool
    
    var body: some View {
        HStack {
            Image(systemName: symbolName)
                .padding(.leading)
            if isSecure {
                SecureField(placeholder, text: $text)
                    .padding(.vertical)
                    .accentColor(.blue)
                    .disableAutocorrection(true)
            } else {
                TextField(placeholder, text: $text)
                    .padding(.vertical)
                    .accentColor(.blue)
                    .disableAutocorrection(true)
            }
        }
        .padding(.trailing)
    }
}

struct CustomStyledTextField_Previews: PreviewProvider {
    @State static var text = String()
    static var previews: some View {
        CustomStyledTextField(text: $text, placeholder: "Username", symbolName: "person.circle", isSecure: false)
    }
}

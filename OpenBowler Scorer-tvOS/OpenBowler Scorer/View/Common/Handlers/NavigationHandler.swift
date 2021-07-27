//
//  NavigationHandler.swift
//  OpenBowler Scorer
//
//  Created by Ethan Hanlon on 7/7/21.
//

import SwiftUI

/**
 * Put in the beginning of your view to handle navigation. Set the isActive parameter to true
 * to navigate to the view set in the view parameter
 */
struct NavigationHandler: View {
    /// View to push to
    @State var view: AnyView
    /// Set to true in order to push
    @State var isActive: Binding<Bool>
    
    var body: some View {
        NavigationLink(destination: view, isActive: isActive) {
            EmptyView()
        }
        .hidden()
    }
}

struct NavigationHandler_Previews: PreviewProvider {
    @State private static var isActive = Bool()
    static var previews: some View {
        NavigationHandler(view: AnyView(Text("OpenBowler")), isActive: $isActive)
    }
}

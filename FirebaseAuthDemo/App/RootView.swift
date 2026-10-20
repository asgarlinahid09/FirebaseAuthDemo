//
//  RootView.swift
//  FirebaseAuthDemo
//
//  Created by Nahid Askerli on 30.09.26.
//

import SwiftUI

struct RootView: View {
    @Environment(AuthService.self) private var authService
    @Environment(Router.self) private var router

    var body: some View {
        Group {
            if authService.userSession == nil {
                AuthFlowView()
            } else {
                ProfileView()
            }
        }
        .onChange(of: authService.userSession == nil) {
            router.navigateToRoot()
        }
    }
}

#Preview {
    RootView()
        .environment(AuthService())
        .environment(Router())
}

//
//  AuthFlowView.swift
//  FirebaseAuth
//
//  Created by Nahid Askerli on 08.10.26.
//

import SwiftUI

struct AuthFlowView: View {
    @Environment(Router.self) private var router
    var body: some View {
        @Bindable var router = router
        NavigationStack(path: $router.path) {
            LoginView()
                .navigationDestination(for: Router.AuthRoute.self) { destination in
                    switch destination {
                    case .createAccount:
                        CreateAccountView()
                    case .forgotPassword:
                        ForgotPasswordView()
                    case .emailSent:
                        EmailSentView()
                    }
                }
        }
    }
}

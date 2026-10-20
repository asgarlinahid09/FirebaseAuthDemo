//
//  LoginViewModel.swift
//  FirebaseAuthDemo
//
//  Created by Nahid Askerli on 14.10.26.
//

import Foundation

@MainActor
@Observable
final class LoginViewModel: AsyncActionHandling {
    var email: String = ""
    var password: String = ""
    var isLoading: Bool = false
    var errorMessage: String?

    var isFormValid: Bool {
        !email.trimmed.isEmpty && !password.isEmpty
    }

    func login(using authService: AuthService) async {
        await run {
            try await authService.login(email: email, password: password)
        }
    }

    func signInWithGoogle(using authService: AuthService) async {
        await run {
            try await authService.signInWithGoogle()
        }
    }
}

//
//  CreateAccountViewModel.swift
//  FirebaseAuthDemo
//
//  Created by Nahid Askerli on 15.10.26.
//

import Foundation

@MainActor
@Observable
final class CreateAccountViewModel: AsyncActionHandling {
    var email: String = ""
    var fullName: String = ""
    var password: String = ""
    var confirmPassword: String = ""
    var isLoading: Bool = false
    var errorMessage: String?

    var passwordsMatch: Bool {
        password == confirmPassword
    }

    var showsPasswordMatchIcon: Bool {
        !password.isEmpty && !confirmPassword.isEmpty
    }

    var isFormValid: Bool {
        passwordsMatch
            && !email.trimmed.isEmpty
            && !fullName.trimmed.isEmpty
            && password.count >= 6
    }

    func createAccount(using authService: AuthService) async {
        await run {
            try await authService.createUser(email: email, fullName: fullName, password: password)
        }
    }
}

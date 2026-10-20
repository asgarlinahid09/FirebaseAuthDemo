//
//  ForgotPasswordViewModel.swift
//  FirebaseAuthDemo
//
//  Created by Nahid Askerli on 14.10.26.
//

import Foundation

@MainActor
@Observable
final class ForgotPasswordViewModel: AsyncActionHandling {
    var email: String = ""
    var isLoading: Bool = false
    var errorMessage: String?

    var isFormValid: Bool {
        !email.trimmed.isEmpty
    }

    func sendResetLink(using authService: AuthService) async -> Bool {
        await run {
            try await authService.sendPasswordReset(to: email)
        }
    }
}

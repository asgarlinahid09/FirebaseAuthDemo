//
//  ProfileViewModel.swift
//  FirebaseAuthDemo
//
//  Created by Nahid Askerli on 15.10.26.
//

import Foundation

@MainActor
@Observable
final class ProfileViewModel: AsyncActionHandling {
    var isLoading: Bool = false
    var errorMessage: String?
    var showDeleteConfirmation: Bool = false

    func signOut(using authService: AuthService) {
        do {
            try authService.signOut()
        } catch {
            errorMessage = error.localizedDescription
        }
    }

    func deleteAccount(using authService: AuthService) async {
        await run {
            try await authService.deleteAccount()
        }
    }
}

//
//  ProfileView.swift
//  FirebaseAuthDemo
//
//  Created by Nahid Askerli on 05.10.26.
//

import SwiftUI

struct ProfileView: View {
    @State private var viewModel = ProfileViewModel()
    @Environment(AuthService.self) private var authService

    var body: some View {
        if let user = authService.currentUser {
            List {
                Section {
                    ProfileHeader(user: user)
                }

                Section("Account") {
                    signOutButton
                    deleteAccountButton
                }
            }
            .errorAlert(message: $viewModel.errorMessage)
            .alert("Delete Account", isPresented: $viewModel.showDeleteConfirmation) {
                Button("Delete", role: .destructive) {
                    Task { await viewModel.deleteAccount(using: authService) }
                }
                Button("Cancel", role: .cancel) { }
            } message: {
                Text("This action cannot be undone. All your data will be permanently deleted.")
            }
        } else {
            ProgressView("Please wait ...")
                .task { await authService.loadCurrentUser() }
        }
    }

    private var signOutButton: some View {
        Button {
            viewModel.signOut(using: authService)
        } label: {
            SettingsRow(title: "Sign Out", systemImage: "arrow.left.circle.fill", tint: .red)
        }
    }

    private var deleteAccountButton: some View {
        Button {
            viewModel.showDeleteConfirmation = true
        } label: {
            if viewModel.isLoading {
                ProgressView()
            } else {
                SettingsRow(title: "Delete Account", systemImage: "xmark.circle.fill", tint: .red)
            }
        }
        .disabled(viewModel.isLoading)
    }
}

private struct ProfileHeader: View {
    let user: AppUser

    var body: some View {
        HStack(spacing: 16) {
            Text(user.initials)
                .font(.subheadline)
                .fontWeight(.semibold)
                .foregroundStyle(.white)
                .frame(width: 70, height: 70)
                .background(Color(.systemGray))
                .clipShape(.circle)

            VStack(alignment: .leading, spacing: 4) {
                Text(user.fullName)
                    .font(.headline)
                    .fontWeight(.semibold)
                Text(user.email)
                    .font(.footnote)
                    .foregroundStyle(.secondary)
            }
        }
    }
}

#Preview {
    ProfileView()
        .environment(AuthService())
}

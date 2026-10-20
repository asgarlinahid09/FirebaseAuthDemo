//
//  CreateAccountView.swift
//  FirebaseAuthDemo
//
//  Created by Nahid Askerli on 01.10.26.
//

import SwiftUI

struct CreateAccountView: View {
    @State private var viewModel = CreateAccountViewModel()
    @Environment(AuthService.self) private var authService

    var body: some View {
        VStack(spacing: 16) {
            Text("Please complete all information to create an account")
                .font(.headline)
                .fontWeight(.medium)
                .foregroundStyle(.gray)
                .multilineTextAlignment(.center)
                .padding()

            InputView(placeholder: "Email", text: $viewModel.email)
            InputView(placeholder: "Full Name", kind: .name, text: $viewModel.fullName)
            InputView(placeholder: "Password", kind: .newPassword, text: $viewModel.password)
            InputView(placeholder: "Confirm your password", kind: .newPassword, text: $viewModel.confirmPassword)
                .overlay(alignment: .topTrailing) {
                    if viewModel.showsPasswordMatchIcon {
                        PasswordMatchIcon(isMatching: viewModel.passwordsMatch)
                    }
                }

            Spacer()

            PrimaryButton(title: "Create Account", isLoading: viewModel.isLoading) {
                await viewModel.createAccount(using: authService)
            }
            .disabled(!viewModel.isFormValid)
        }
        .padding()
        .navigationTitle("Set up your account")
        .errorAlert(message: $viewModel.errorMessage)
    }
}

private struct PasswordMatchIcon: View {
    let isMatching: Bool

    var body: some View {
        Image(systemName: isMatching ? "checkmark.circle.fill" : "xmark.circle.fill")
            .imageScale(.large)
            .fontWeight(.bold)
            .foregroundStyle(isMatching ? Color(.systemGreen) : Color(.systemRed))
    }
}

#Preview {
    NavigationStack {
        CreateAccountView()
    }
    .environment(AuthService())
}

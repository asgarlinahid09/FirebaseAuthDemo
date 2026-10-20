//
//  ForgotPasswordView.swift
//  FirebaseAuthDemo
//
//  Created by Nahid Askerli on 07.10.26.
//

import SwiftUI

struct ForgotPasswordView: View {
    @State private var viewModel = ForgotPasswordViewModel()
    @Environment(AuthService.self) private var authService
    @Environment(Router.self) private var router

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            ScreenHeader(
                title: "Reset Password",
                subtitle: "Enter the email associated with your account and we'll send an email with instructions to reset your password"
            )
            .padding(.bottom, 32)

            InputView(placeholder: "Enter your email", text: $viewModel.email)
                .padding(.bottom, 16)

            PrimaryButton(title: "Send Instructions", isLoading: viewModel.isLoading) {
                if await viewModel.sendResetLink(using: authService) {
                    router.navigate(to: .emailSent)
                }
            }
            .disabled(!viewModel.isFormValid)

            Spacer()
        }
        .padding()
        .toolbarRole(.editor)
        .errorAlert(message: $viewModel.errorMessage)
        .onAppear {
            viewModel.email = ""
        }
    }
}

#Preview {
    ForgotPasswordView()
        .environment(AuthService())
        .environment(Router())
}

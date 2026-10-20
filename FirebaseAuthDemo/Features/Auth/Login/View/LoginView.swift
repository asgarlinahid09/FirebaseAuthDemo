//
//  LoginView.swift
//  FirebaseAuthDemo
//
//  Created by Nahid Askerli on 30.09.26.
//

import SwiftUI

struct LoginView: View {

    @State private var viewModel = LoginViewModel()
    @Environment(AuthService.self) private var authService
    @Environment(Router.self) private var router

    var body: some View {
        ScrollView {
            VStack(spacing: 16) {
                logo
                titleView
                InputView(placeholder: "Email", text: $viewModel.email)
                InputView(placeholder: "Password", kind: .password, text: $viewModel.password)
                forgotPasswordButton
                loginButton
                OrDivider()
                appleButton
                googleButton
                footerView
            }
        }
        .scrollDismissesKeyboard(.interactively)
        .ignoresSafeArea(edges: .top)
        .padding(.horizontal)
        .padding(.vertical, 8)
        .errorAlert(message: $viewModel.errorMessage)
    }

    private var logo: some View {
        Image("login_image")
            .resizable()
            .scaledToFit()
    }

    private var titleView: some View {
        Text("Let's Connect With Us!")
            .font(.title2)
            .fontWeight(.semibold)
            .padding(.bottom, 12)
    }

    private var forgotPasswordButton: some View {
        Button("Forgot Password?") {
            router.navigate(to: .forgotPassword)
        }
        .font(.subheadline)
        .fontWeight(.medium)
        .foregroundStyle(.gray)
        .frame(maxWidth: .infinity, alignment: .trailing)
    }

    private var loginButton: some View {
        PrimaryButton(title: "Login", isLoading: viewModel.isLoading) {
            await viewModel.login(using: authService)
        }
        .disabled(!viewModel.isFormValid)
    }

    private var appleButton: some View {
        Button {
            
        } label: {
            Label("Continue with Apple", systemImage: "apple.logo")
        }
        .buttonStyle(.capsule(background: .primary, text: Color(.systemBackground)))
    }

    private var googleButton: some View {
        Button {
            Task { await viewModel.signInWithGoogle(using: authService) }
        } label: {
            HStack {
                Image("google_logo")
                    .resizable()
                    .frame(width: 15, height: 15)
                Text("Continue with Google")
            }
        }
        .buttonStyle(.capsule(background: .white, text: .black, hasBorder: true))
        .disabled(viewModel.isLoading)
    }

    private var footerView: some View {
        Button {
            router.navigate(to: .createAccount)
        } label: {
            Text("Don't have an account? \(Text("Sign up").foregroundStyle(.brand))")
                .foregroundStyle(Color.primary)
                .fontWeight(.medium)
        }
    }
}

#Preview {
    LoginView()
        .environment(AuthService())
        .environment(Router())
}

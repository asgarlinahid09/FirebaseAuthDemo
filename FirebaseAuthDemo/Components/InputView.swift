//
//  InputView.swift
//  FirebaseAuthDemo
//
//  Created by Nahid Askerli on 01.10.26.
//

import SwiftUI

struct InputView: View {
    enum Kind {
        case email
        case name
        case password
        case newPassword
    }

    let placeholder: String
    var kind: Kind = .email
    @Binding var text: String

    var body: some View {
        VStack(spacing: 12) {
            field
            Rectangle()
                .frame(height: 1)
                .foregroundStyle(Color(.systemGray3))
        }
    }

    @ViewBuilder
    private var field: some View {
        switch kind {
        case .email:
            TextField(placeholder, text: $text)
                .keyboardType(.emailAddress)
                .textContentType(.emailAddress)
                .textInputAutocapitalization(.never)
                .autocorrectionDisabled()
        case .name:
            TextField(placeholder, text: $text)
                .textContentType(.name)
                .textInputAutocapitalization(.words)
        case .password:
            SecureField(placeholder, text: $text)
                .textContentType(.password)
        case .newPassword:
            SecureField(placeholder, text: $text)
                .textContentType(.newPassword)
        }
    }
}

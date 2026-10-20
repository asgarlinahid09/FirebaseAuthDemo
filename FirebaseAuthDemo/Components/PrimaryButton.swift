//
//  PrimaryButton.swift
//  FirebaseAuthDemo
//
//  Created by Nahid Askerli on 16.10.26.
//

import SwiftUI

struct PrimaryButton: View {
    let title: String
    var isLoading: Bool = false
    let action: @MainActor () async -> Void

    var body: some View {
        Button {
            Task { await action() }
        } label: {
            ZStack {
                Text(title)
                    .opacity(isLoading ? 0 : 1)
                if isLoading {
                    ProgressView()
                        .tint(.white)
                }
            }
        }
        .buttonStyle(.capsule)
        .disabled(isLoading)
    }
}

#Preview {
    VStack {
        PrimaryButton(title: "Login") { }
        PrimaryButton(title: "Login", isLoading: true) { }
        PrimaryButton(title: "Login") { }
            .disabled(true)
    }
    .padding()
}

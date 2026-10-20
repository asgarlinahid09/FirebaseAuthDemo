//
//  ScreenHeader.swift
//  FirebaseAuthDemo
//
//  Created by Nahid Askerli on 19.10.26.
//

import SwiftUI

struct ScreenHeader: View {
    let title: String
    let subtitle: String
    var alignment: HorizontalAlignment = .leading

    var body: some View {
        VStack(alignment: alignment, spacing: 8) {
            Text(title)
                .font(.largeTitle)
            Text(subtitle)
                .font(.subheadline)
                .foregroundStyle(.secondary)
        }
        .multilineTextAlignment(alignment == .center ? .center : .leading)
    }
}

#Preview {
    ScreenHeader(title: "Reset Password", subtitle: "Enter the email associated with your account")
}

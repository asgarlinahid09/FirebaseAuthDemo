//
//  OrDivider.swift
//  FirebaseAuthDemo
//
//  Created by Nahid Askerli on 19.10.26.
//

import SwiftUI

struct OrDivider: View {
    var text: String = "Or"

    var body: some View {
        HStack(spacing: 10) {
            line
            Text(text)
                .fontWeight(.semibold)
            line
        }
    }

    private var line: some View {
        Rectangle()
            .frame(height: 1)
            .foregroundStyle(Color.primary)
    }
}

#Preview {
    OrDivider()
        .padding()
}

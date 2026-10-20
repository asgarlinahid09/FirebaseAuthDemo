//
//  SettingsRow.swift
//  FirebaseAuthDemo
//
//  Created by Nahid Askerli on 19.10.26.
//

import SwiftUI

struct SettingsRow: View {
    let title: String
    let systemImage: String
    var tint: Color = .accentColor

    var body: some View {
        Label {
            Text(title)
                .foregroundStyle(Color.primary)
        } icon: {
            Image(systemName: systemImage)
                .foregroundStyle(tint)
        }
    }
}

#Preview {
    List {
        SettingsRow(title: "Sign Out", systemImage: "arrow.left.circle.fill", tint: .red)
    }
}

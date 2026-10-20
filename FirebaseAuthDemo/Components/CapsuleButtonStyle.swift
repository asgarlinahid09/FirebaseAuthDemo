//
//  CapsuleButtonStyle.swift
//  FirebaseAuth
//
//  Created by Nahid Askerli on 01.10.26.
//

import SwiftUI

struct CapsuleButtonStyle: ButtonStyle {
    var backgroundColor: Color = .brand
    var textColor: Color = .white
    var hasBorder: Bool = false

    func makeBody(configuration: Configuration) -> some View {
        CapsuleButtonBody(
            configuration: configuration,
            backgroundColor: backgroundColor,
            textColor: textColor,
            hasBorder: hasBorder
        )
    }
}

private struct CapsuleButtonBody: View {
    let configuration: ButtonStyleConfiguration
    let backgroundColor: Color
    let textColor: Color
    let hasBorder: Bool

    @Environment(\.isEnabled) private var isEnabled

    var body: some View {
        configuration.label
            .foregroundStyle(textColor)
            .padding()
            .frame(maxWidth: .infinity)
            .background(Capsule().fill(backgroundColor))
            .overlay {
                if hasBorder {
                    Capsule().stroke(.gray, lineWidth: 1)
                }
            }
            .contentShape(Capsule())
            .scaleEffect(configuration.isPressed ? 0.95 : 1)
            .opacity(isEnabled ? 1 : 0.5)
            .animation(.easeOut(duration: 0.15), value: configuration.isPressed)
    }
}

extension ButtonStyle where Self == CapsuleButtonStyle {
    static var capsule: CapsuleButtonStyle { CapsuleButtonStyle() }

    static func capsule(background: Color, text: Color, hasBorder: Bool = false) -> CapsuleButtonStyle {
        CapsuleButtonStyle(backgroundColor: background, textColor: text, hasBorder: hasBorder)
    }
}

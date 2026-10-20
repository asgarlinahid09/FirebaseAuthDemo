//
//  EmailSentView.swift
//  FirebaseAuth
//
//  Created by Nahid Askerli on 07.10.26.
//

import SwiftUI

struct EmailSentView: View {
    @Environment(Router.self) private var router
   

    var body: some View {
        VStack(spacing: 24) {
            Spacer()

            Image(systemName: "envelope.fill")
                .resizable()
                .scaledToFit()
                .frame(width: 100, height: 100)
                .foregroundStyle(.brand)

            ScreenHeader(
                title: "Check your email",
                subtitle: "We have sent password recovery instructions to your email",
                alignment: .center
            )

            Button("I'll confirm later") {
                router.navigateToRoot()
            }
            .buttonStyle(.capsule)

            Spacer()

            Button {
                router.navigateBack()
                
            } label: {
                Text("Did not receive the email? Check your spam filter, or \(Text("try another email address").foregroundStyle(.brand))")
                    .foregroundStyle(Color(.systemGray))
            }
        }
        .padding()
        .toolbarRole(.editor)
    }
}

#Preview {
    EmailSentView()
        .environment(Router())
}

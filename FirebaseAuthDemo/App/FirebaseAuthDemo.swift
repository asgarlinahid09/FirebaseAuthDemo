//
//  FirebaseAuthDemo.swift
//  FirebaseAuthDemo
//
//  Created by Nahid Askerli on 30.09.26.
//

import SwiftUI
import FirebaseCore
import GoogleSignIn

@main
struct FirebaseAuthDemo: App {
    
    @State private var authService: AuthService
    @State private var router = Router()
    
    init() {
        FirebaseApp.configure()
        authService = AuthService()
    }
    
    var body: some Scene {
        WindowGroup {
            RootView()
                .environment(authService)
                .environment(router)
                .onOpenURL { url in
                    GIDSignIn.sharedInstance.handle(url)
                }
        }
    }
}

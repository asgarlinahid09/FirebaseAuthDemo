//
//  AuthService.swift
//  FirebaseAuth
//
//  Created by Nahid Askerli on 02.10.26.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore
import FirebaseCore
import GoogleSignIn
import UIKit

@MainActor
@Observable
final class AuthService {

    private(set) var userSession: FirebaseAuth.User?

    private(set) var currentUser: AppUser?

    private var auth: Auth { Auth.auth() }

    private var isFirebaseConfigured: Bool { FirebaseApp.app() != nil }

    init() {
        guard isFirebaseConfigured else { return }
        userSession = auth.currentUser
    }
    

    func loadCurrentUser() async {
        guard isFirebaseConfigured, let user = auth.currentUser else { return }
        do {
            currentUser = try await fetchUser(uid: user.uid)
        } catch {
            print("İstifadəçi yüklənmədi: \(error.localizedDescription)")
        }
    }

    func login(email: String, password: String) async throws {
        let result = try await auth.signIn(withEmail: email.trimmed, password: password)
        try await startSession(for: result.user)
    }

    func createUser(email: String, fullName: String, password: String) async throws {
        let result = try await auth.createUser(withEmail: email.trimmed, password: password)
        let user = AppUser(uid: result.user.uid, email: email.trimmed, fullName: fullName.trimmed)

        do {
            try await save(user)
        } catch {
            try? await result.user.delete()
            throw error
        }
        currentUser = user
        userSession = result.user
    }

    func signOut() throws {
        try auth.signOut()
        GIDSignIn.sharedInstance.signOut()
        clearSession()
    }

    func deleteAccount() async throws {
        guard let user = auth.currentUser else { return }
        let backup = currentUser

        try await userDocument(user.uid).delete()
        do {
            try await user.delete()
        } catch {
            if let backup {
                try? await save(backup)
            }
            throw error
        }

        GIDSignIn.sharedInstance.signOut()
        clearSession()
    }

    func sendPasswordReset(to email: String) async throws {
        try await auth.sendPasswordReset(withEmail: email.trimmed)
    }


    func signInWithGoogle() async throws {
        guard let clientID = FirebaseApp.app()?.options.clientID else {
            throw AuthError.missingClientID
        }
        GIDSignIn.sharedInstance.configuration = GIDConfiguration(clientID: clientID)

        guard let rootViewController = UIApplication.shared.connectedScenes
            .compactMap({ $0 as? UIWindowScene })
            .first?.keyWindow?.rootViewController else {
            throw AuthError.noRootViewController
        }

        let result: GIDSignInResult
        do {
            result = try await GIDSignIn.sharedInstance.signIn(withPresenting: rootViewController)
        } catch GIDSignInError.canceled {
            return
        }

        guard let idToken = result.user.idToken?.tokenString else {
            throw AuthError.missingIDToken
        }

        let credential = GoogleAuthProvider.credential(
            withIDToken: idToken,
            accessToken: result.user.accessToken.tokenString
        )
        let firebaseUser = try await auth.signIn(with: credential).user
        let document = try await userDocument(firebaseUser.uid).getDocument()
        if !document.exists {
            try await save(AppUser(
                uid: firebaseUser.uid,
                email: firebaseUser.email ?? "",
                fullName: firebaseUser.displayName ?? ""
            ))
        }

        try await startSession(for: firebaseUser)
    }

    private func startSession(for user: FirebaseAuth.User) async throws {
        currentUser = try await fetchUser(uid: user.uid)
        userSession = user
    }

    private func clearSession() {
        userSession = nil
        currentUser = nil
    }

    private func userDocument(_ uid: String) -> DocumentReference {
        Firestore.firestore().collection("users").document(uid)
    }

    private func fetchUser(uid: String) async throws -> AppUser {
        try await userDocument(uid).getDocument().data(as: AppUser.self)
    }

    private func save(_ user: AppUser) async throws {
        let data = try Firestore.Encoder().encode(user)
        try await userDocument(user.uid).setData(data)
    }
}

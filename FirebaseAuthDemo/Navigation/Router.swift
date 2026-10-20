//
//  Router.swift
//  FirebaseAuth
//
//  Created by Nahid Askerli on 08.10.26.
//

import SwiftUI

@Observable
final class Router{
    
    var path = NavigationPath()
    
    enum AuthRoute: Hashable {
        case createAccount
        case forgotPassword
        case emailSent
    }
    
    func navigate(to destination: AuthRoute) {
        path.append(destination)
    }
    
    func navigateBack() {
        guard !path.isEmpty else { return }
        path.removeLast()
    }

    func navigateToRoot() {
        path = NavigationPath()
    }}

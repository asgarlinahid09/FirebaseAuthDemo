//
//  AuthError.swift
//  FirebaseAuthDemo
//
//  Created by Nahid Askerli on 15.10.26.
//

import Foundation


enum AuthError: LocalizedError {
    case missingClientID
    case noRootViewController
    case missingIDToken
    
    var errorDescription: String? {
        switch self {
        case .missingClientID:
            "Firebase configuration is missing the Google client ID."
        case .noRootViewController:
            "Could not open the Google sign-in window."
        case .missingIDToken:
            "Google did not return a sign-in token."
        }
    }
}

//
//  AppUser.swift
//  FirebaseAuth
//
//  Created by Nahid Askerli on 02.10.26.
//

import Foundation

struct AppUser: Codable {
    let uid: String
    let email: String
    let fullName: String
    
    var initials: String {
        let formatter = PersonNameComponentsFormatter()
        if let components = formatter.personNameComponents(from: fullName) {
            formatter.style = .abbreviated
            return formatter.string(from: components)
        }
        return ""
    }
}

//
//  String+Trimmed.swift
//  FirebaseAuthDemo
//
//  Created by Nahid Askerli on 19.10.26.
//

import Foundation

extension String {
    var trimmed: String {
        trimmingCharacters(in: .whitespacesAndNewlines)
    }
}

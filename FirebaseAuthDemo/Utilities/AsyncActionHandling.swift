//
//  AsyncActionHandling.swift
//  FirebaseAuthDemo
//
//  Created by Nahid Askerli on 19.10.26.
//

import Foundation
import Foundation


@MainActor
protocol AsyncActionHandling: AnyObject {
    var isLoading: Bool { get set }
    var errorMessage: String? { get set }
}

extension AsyncActionHandling {
   
    @discardableResult
    func run(_ operation: () async throws -> Void) async -> Bool {
        isLoading = true
        defer { isLoading = false }
        do {
            try await operation()
            return true
        } catch {
            errorMessage = error.localizedDescription
            return false
        }
    }
}

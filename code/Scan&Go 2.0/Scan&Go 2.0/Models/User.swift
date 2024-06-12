//
//  User.swift
//  Scan&Go 2.0
//
//  Created by Dinuka Dissanayake on 6/6/24.
//

import Foundation
import FirebaseAuth

// Class representing user details and authentication status
class User: ObservableObject {
    
    // Published properties to update UI
    @Published var fullName: String = ""
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var isAuthenticated: Bool = false
    @Published var errorMessage: String = ""
    
    // Initialize user details and check authentication status
    init() {
        loadUserDetails()
    }
    
    // Method to validate user input
    func isValid() -> Bool {
        if !Validator.isValidUsername(for: fullName) {
            errorMessage = "Invalid full name. It must be 4 to 24 characters long."
            return false
        }
        
        if !Validator.isValidEmail(for: email) {
            errorMessage = "Invalid email address."
            return false
        }
        
        if !Validator.isPasswordValid(for: password) {
            errorMessage = "Password must be 6 to 32 characters long, with at least one uppercase letter, one lowercase letter, one number, and one special character."
            return false
        }
        
        errorMessage = ""
        return true
    }
    
    // Method to load user details if authenticated
    func loadUserDetails() {
        if let currentUser = Auth.auth().currentUser {
            self.fullName = currentUser.displayName ?? ""
            self.email = currentUser.email ?? ""
            self.isAuthenticated = true
        } else {
            self.isAuthenticated = false
        }
    }
    
    // Method to sign out the user
    func signOut() {
        do {
            try Auth.auth().signOut()
            self.fullName = ""
            self.email = ""
            self.isAuthenticated = false
            KeychainHelper.shared.clearCredentials()
        } catch let error {
            self.errorMessage = error.localizedDescription
        }
    }
    
    // Method to delete the user account
    func deleteAccount(completion: @escaping (Error?) -> Void) {
        Auth.auth().currentUser?.delete { error in
            if let error = error {
                self.errorMessage = error.localizedDescription
            } else {
                self.fullName = ""
                self.email = ""
                self.isAuthenticated = false
                KeychainHelper.shared.clearCredentials()
            }
            completion(error)
        }
    }
}

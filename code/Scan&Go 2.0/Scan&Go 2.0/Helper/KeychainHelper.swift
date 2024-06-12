//
//  KeychainHelper.swift
//  Scan&Go 2.0
//
//  Created by Dinuka Dissanayake on 6/8/24.
//

import KeychainAccess // Import KeychainAccess framework for managing keychain

class KeychainHelper {
    static let shared = KeychainHelper() // Singleton instance of KeychainHelper

    private let keychain = Keychain(service: "com.yourapp.bundleid") // Initialize Keychain with app's bundle identifier

    // Method to save user credentials to keychain
    func saveCredentials(email: String, password: String) {
        do {
            try keychain.set(email, key: "email") // Save email to keychain
            try keychain.set(password, key: "password") // Save password to keychain
        } catch let error {
            print("Error saving credentials to keychain: \(error)") // Print error if saving fails
        }
    }

    // Method to retrieve user credentials from keychain
    func getCredentials() -> (email: String?, password: String?) {
        do {
            let email = try keychain.get("email") // Retrieve email from keychain
            let password = try keychain.get("password") // Retrieve password from keychain
            return (email, password) // Return email and password tuple
        } catch let error {
            print("Error retrieving credentials from keychain: \(error)") // Print error if retrieval fails
            return (nil, nil) // Return nil for both email and password
        }
    }

    // Method to clear user credentials from keychain
    func clearCredentials() {
        do {
            try keychain.remove("email") // Remove email from keychain
            try keychain.remove("password") // Remove password from keychain
        } catch let error {
            print("Error clearing credentials from keychain: \(error)") // Print error if clearing fails
        }
    }
}

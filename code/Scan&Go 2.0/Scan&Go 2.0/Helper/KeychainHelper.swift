//
//  KeychainHelper.swift
//  Scan&Go 2.0
//
//  Created by Dinuka Dissanayake on 6/8/24.
//

import KeychainAccess
import Foundation

class KeychainHelper {
    static let shared = KeychainHelper() // Singleton instance of KeychainHelper

    private let keychain = Keychain(service: Bundle.main.bundleIdentifier ?? "com.default.bundleid") // Initialize Keychain with app's bundle identifier

    // Method to save user credentials to keychain
    func saveCredentials(email: String, password: String) {
        do {
            try keychain
                .accessibility(.whenPasscodeSetThisDeviceOnly)
                .set(email, key: "email")
            print("Email saved successfully; \(email)")
            try keychain
                .accessibility(.whenPasscodeSetThisDeviceOnly)
                .set(password, key: "password")
            print("Password saved successfully; \(password)")
        } catch let error {
            print("Error saving credentials to keychain: \(error)") // Print error if saving fails
        }
    }

    // Method to retrieve user credentials from keychain
    func getCredentials() -> (email: String?, password: String?) {
        do {
            let email = try keychain
                .accessibility(.whenPasscodeSetThisDeviceOnly)
                .get("email")
            let password = try keychain
                .accessibility(.whenPasscodeSetThisDeviceOnly)
                .get("password")
            print("Retrieved email: \(email ?? "nil"), password: \(password ?? "nil")")
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

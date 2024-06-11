//
//  KeychainHelper.swift
//  Scan&Go 2.0
//
//  Created by Dinuka Dissanayake on 6/8/24.
//

import KeychainAccess

class KeychainHelper {
    static let shared = KeychainHelper()
    private let keychain = Keychain(service: "com.yourapp.bundleid")

    func saveCredentials(email: String, password: String) {
        do {
            try keychain.set(email, key: "email")
            try keychain.set(password, key: "password")
        } catch let error {
            print("Error saving credentials to keychain: \(error)")
        }
    }

    func getCredentials() -> (email: String?, password: String?) {
        do {
            let email = try keychain.get("email")
            let password = try keychain.get("password")
            return (email, password)
        } catch let error {
            print("Error retrieving credentials from keychain: \(error)")
            return (nil, nil)
        }
    }

    func clearCredentials() {
        do {
            try keychain.remove("email")
            try keychain.remove("password")
        } catch let error {
            print("Error clearing credentials from keychain: \(error)")
        }
    }
}


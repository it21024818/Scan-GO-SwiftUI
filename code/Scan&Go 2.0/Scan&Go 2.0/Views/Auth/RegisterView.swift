//
//  RegisterView.swift
//  Scan&Go 2.0
//
//  Created by Dinuka Dissanayake on 6/6/24.
//

import SwiftUI
import FirebaseAuth

// View for user registration
struct RegisterView: View {
    
    // StateObject to manage user registration
    @StateObject private var user = User()
    
    // State to track registration status
    @State private var isRegistered = false

    var body: some View {
        VStack {
            // App Icon
            Image("scan&goIcon")
                .resizable()
                .scaledToFit()
                .frame(width: 200, height: 200)
                .clipShape(Circle())

            // Sign up label
            Text("Sign up")
                .font(.largeTitle)
                .fontWeight(.bold)
            
            // Full Name TextField
            TextField("Full Name", text: $user.fullName)
                .padding()
                .background(Color(.secondarySystemBackground))
                .cornerRadius(5)
                .frame(width: 350)
            
            // Email TextField
            TextField("Email", text: $user.email)
                .padding()
                .background(Color(.secondarySystemBackground))
                .cornerRadius(5)
                .frame(width: 350)
            
            // Password SecureField
            SecureField("Password", text: $user.password)
                .padding()
                .background(Color(.secondarySystemBackground))
                .cornerRadius(5)
                .frame(width: 350)
            
            // Sign up Button
            Button(action: register) {
                Text("Sign up")
                    .foregroundColor(.white)
                    .padding()
                    .frame(width: 350)
                    .background(Color.orange)
                    .cornerRadius(10)
            }
            .padding(.top)
            
            // Error Message
            if !user.errorMessage.isEmpty {
                Text(user.errorMessage)
                    .foregroundColor(.red)
                    .padding()
            }
            
            // Registration success message
            if isRegistered {
                Text("Registration successful! Please log in.")
                    .foregroundColor(.green)
                    .padding()
            }
        }
        .padding(.top, -150)
    }
    
    // Function to handle user registration
    func register() {
        // Validate user input
        if user.isValid() {
            // Create user with Firebase Authentication
            Auth.auth().createUser(withEmail: user.email, password: user.password) { authResult, error in
                if let error = error {
                    user.errorMessage = error.localizedDescription
                } else {
                    if let firebaseUser = authResult?.user {
                        // Update user profile with full name
                        let changeRequest = firebaseUser.createProfileChangeRequest()
                        changeRequest.displayName = user.fullName
                        changeRequest.commitChanges { error in
                            if let error = error {
                                user.errorMessage = error.localizedDescription
                            } else {
                                // Set registration status to true
                                isRegistered = true
                            }
                        }
                    }
                }
            }
        }
    }
}

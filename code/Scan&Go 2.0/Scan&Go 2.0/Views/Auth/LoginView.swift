//
//  LoginView.swift
//  Scan&Go 2.0
//
//  Created by Dinuka Dissanayake on 6/6/24.
//

import SwiftUI
import FirebaseAuth
import LocalAuthentication

// View for user login
struct LoginView: View {
    
    // EnvironmentObject to access user authentication status
    @EnvironmentObject var user: User
    
    // State to track biometric availability and type
    @State private var isBiometricAvailable = false
    @State private var biometricType: LABiometryType = .none

    var body: some View {
        NavigationView {
            VStack {
                // App Icon
                Image("scan&goIcon")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200, height: 200)
                    .clipShape(Circle())

                // Sign in label
                Text("Sign in")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                
                // Email TextField
                TextField("Email", text: $user.email)
                    .padding()
                    .background(Color(.secondarySystemBackground))
                    .cornerRadius(10)
                    .frame(width: 350)
                
                // Password SecureField
                SecureField("Password", text: $user.password)
                    .padding()
                    .background(Color(.secondarySystemBackground))
                    .cornerRadius(10)
                    .frame(width: 350)
                
                // Login Button
                Button(action: login) {
                    Text("Sign in")
                        .foregroundColor(.white)
                        .padding()
                        .frame(width:350)
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
                
                // Navigation Links
                NavigationLink("Register", destination: RegisterView())
                    .padding(.top, 20)
                
                NavigationLink("Forgot Password?", destination: ForgotPasswordView())
                    .padding(.top, 10)
                
                // Biometric Login Button
                if isBiometricAvailable {
                    Button(action: authenticateWithBiometrics) {
                        Image(systemName: biometricType == .faceID ? "faceid" : "touchid")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 50, height: 50)
                            .foregroundColor(.secondary)
                            .padding()
                            .cornerRadius(10)
                    }
                    .padding(.top, 20)
                }
            }
            .padding(20)
            .padding(.top, -20)
            .onAppear(perform: checkBiometricAvailability)
        }
    }
    
    // Function to handle user login
    func login() {
        guard Validator.isValidEmail(for: user.email) && Validator.isPasswordValid(for: user.password) else {
            user.errorMessage = "Invalid email or password."
            return
        }
        
        Auth.auth().signIn(withEmail: user.email, password: user.password) { result, error in
            if let error = error {
                user.errorMessage = error.localizedDescription
            } else {
                KeychainHelper.shared.saveCredentials(email: user.email, password: user.password)
                user.isAuthenticated = true
                user.loadUserDetails() // Update user details upon successful login
            }
        }
    }
    
    // Function to authenticate with biometrics
    func authenticateWithBiometrics() {
        let context = LAContext()
        var error: NSError?

        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            let reason = "Log in to your account"

            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { success, authenticationError in
                DispatchQueue.main.async {
                    if success {
                        let credentials = KeychainHelper.shared.getCredentials()
                        if let email = credentials.email, let password = credentials.password {
                            self.user.email = email
                            self.user.password = password
                            self.login()
                        } else {
                            self.user.errorMessage = "Failed to retrieve credentials."
                        }
                    } else {
                        self.user.errorMessage = authenticationError?.localizedDescription ?? "Failed to authenticate"
                    }
                }
            }
        } else {
            self.user.errorMessage = error?.localizedDescription ?? "Biometrics not available"
        }
    }
    
    // Function to check biometric availability
    func checkBiometricAvailability() {
        let context = LAContext()
        var error: NSError?

        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            isBiometricAvailable = true
            biometricType = context.biometryType
        } else {
            isBiometricAvailable = false
        }
    }
}

// Preview provider for LoginView
struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}

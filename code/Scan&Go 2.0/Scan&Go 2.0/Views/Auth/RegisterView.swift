//
//  RegisterView.swift
//  Scan&Go 2.0
//
//  Created by Dinuka Dissanayake on 6/6/24.
//

import SwiftUI
import FirebaseAuth

struct RegisterView: View {
    @StateObject private var user = User()
    @State private var isRegistered = false

    var body: some View {
        VStack {
            // App Icon
            Image("scan&goIcon")
                .resizable()
                .scaledToFit()
                .frame(width: 100, height: 100)
                .clipShape(Circle())
                .padding(.top, 10)

            // Sign in label
            Text("Sign up")
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding(.top, 20)
            
            TextField("Full Name", text: $user.fullName)
                .padding()
                .background(Color(.secondarySystemBackground))
                .cornerRadius(5)
            
            TextField("Email", text: $user.email)
                .padding()
                .background(Color(.secondarySystemBackground))
                .cornerRadius(5)
            
            SecureField("Password", text: $user.password)
                .padding()
                .background(Color(.secondarySystemBackground))
                .cornerRadius(5)
            
            Button(action: register) {
                Text("Sign up")
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.orange)
                    .cornerRadius(10)
                    .frame(maxWidth: .infinity)
            }
            .padding(.horizontal)
            .padding(.top)
            
            if !user.errorMessage.isEmpty {
                Text(user.errorMessage)
                    .foregroundColor(.red)
                    .padding()
            }
            
            if isRegistered {
                Text("Registration successful! Please log in.")
                    .foregroundColor(.green)
                    .padding()
            }
        }
        .padding()
    }
    
    func register() {
        if user.isValid() {
            Auth.auth().createUser(withEmail: user.email, password: user.password) { authResult, error in
                if let error = error {
                    user.errorMessage = error.localizedDescription
                } else {
                    if let firebaseUser = authResult?.user {
                        let changeRequest = firebaseUser.createProfileChangeRequest()
                        changeRequest.displayName = user.fullName
                        changeRequest.commitChanges { error in
                            if let error = error {
                                user.errorMessage = error.localizedDescription
                            } else {
                                isRegistered = true
                            }
                        }
                    }
                }
            }
        }
    }
}

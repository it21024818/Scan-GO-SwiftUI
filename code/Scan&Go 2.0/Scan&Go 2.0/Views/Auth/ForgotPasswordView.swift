//
//  ForgotPasswordView.swift
//  Scan&Go 2.0
//
//  Created by Dinuka Dissanayake on 6/6/24.
//
import SwiftUI
import FirebaseAuth

struct ForgotPasswordView: View {
    @State private var email = ""
    @State private var errorMessage = ""
    @State private var isEmailSent = false

    var body: some View {
        VStack {
            // App Icon
            Image("scan&goIcon")
                .resizable()
                .scaledToFit()
                .frame(width: 200, height: 200)
                .clipShape(Circle())

            // Sign in label
            Text("Reset password")
                .font(.largeTitle)
                .fontWeight(.bold)
            
            TextField("Email", text: $email)
                .padding()
                .background(Color(.secondarySystemBackground))
                .cornerRadius(5)
                .frame(width: 350)
            
            Button(action: resetPassword) {
                Text("Reset Password")
                    .foregroundColor(.white)
                    .padding()
                    .frame(width: 350)
                    .background(Color.orange)
                    .cornerRadius(10)
            }
            .padding(.top)
            
            if !errorMessage.isEmpty {
                Text(errorMessage)
                    .foregroundColor(.red)
                    .padding()
            }
            
            if isEmailSent {
                Text("Password reset email sent!")
                    .foregroundColor(.green)
                    .padding()
            }
        }
        .padding(.top, -300)
    }
    
    func resetPassword() {
        Auth.auth().sendPasswordReset(withEmail: email) { error in
            if let error = error {
                errorMessage = error.localizedDescription
            } else {
                isEmailSent = true
            }
        }
    }
}


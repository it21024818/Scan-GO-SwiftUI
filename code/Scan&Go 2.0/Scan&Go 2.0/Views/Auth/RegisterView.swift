////
////  RegisterView.swift
////  Scan&Go 2.0
////
////  Created by Dinuka Dissanayake on 6/6/24.
////
//
//import SwiftUI
//
//struct RegisterView: View {
//    @State private var username: String = ""
//    @State private var email: String = ""
//    @State private var password: String = ""
//    @State private var showAlert = false
//    @State private var alertMessage = ""
//    
//    var body: some View {
//        NavigationView {
//            VStack {
//                AuthHeaderView(title: "Sign Up", subTitle: "Create your account")
//                
//                CustomTextField(fieldType: .username, text: $username)
//                CustomTextField(fieldType: .email, text: $email)
//                CustomTextField(fieldType: .password, text: $password)
//                
//                CustomButton(title: "Sign Up", hasBackground: true) {
//                    signUp()
//                }
//                
//                Text("By creating an account, you agree to our ")
//                    .foregroundColor(.gray) +
//                Link("Terms & Conditions", destination: URL(string: "https://policies.google.com/terms?hl=en")!)
//                    .foregroundColor(.blue) +
//                Text(" and acknowledge that you have read our ") +
//                Link("Privacy Policy", destination: URL(string: "https://policies.google.com/privacy?hl=en")!)
//                    .foregroundColor(.blue)
//                
//                Spacer()
//            }
//            .padding()
//            .navigationBarHidden(true)
//            .alert(isPresented: $showAlert) {
//                Alert(title: Text("Error"), message: Text(alertMessage), dismissButton: .default(Text("OK")))
//            }
//        }
//    }
//    
//    private func signUp() {
//        let registerUserRequest = RegisterUserRequest(
//            username: self.username,
//            email: self.email,
//            password: self.password
//        )
//        
//        // Username check
//        if !Validator.isValidUsername(for: registerUserRequest.username) {
//            showAlert(message: "Invalid username format.")
//            return
//        }
//        
//        // Email check
//        if !Validator.isValidEmail(for: registerUserRequest.email) {
//            showAlert(message: "Invalid email format.")
//            return
//        }
//        
//        // Password check
//        if !Validator.isPasswordValid(for: registerUserRequest.password) {
//            showAlert(message: "Invalid password.")
//            return
//        }
//        
//        AuthService.shared.registerUser(with: registerUserRequest) { wasRegistered, error in
//            if let error = error {
//                showAlert(message: error.localizedDescription)
//                return
//            }
//            
//            if wasRegistered {
//                // Handle successful registration
//                // For example, navigate to a different view
//            } else {
//                showAlert(message: "Registration failed.")
//            }
//        }
//    }
//    
//    private func showAlert(message: String) {
//        alertMessage = message
//        showAlert = true
//    }
//}

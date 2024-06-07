////
////  ForgotPasswordView.swift
////  Scan&Go 2.0
////
////  Created by Dinuka Dissanayake on 6/6/24.
////
//
//import SwiftUI
//
//struct ForgotPasswordView: View {
//    @State private var email: String = ""
//    @State private var showAlert = false
//    @State private var alertMessage = ""
//    
//    var body: some View {
//        VStack {
//            AuthHeaderView(title: "Forgot Password", subTitle: "Reset your password")
//            
//            CustomTextField(text: $email, placeholder: "Email")
//            
//            CustomButton(title: "Reset Password") {
//                resetPassword()
//            }
//            
//            Spacer()
//        }
//        .padding()
//        .navigationBarHidden(true)
//        .alert(isPresented: $showAlert) {
//            Alert(title: Text("Error"), message: Text(alertMessage), dismissButton: .default(Text("OK")))
//        }
//    }
//    
//    private func resetPassword() {
//        if !Validator.isValidEmail(for: email) {
//            showAlert(message: "Invalid email format.")
//            return
//        }
//        
//        AuthService.shared.forgotPassword(with: email) { [weak self] error in
//            guard let self = self else { return }
//            if let error = error {
//                showAlert(message: error.localizedDescription)
//                return
//            }
//            
//            showAlert(message: "Password reset email sent successfully.")
//        }
//    }
//    
//    private func showAlert(message: String) {
//        alertMessage = message
//        showAlert = true
//    }
//}

////
////  LoginView.swift
////  Scan&Go 2.0
////
////  Created by Dinuka Dissanayake on 6/6/24.
////
//
//import SwiftUI
//
//struct LoginView: View {
//    @State private var email: String = ""
//    @State private var password: String = ""
//    @State private var showingAlert = false
//    @State private var alertMessage = ""
//    
//    var body: some View {
//        NavigationView {
//            VStack {
//                AuthHeaderView(title: "Sign In", subTitle: "Sign in to your account")
//                
//                CustomTextField(fieldType: .email, text: $email)
//                CustomTextField(fieldType: .password, text: $password)
//                
//                CustomButton(title: "Sign In", hasBackground: true, fontSize: .big) {
//                    signIn()
//                }
//                
//                NavigationLink(destination: RegisterView()) {
//                    CustomButton(title: "New User? Create Account.", fontSize: .med) { }
//                }
//                
//                NavigationLink(destination: ForgotPasswordView()) {
//                    CustomButton(title: "Forgot Password?", fontSize: .small) { }
//                }
//                
//                Spacer()
//            }
//            .alert(isPresented: $showingAlert) {
//                Alert(title: Text("Error"), message: Text(alertMessage), dismissButton: .default(Text("OK")))
//            }
//            .navigationBarHidden(true)
//        }
//    }
//    
//    private func signIn() {
//        let loginRequest = LoginUserRequest(
//            email: self.email,
//            password: self.password
//        )
//        
//        if !Validator.isValidEmail(for: loginRequest.email) {
//            alertMessage = "Invalid email format."
//            showingAlert = true
//            return
//        }
//        
//        if !Validator.isPasswordValid(for: loginRequest.password) {
//            alertMessage = "Invalid password."
//            showingAlert = true
//            return
//        }
//        
//        AuthService.shared.signIn(with: loginRequest) { error in
//            if let error = error {
//                alertMessage = error.localizedDescription
//                showingAlert = true
//                return
//            }
//            
//            if let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate {
//                sceneDelegate.checkAuthentication()
//            }
//        }
//    }
//}
//

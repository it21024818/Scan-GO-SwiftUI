////
////  CustomTextField.swift
////  Scan&Go 2.0
////
////  Created by Dinuka Dissanayake on 6/6/24.
////
//
//import SwiftUI
//
//struct CustomTextField: View {
//    enum CustomTextFieldType {
//        case username
//        case email
//        case password
//    }
//    
//    @State private var text: String = ""
//    private var fieldType: CustomTextFieldType
//    
//    init(fieldType: CustomTextFieldType) {
//        self.fieldType = fieldType
//    }
//    
//    private var placeholder: String {
//        switch fieldType {
//        case .username:
//            return "Username"
//        case .email:
//            return "Email Address"
//        case .password:
//            return "Password"
//        }
//    }
//    
//    private var isSecureField: Bool {
//        fieldType == .password
//    }
//    
//    private var keyboardType: UIKeyboardType {
//        fieldType == .email ? .emailAddress : .default
//    }
//    
//    var body: some View {
//        Group {
//            if isSecureField {
//                SecureField(placeholder, text: $text)
//                    .padding()
//                    .background(Color(UIColor.secondarySystemBackground))
//                    .cornerRadius(10)
//                    .textInputAutocapitalization(.none)
//                    .autocorrectionDisabled(true)
////                    .keyboardType(keyboardType)
//            } else {
//                TextField(placeholder, text: $text)
//                    .padding()
//                    .background(Color.secondarySystemBackground)
//                    .cornerRadius(10)
//                    .textInputAutocapitalization(.none)
//                    .autocorrectionDisabled(true)
//                    .keyboardType(keyboardType)
//            }
//        }
//        .overlay(
//            RoundedRectangle(cornerRadius: 10)
//                .strokeBorder(Color.clear, lineWidth: 0)
//                .padding(.leading, 12)
//        )
//        .padding(.horizontal, 12)
//    }
//}
//
//struct CustomTextField_Previews: PreviewProvider {
//    static var previews: some View {
//        VStack {
//            CustomTextField(fieldType: .username)
//            CustomTextField(fieldType: .email)
//            CustomTextField(fieldType: .password)
//        }
//        .padding()
//    }
//}

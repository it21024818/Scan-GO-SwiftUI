////
////  CustomButton.swift
////  Scan&Go 2.0
////
////  Created by Dinuka Dissanayake on 6/6/24.
////
//
//import SwiftUI
//
//struct CustomButton: View {
//    enum FontSize {
//        case big
//        case med
//        case small
//    }
//    
//    var title: String
//    var hasBackground: Bool
//    var fontSize: FontSize
//    var action: () -> Void
//    
//    // Computed properties for styling
//    private var backgroundColor: Color {
//        hasBackground ? Color.orange : Color.clear
//    }
//    
//    private var titleColor: Color {
//        hasBackground ? Color.white : Color.orange
//    }
//    
//    private var font: Font {
//        switch fontSize {
//        case .big:
//            return .system(size: 22, weight: .bold)
//        case .med:
//            return .system(size: 18, weight: .semibold)
//        case .small:
//            return .system(size: 16, weight: .regular)
//        }
//    }
//    
//    var body: some View {
//        Button(action: action) {
//            Text(title)
//                .font(font)
//                .foregroundColor(titleColor)
//                .padding()
//                .frame(maxWidth: .infinity)
//                .background(backgroundColor)
//                .cornerRadius(12)
//                .overlay(
//                    RoundedRectangle(cornerRadius: 12)
//                        .stroke(hasBackground ? Color.clear : Color.orange, lineWidth: 1)
//                )
//        }
//    }
//}
//
//struct CustomButton_Previews: PreviewProvider {
//    static var previews: some View {
//        VStack(spacing: 20) {
//            CustomButton(title: "Big Button", hasBackground: true, fontSize: .big) {
//                print("Big Button tapped")
//            }
//            
//            CustomButton(title: "Medium Button", hasBackground: false, fontSize: .med) {
//                print("Medium Button tapped")
//            }
//            
//            CustomButton(title: "Small Button", hasBackground: true, fontSize: .small) {
//                print("Small Button tapped")
//            }
//        }
//        .padding()
//    }
//}

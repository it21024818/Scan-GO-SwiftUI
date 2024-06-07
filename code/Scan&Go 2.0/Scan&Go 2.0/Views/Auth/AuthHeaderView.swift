////
////  AuthViewHeader.swift
////  Scan&Go 2.0
////
////  Created by Dinuka Dissanayake on 6/6/24.
////
//
//import SwiftUI
//
//struct AuthHeaderView: View {
//    // MARK: - Properties
//    var title: String
//    var subTitle: String
//    
//    // MARK: - Body
//    var body: some View {
//        VStack(spacing: 12) {
//            Image("logo")
//                .resizable()
//                .aspectRatio(contentMode: .fit)
//                .frame(width: 90, height: 90)
//                .padding(.top, 30)
//            
//            Text(title)
//                .font(.system(size: 26, weight: .bold))
//                .foregroundColor(.primary)
//                .multilineTextAlignment(.center)
//            
//            Text(subTitle)
//                .font(.system(size: 18, weight: .regular))
//                .foregroundColor(.secondary)
//                .multilineTextAlignment(.center)
//        }
//        .padding(.horizontal)
//    }
//}
//
//struct AuthHeaderView_Previews: PreviewProvider {
//    static var previews: some View {
//        AuthHeaderView(title: "Welcome", subTitle: "Please sign in to continue")
//            .previewLayout(.sizeThatFits)
//    }
//}

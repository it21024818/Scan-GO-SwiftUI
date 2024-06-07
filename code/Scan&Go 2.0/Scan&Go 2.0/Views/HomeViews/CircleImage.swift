//
//  CircleImage.swift
//  Scan&Go 2.0
//
//  Created by Dinuka Dissanayake on 6/7/24.
//

import SwiftUI

struct CircleImage: View {
    var body: some View {
        Image("sparLogo")
            .clipShape(Circle())
            .overlay {
                Circle().stroke(.white, lineWidth: 4)
            }
            .shadow(radius: 7)
    }
}

#Preview {
    CircleImage()
}

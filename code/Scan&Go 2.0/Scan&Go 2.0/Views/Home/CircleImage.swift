//
//  CircleImage.swift
//  Scan&Go 2.0
//
//  Created by Dinuka Dissanayake on 6/7/24.
//

import SwiftUI

// View for displaying an image within a circle with a shadow
struct CircleImage: View {
    
    // Name of the image
    var imageName: String
    
    var body: some View {
        // Image view within a resizable circle shape
        Image(imageName)
            .resizable()
            .aspectRatio(contentMode: .fill)
            .frame(width: 200, height: 200)
            .clipShape(Circle()) // Clip the image into a circle shape
            .overlay {
                // Overlay a white circle stroke
                Circle().stroke(.white, lineWidth: 4)
            }
            .shadow(radius: 7) // Add a shadow effect
    }
}

// Preview provider for CircleImage
struct CircleImage_Previews: PreviewProvider {
    static var previews: some View {
        CircleImage(imageName: "sparLogo")
    }
}

//
//  HomeView.swift
//  Scan&Go 2.0
//
//  Created by Dinuka Dissanayake on 5/20/24.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        VStack {
            MapView()
                .frame(height: 300)

            CircleImage()
                .offset(y: -130)
                .padding(.bottom, -130)

            VStack(alignment: .leading) {
                Text("Spar Supermarket")
                    .font(.title)

                HStack {
                    Text("Pannipitiya Road, Battaramulla")
                    Spacer()
                    Text("Colombo")
                }
                .font(.subheadline)
                .foregroundStyle(.secondary)

                Divider()

                Text("Contact No: 0115 007 200")
                    .font(.title2)
                Spacer()
                Text("Opening Hours: Monday - Sunday, 7am - 11pm")
            }
            .padding()

            Spacer()
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}

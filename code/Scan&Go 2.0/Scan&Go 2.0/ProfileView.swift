//
//  ProfileView.swift
//  Scan&Go 2.0
//
//  Created by Dinuka Dissanayake on 5/20/24.
//

import SwiftUI
import FirebaseAuth

struct ProfileView: View {
    @EnvironmentObject var user: User
    @State private var showLogin = false

    var body: some View {
        NavigationView {
            VStack {
                // Profile Header
                HStack {
                    Image(systemName: "person.circle.fill")
                        .resizable()
                        .frame(width: 100, height: 100)
                        .foregroundColor(.gray)
                        .padding(.leading)
                    
                    VStack(alignment: .leading) {
                        Text(user.fullName)
                            .font(.title)
                            .fontWeight(.bold)
                        
                        Text(user.email)
                            .font(.subheadline)
                            .foregroundColor(.gray)
                    }
                    .padding(.leading)
                    
                    Spacer()
                }
                .padding(.top)
                
                // List for other options
                List {
                    NavigationLink(destination: OrderHistoryView()) {
                        HStack {
                            Image(systemName: "clock")
                                .foregroundColor(.blue)
                            Text("Order History")
                        }
                    }
                    
                    NavigationLink(destination: NotificationsView()) {
                        HStack {
                            Image(systemName: "bell")
                                .foregroundColor(.orange)
                            Text("Notifications")
                        }
                    }
                    
                    NavigationLink(destination: CardsView()) {
                        HStack {
                            Image(systemName: "creditcard")
                                .foregroundColor(.green)
                            Text("Cards")
                        }
                    }
                    
                    NavigationLink(destination: SupportView()) {
                        HStack {
                            Image(systemName: "questionmark.circle")
                                .foregroundColor(.purple)
                            Text("Support")
                        }
                    }
                }
                .listStyle(InsetGroupedListStyle())
                
                // Sign Out Button
                Button(action: {
                    user.signOut()
                    showLogin = true
                }) {
                    Text("Sign Out")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.orange)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                .padding(.horizontal)
                .padding(.top)
                
                // Delete Account Button
                Button(action: {
                    user.deleteAccount { error in
                        if error == nil {
                            showLogin = true
                        }
                    }
                }) {
                    Text("Delete Account")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .foregroundColor(.red)
                        .cornerRadius(10)
                }
                .padding(.horizontal)
                
                Spacer()
            }
            .navigationTitle("Profile")
            .fullScreenCover(isPresented: $showLogin) {
                LoginView()
                    .environmentObject(user)
            }
        }
    }
}

// Placeholder Views for the Navigation Links
struct OrderHistoryView: View {
    var body: some View {
        Text("Order History")
            .navigationTitle("Order History")
    }
}

struct NotificationsView: View {
    var body: some View {
        Text("Notifications")
            .navigationTitle("Notifications")
    }
}

struct CardsView: View {
    var body: some View {
        Text("Cards")
            .navigationTitle("Cards")
    }
}

struct SupportView: View {
    var body: some View {
        Text("Support")
            .navigationTitle("Support")
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}

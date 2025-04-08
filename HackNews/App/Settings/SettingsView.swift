//
//  SettingsView.swift
//  HackNews
//
//  Created by Chaoyi Wu on 2025-04-04.
//

import SwiftUI

struct SettingsView: View {
    @EnvironmentObject var authViewModel: AuthViewModel
    
    var body: some View {
        NavigationStack {
            List {
                if let user = authViewModel.user {
                    Section(header: Text("Account")) {
                        NavigationLink(destination: ProfileView()) {
                            HStack {
                                Text(String(user.fullname.isEmpty ? user.email.prefix(1).uppercased() : user.fullname.prefix(1).uppercased()))
                                    .font(.title)
                                    .fontWeight(.semibold)
                                    .foregroundColor(.white)
                                    .frame(width: 60, height: 60)
                                    .background(Color.blue)
                                    .clipShape(Circle())
                                
                                VStack(alignment: .leading, spacing: 4) {
                                    if !user.fullname.isEmpty {
                                        Text(user.fullname)
                                            .font(.headline)
                                    }
                                    
                                    Text(user.email)
                                        .font(.subheadline)
                                        .foregroundColor(.gray)
                                }
                            }
                            .padding(.vertical, 4)
                        }
                    }
                }
                
                Section(header: Text("Preferences")) {
                    Toggle("Dark Mode", isOn: .constant(false))
                    Toggle("Notifications", isOn: .constant(true))
                }
                
                Section(header: Text("About")) {
                    Link("Visit Website", destination: URL(string: "https://news.ycombinator.com")!)
                    Link("Privacy Policy", destination: URL(string: "https://news.ycombinator.com/newsguidelines.html")!)
                    Link("Terms of Service", destination: URL(string: "https://news.ycombinator.com/newsguidelines.html")!)
                }
                
                if authViewModel.userSession != nil {
                    Section {
                        Button {
                            authViewModel.signOut()
                        } label: {
                            Text("Sign Out")
                                .foregroundColor(.red)
                        }
                    }
                }
            }
            .navigationTitle("Settings")
        }
    }
}

#Preview {
    SettingsView()
        .environmentObject(AuthViewModel())
}

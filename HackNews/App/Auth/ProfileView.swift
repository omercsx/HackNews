import SwiftUI

struct ProfileView: View {
    @EnvironmentObject var authViewModel: AuthViewModel
    
    var body: some View {
        NavigationStack {
            if let user = authViewModel.user {
                VStack(alignment: .center, spacing: 24) {
                    // Profile image
                    ZStack {
                        Circle()
                            .fill(Color.blue)
                            .frame(width: 100, height: 100)
                        
                        Text(String(user.fullname.isEmpty ? user.email.prefix(1).uppercased() : user.fullname.prefix(1).uppercased()))
                            .font(.title)
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                    }
                    
                    // User info
                    VStack(spacing: 8) {
                        if !user.fullname.isEmpty {
                            Text(user.fullname)
                                .font(.title2)
                                .fontWeight(.semibold)
                        }
                        
                        Text(user.email)
                            .font(.subheadline)
                            .foregroundColor(.gray)
                    }
                    
                    Divider()
                        .padding(.vertical, 16)
                    
                    // Account details section
                    VStack(alignment: .leading, spacing: 16) {
                        accountInfoRow(title: "Account ID", value: user.id)
                        accountInfoRow(title: "Account Type", value: "Standard")
                        accountInfoRow(title: "Joined", value: "Recently")
                    }
                    .padding(.horizontal)
                    
                    Spacer()
                    
                    // Sign-out button
                    Button {
                        authViewModel.signOut()
                    } label: {
                        Text("Sign Out")
                            .fontWeight(.semibold)
                            .foregroundColor(.white)
                            .frame(width: 200, height: 44)
                            .background(Color.red)
                            .cornerRadius(8)
                    }
                    .padding(.vertical, 24)
                }
                .padding()
                .navigationTitle("Profile")
            } else {
                VStack {
                    ProgressView("Loading profile...")
                }
            }
        }
    }
    
    private func accountInfoRow(title: String, value: String) -> some View {
        HStack {
            Text(title)
                .fontWeight(.medium)
                .foregroundColor(.gray)
            Spacer()
            Text(value)
                .fontWeight(.semibold)
        }
    }
}

#Preview {
    ProfileView()
        .environmentObject(AuthViewModel())
} 
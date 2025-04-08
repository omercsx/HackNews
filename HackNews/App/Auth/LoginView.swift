import SwiftUI

struct LoginView: View {
    @State private var email = ""
    @State private var password = ""
    @EnvironmentObject var viewModel: AuthViewModel
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        NavigationStack {
            VStack {
                // Header
                VStack(spacing: 6) {
                    Text("HackNews")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                    
                    Text("Welcome back!")
                        .font(.title2)
                        .fontWeight(.medium)
                }
                .padding(.vertical, 32)
                
                // Form
                VStack(spacing: 24) {
                    VStack(spacing: 8) {
                        TextField("Email", text: $email)
                            .autocapitalization(.none)
                            .keyboardType(.emailAddress)
                            .textContentType(.emailAddress)
                            .padding()
                            .background(
                                RoundedRectangle(cornerRadius: 8)
                                    .stroke(Color.gray.opacity(0.3), lineWidth: 1)
                            )
                        
                        SecureField("Password", text: $password)
                            .textContentType(.password)
                            .padding()
                            .background(
                                RoundedRectangle(cornerRadius: 8)
                                    .stroke(Color.gray.opacity(0.3), lineWidth: 1)
                            )
                    }
                    
                    // Error message
                    if let error = viewModel.error {
                        Text(error)
                            .font(.caption)
                            .foregroundColor(.red)
                            .padding(.top, -8)
                    }
                    
                    // Login button
                    Button {
                        viewModel.login(withEmail: email, password: password)
                    } label: {
                        HStack {
                            Text("Sign In")
                                .fontWeight(.semibold)
                            
                            if viewModel.isAuthenticating {
                                ProgressView()
                                    .padding(.leading, 4)
                            }
                        }
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 12)
                        .background(Color.blue)
                        .cornerRadius(8)
                    }
                    .disabled(viewModel.isAuthenticating)
                    
                    // Register button
                    NavigationLink {
                        RegisterView()
                            .environmentObject(viewModel)
                    } label: {
                        HStack {
                            Text("Don't have an account?")
                                .foregroundColor(colorScheme == .dark ? .white : .black)
                            
                            Text("Sign Up")
                                .fontWeight(.semibold)
                                .foregroundColor(.blue)
                        }
                        .font(.footnote)
                    }
                    .padding(.top, 8)
                }
                .padding(.horizontal, 28)
                
                Spacer()
            }
        }
    }
}

#Preview {
    LoginView()
        .environmentObject(AuthViewModel())
} 
import SwiftUI

struct RegisterView: View {
    @State private var email = ""
    @State private var fullname = ""
    @State private var password = ""
    @State private var confirmPassword = ""
    @EnvironmentObject var viewModel: AuthViewModel
    @Environment(\.dismiss) private var dismiss
    @Environment(\.colorScheme) var colorScheme
    
    // Local validation error
    @State private var validationError: String?
    
    var body: some View {
        VStack {
            // Header
            VStack(spacing: 6) {
                Text("HackNews")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                
                Text("Create your account")
                    .font(.title2)
                    .fontWeight(.medium)
            }
            .padding(.vertical, 32)
            
            // Form
            VStack(spacing: 24) {
                VStack(spacing: 8) {
                    TextField("Full Name", text: $fullname)
                        .textContentType(.name)
                        .padding()
                        .background(
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(Color.gray.opacity(0.3), lineWidth: 1)
                        )
                    
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
                        .textContentType(.newPassword)
                        .padding()
                        .background(
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(Color.gray.opacity(0.3), lineWidth: 1)
                        )
                    
                    SecureField("Confirm Password", text: $confirmPassword)
                        .textContentType(.newPassword)
                        .padding()
                        .background(
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(Color.gray.opacity(0.3), lineWidth: 1)
                        )
                }
                
                // Error message
                if let error = validationError ?? viewModel.error {
                    Text(error)
                        .font(.caption)
                        .foregroundColor(.red)
                        .padding(.top, -8)
                }
                
                // Register button
                Button {
                    // Validate inputs
                    validationError = validateInputs()
                    
                    // If validation passes, register user
                    if validationError == nil {
                        viewModel.register(withEmail: email, password: password, fullname: fullname)
                    }
                } label: {
                    HStack {
                        Text("Sign Up")
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
                
                // Login button
                Button {
                    dismiss()
                } label: {
                    HStack {
                        Text("Already have an account?")
                            .foregroundColor(colorScheme == .dark ? .white : .black)
                        
                        Text("Sign In")
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
        .navigationBarBackButtonHidden()
    }
    
    // Input validation
    private func validateInputs() -> String? {
        if fullname.isEmpty {
            return "Full name is required"
        }
        
        if email.isEmpty {
            return "Email is required"
        }
        
        if !email.contains("@") || !email.contains(".") {
            return "Please enter a valid email address"
        }
        
        if password.isEmpty {
            return "Password is required"
        }
        
        if password.count < 6 {
            return "Password must be at least 6 characters"
        }
        
        if password != confirmPassword {
            return "Passwords do not match"
        }
        
        return nil
    }
}

#Preview {
    NavigationStack {
        RegisterView()
            .environmentObject(AuthViewModel())
    }
} 
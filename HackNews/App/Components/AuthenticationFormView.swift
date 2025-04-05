//
//  AuthenticationFormView.swift
//  HackNews
//
//  Created by Chaoyi Wu on 2025-04-05.
//

import SwiftUI

struct AuthenticationFormView: View {

    //@EnvironmentObject var authState: AuthenticationState

    @State var email: String = ""
    @State var password: String = ""
    @State var passwordConf: String = ""
    @State var isShowingPassword = false

    @State var authType: AuthenticationType = .signup

    var body: some View {
        VStack(spacing: 20) {
            Text(authType.text)
                .padding()
                .bold()
                .font(.title)
            TextField("Email", text: $email)
                .textContentType(.emailAddress)
                .keyboardType(.emailAddress)
                .autocapitalization(.none)

            if isShowingPassword {
                TextField("Password", text: $password)
                .textContentType(.password)
                .autocapitalization(.none)
            } else {
                SecureField("Password", text: $password)
            }

            if authType == .signup {
                if isShowingPassword {
                    TextField("Password Confirmation", text: $passwordConf)
                        .textContentType(.password)
                        .autocapitalization(.none)
                } else {
                    SecureField("Password Confirmation", text: $passwordConf)
                }
            }

            Toggle("Show password", isOn: $isShowingPassword)
            
            Button(action: emailAuthenticationTapped) {
                Text(authType.text)
                .font(.callout)
            }
            .disabled(email.count == 0 && password.count == 0)

            Button(action: footerButtonTapped) {
                Text(authType.footerText)
                .font(.callout)
            }
        }
        .animation(.easeInOut)
        .transition(.move(edge: .bottom))
        .textFieldStyle(RoundedBorderTextFieldStyle())
        .frame(width: 288)
        //.alert(item: $authState.error) { error in
            //Alert(title: Text("Error"), message: Text(error.localizedDescription))
        //}
    }

    private func emailAuthenticationTapped() {
//        switch authType {
//        case .login:
//            // to do
//
//        case .signup:
//            // to do
//        }
    }

    private func footerButtonTapped() {
        clearFormField()
        authType = authType == .signup ? .login : .signup
    }

    private func clearFormField() {
        email = ""
        password = ""
        passwordConf = ""
        isShowingPassword = false
    }
}

#Preview {
    AuthenticationFormView()
}

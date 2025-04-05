//
//  AuthenticationType.swift
//  HackNews
//
//  Created by Chaoyi Wu on 2025-04-05.
//

import Foundation
enum AuthenticationType: String {
    case login
    case signup

    var text: String {
        rawValue.capitalized
    }

    var footerText: String {
        switch self {
            case .login:
                return "Don't have an account? Signup"

            case .signup:
                return "Already have an account? Login"
        }
    }
}

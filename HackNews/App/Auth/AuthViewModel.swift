import SwiftUI
import FirebaseAuth

class AuthViewModel: ObservableObject {
    @Published var userSession: FirebaseAuth.User?
    @Published var isAuthenticating = false
    @Published var error: String?
    @Published var user: User?
    
    init() {
        self.userSession = Auth.auth().currentUser
        fetchUser()
    }
    
    func login(withEmail email: String, password: String) {
        self.isAuthenticating = true
        self.error = nil
        
        Auth.auth().signIn(withEmail: email, password: password) { result, error in
            self.isAuthenticating = false
            
            if let error = error {
                self.error = error.localizedDescription
                return
            }
            
            self.userSession = result?.user
            self.fetchUser()
        }
    }
    
    func register(withEmail email: String, password: String, fullname: String) {
        self.isAuthenticating = true
        self.error = nil
        
        Auth.auth().createUser(withEmail: email, password: password) { result, error in
            self.isAuthenticating = false
            
            if let error = error {
                self.error = error.localizedDescription
                return
            }
            
            guard let user = result?.user else { return }
            
            // Create user data
            let userData = ["email": email,
                            "fullname": fullname,
                            "uid": user.uid]
            
            // TODO: Store user data in Firestore (if needed)
            
            self.userSession = user
            self.user = User(id: user.uid, fullname: fullname, email: email)
        }
    }
    
    func signOut() {
        do {
            try Auth.auth().signOut()
            self.userSession = nil
            self.user = nil
        } catch {
            self.error = error.localizedDescription
        }
    }
    
    func fetchUser() {
        guard let uid = userSession?.uid else { return }
        
        // TODO: Fetch user data from Firestore if needed
        // For now, we'll create a simple user with the available info
        if let email = userSession?.email {
            self.user = User(id: uid, fullname: "", email: email)
        }
    }
}

struct User: Identifiable {
    let id: String
    let fullname: String
    let email: String
} 
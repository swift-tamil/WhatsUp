//
//  LoginView.swift
//  WhatsUp
//
//  Created by python on 06/11/23.
//

import SwiftUI
import FirebaseAuth

struct LoginView: View {
    
    @State private var email: String = ""
    @State private var password: String = ""
    
    @EnvironmentObject private var appstate: AppState
    
    private var isFormValidate : Bool{
        !email.isEmptyOrWhiteSpace && !password.isEmptyOrWhiteSpace
    }
    
    private func login() async{
        
        do{
            let _ = try await Auth.auth().signIn(withEmail: email, password: password)
            
            appstate.routes.append(.main)
        
        }
        catch{
            print(error.localizedDescription)
        }
    }
    var body: some View {
     
        Form {
            
            TextField("Email", text: $email)
                .textInputAutocapitalization(.never)
            SecureField("Password", text: $password)
                .textInputAutocapitalization(.never)
            
            HStack{
                Spacer()
                Button("Login") {
                    Task{
                        appstate.routes.append(.login)
                    }
                } .disabled(!isFormValidate)
                    .buttonStyle(.borderless)
                
                Button("SignUP"){
                    appstate.routes.append(.signup)
                }
                .buttonStyle(.borderless)
                Spacer()
            }
        }
    }
}

#Preview {
    LoginView()
        .environmentObject(UserModel())
        .environmentObject(AppState())
}

//
//  SignupView.swift
//  WhatsUp
//
//  Created by python on 28/10/23.
//

import SwiftUI
import FirebaseAuth

struct SignupView: View {
    
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var displayName: String = ""
    @State private var errorMessage: String = ""
    
    private var isFormValidate : Bool{
        !email.isEmptyOrWhiteSpace && !password.isEmptyOrWhiteSpace && !displayName.isEmptyOrWhiteSpace
    }
    
    private func updateUserName(user: User) async{
            
        let request = user.createProfileChangeRequest()
        request.displayName = displayName
        try? await request.commitChanges()
        
    }
    
    private func signUp() async{
        do{
            let result = try await Auth.auth().createUser(withEmail: email, password: password)
           await updateUserName(user: result.user)
        }
        catch{
            errorMessage = error.localizedDescription
        }
    }
    
   
    
    var body: some View {
        Form {
        
            TextField("Email", text: $email)
                .textInputAutocapitalization(.never)
            SecureField("Password", text: $password)
                .textInputAutocapitalization(.never)
            TextField("DisplayName", text: $displayName)
            
            HStack{
                Spacer()
                Button("SignUP") {
                    Task{
                        await signUp()
                    }
                } .disabled(!isFormValidate)
                    .buttonStyle(.borderless)
                
                Button("Login"){
                    
                }
                .buttonStyle(.borderless)
                Spacer()
            }
            
            Text(errorMessage)
        }
    }
}

struct SignupView_Previews: PreviewProvider {
    static var previews: some View {
        SignupView()
    }
}

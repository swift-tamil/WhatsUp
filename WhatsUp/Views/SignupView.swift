//
//  SignupView.swift
//  WhatsUp
//
//  Created by python on 28/10/23.
//

import SwiftUI

struct SignupView: View {
    
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var displayName: String = ""
    
    private var isFormValidate : Bool{
        !email.isEmptyOrWhiteSpace && !password.isEmptyOrWhiteSpace && !displayName.isEmptyOrWhiteSpace
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
                Button("Sign UP") {
                    Task{
                        
                    }
                } .disabled(!isFormValidate)
                    .buttonStyle(.borderless)            }
        }
    }
}

struct SignupView_Previews: PreviewProvider {
    static var previews: some View {
        SignupView()
    }
}

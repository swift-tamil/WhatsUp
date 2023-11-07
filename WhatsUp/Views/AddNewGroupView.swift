//
//  AddNewGroupView.swift
//  WhatsUp
//
//  Created by python on 06/11/23.
//

import SwiftUI

struct AddNewGroupView: View {
    
    @Environment(\.dismiss) private var dismiss
    @State private var groupSubject: String = ""
    
    @EnvironmentObject private var userModel: UserModel
    
    private var isFormValidate : Bool{
        !groupSubject.isEmptyOrWhiteSpace
    }
    
    private func saveGroup(){
        let group = Group(subject: groupSubject)
        userModel.saveGroup(group: group) { error in
            
            if let error {
                print(error.localizedDescription)
            }
            
            dismiss()
        }
        
    }
    
    var body: some View {
        
        NavigationStack{
            
            VStack{
                HStack{
                    TextField("Group Subject", text: $groupSubject)
                }
                Spacer()
            }  .toolbar{
                ToolbarItem(placement: .principal) {
                    Text("New Group")
                        .bold()
                }
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel"){
                        dismiss()
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Create"){
                        saveGroup()
                    }
                    .disabled(!isFormValidate)
                }
            }
        }  
        .padding()
    }
}

#Preview {
    NavigationStack{
        AddNewGroupView()
    }
    .environmentObject(UserModel())
}

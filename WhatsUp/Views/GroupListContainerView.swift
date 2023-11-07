//
//  GroupListContainerView.swift
//  WhatsUp
//
//  Created by python on 06/11/23.
//

import SwiftUI

struct GroupListContainerView: View {
    
    @State private var ispresented: Bool = false
    
    @EnvironmentObject private var userModel: UserModel
    
    var body: some View {
        
        VStack{
            HStack{
                Spacer()
                Button("New Group"){
                    ispresented = true
                }
            }
           
            GroupListView(groups: userModel.groups)
            
            Spacer()
        }
        .task {
            do{
                try await userModel.populateGroups()
            }
            catch{
                print(error)
            }
        }
        .padding()
        .sheet(isPresented: $ispresented, content: {
            AddNewGroupView()
        })
    }
}

#Preview {
    GroupListContainerView()
        .environmentObject(UserModel())
}


//
//  GroupDetailView.swift
//  WhatsUp
//
//  Created by python on 07/11/23.
//

import SwiftUI
import FirebaseAuth

struct GroupDetailView: View {
    
    let group: Group
    
    @State private var chatText: String = ""
    @EnvironmentObject private var userModel: UserModel
    
    private func sendmessage() async throws{
        
        guard let currentUser = Auth.auth().currentUser else { return }
        
        let chatMessage = ChatMessage(text: chatText, uid: currentUser.uid, displayName: currentUser.displayName ?? "Guest")
        
       try await userModel.saveChatMessageToGroup(chatMessage: chatMessage, group: group)
    }
    
    var body: some View {
        
        VStack{
            
            ScrollViewReader{ proxy in
                ChatMessageListView(chatMessages: userModel.chatMessages)
                    .onChange(of: userModel.chatMessages) { value in
                        if !userModel.chatMessages.isEmpty{
                            let lastChatMessage = userModel.chatMessages[userModel.chatMessages.endIndex - 1]
                            withAnimation {
                                proxy.scrollTo(lastChatMessage.id, anchor: .bottom)
                            }
                        }
                    }
            }
            
            Spacer()
            TextField("Enter Chat message", text: $chatText)
            Button("Send"){
//                userModel.saveChatMessageToGroup(text: chatText, group: group) { error in
//                }
                Task{
                    do{
                        try await sendmessage()
                    }
                    catch{
                        print(error.localizedDescription)
                    }
                }
            }
            .padding()
            .onDisappear{
                userModel.detachFirebaseListerner()
            }
            .onAppear{
                userModel.listenForChatMeassages(in: group)
            }
        }
    }
}

#Preview {
    GroupDetailView(group: Group(subject: "Movies"))
        .environmentObject(UserModel())
}

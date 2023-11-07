//
//  ChatMessageView.swift
//  WhatsUp
//
//  Created by python on 07/11/23.
//

import SwiftUI


enum ChatMessageDirection{
    case left
    case right
}

struct ChatMessageView: View {
    
    let chatMessage: ChatMessage
    let direction: ChatMessageDirection
    let color: Color
    
    var body: some View {
        HStack{
            
            VStack(alignment: .leading, spacing: 5){
                Text(chatMessage.displayName)
                    .opacity(0.8)
                    .font(.caption)
                
                Text(chatMessage.text)
                Text(chatMessage.dateCreated, format: .dateTime)
                    .font(.caption)
                    .opacity(0.8)
                    .frame(maxWidth: 200, alignment: .trailing)
            }
            .foregroundColor(.white)
            .padding(8)
            .background(color)
            .clipShape(RoundedRectangle(cornerRadius: 10.0, style: .continuous))
        }
        .listRowSeparator(.hidden)
        .overlay(alignment: direction == .left ? .bottomLeading : .bottomTrailing) {
            Image(systemName: "arrowtriangle.down.fill")
                .font(.title)
                .foregroundColor(color)
                .rotationEffect(.degrees(direction == .left ? 45 : -45))
                .offset(x: direction == .left ? 30 : -30, y:10)
        }
    }
}

#Preview {
    ChatMessageView(chatMessage:ChatMessage(text: "Hello World", uid: "ASDF", displayName: "Allah"), direction: .right, color: .blue)
}

//
//  MainView.swift
//  WhatsUp
//
//  Created by python on 06/11/23.
//

import SwiftUI

struct MainView: View {
    var body: some View {
        TabView{
            GroupListContainerView()
                .tabItem { Label("Chats", systemImage: "message.fill") }
            
            Text("Settings")
                .tabItem { Label("Settings", systemImage: "gear") }
        }
    }
}

#Preview {
    MainView()
}

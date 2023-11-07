//
//  WhatsUpApp.swift
//  WhatsUp
//
//  Created by python on 28/10/23.
//

import SwiftUI
import FirebaseCore
import FirebaseAuth

class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    FirebaseApp.configure()
    return true
  }
}

@main
struct WhatsUpApp: App {
    
    // register app delegate for Firebase setup
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    @StateObject private var userModel = UserModel()
    @StateObject private var appstate = AppState()
    
    var body: some Scene {
        WindowGroup {
           
            NavigationStack(path: $appstate.routes){
                
                ZStack{
                    
                    if Auth.auth().currentUser != nil{
                        MainView()
//                        SignupView()
                    }
                    else{
                        LoginView()
                    }
                }
                .navigationDestination(for: Routes.self) { route in
                    switch route{
                    case .main:
                        MainView()
                    case .login:
                        LoginView()
                    case .signup:
                        SignupView()
                    }
                }
                
            }
            .environmentObject(userModel)
            .environmentObject(appstate)
           
        }
    }
}

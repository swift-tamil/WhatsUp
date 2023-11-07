//
//  Routes.swift
//  WhatsUp
//
//  Created by python on 06/11/23.
//

import Foundation

enum Routes: Hashable{
    
    case login
    case signup
    case main
    
}

class AppState: ObservableObject{
    
    @Published var routes: [Routes] = []
    
}

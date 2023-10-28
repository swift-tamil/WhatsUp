//
//  String+Extentions.swift
//  WhatsUp
//
//  Created by python on 28/10/23.
//

import Foundation
import SwiftUI

extension String {
    
    var isEmptyOrWhiteSpace : Bool {
        self.trimmingCharacters(in: .whitespacesAndNewlines)
            .isEmpty
    }
}

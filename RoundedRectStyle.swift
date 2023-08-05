//
//  RoundedRectStyle.swift
//  CharacterCompanion
//
//  Created by Frederik Rex on 06/07/2023.
//

import Foundation
import SwiftUI

// Step 1: Define the custom ViewModifier
struct RoundedRectStyle: ViewModifier {
    var fillColor: Color
    var cornerRadius: CGFloat
    var shadowRadius: CGFloat
    
    func body(content: Content) -> some View {
        content
            .background(fillColor)
            .cornerRadius(cornerRadius)
            .shadow(color: .gray, radius: shadowRadius, x: 0, y: 0)
    }
}

// Step 2: Create an extension on View
extension View {
    func roundedRectStyle(fillColor: Color = .accentColor, cornerRadius: CGFloat = 12, shadowRadius: CGFloat = 5) -> some View {
        self.modifier(RoundedRectStyle(fillColor: fillColor, cornerRadius: cornerRadius, shadowRadius: shadowRadius))
    }
}

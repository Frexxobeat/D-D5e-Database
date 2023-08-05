//
//  BlurView.swift
//  CharacterCompanion
//
//  Created by Frederik Rex on 06/07/2023.
//

import SwiftUI

struct VisualEffectBlur: UIViewRepresentable {
    var style: UIBlurEffect.Style
    
    func makeUIView(context: UIViewRepresentableContext<Self>) -> UIVisualEffectView {
        return UIVisualEffectView(effect: UIBlurEffect(style: style))
    }
    
    func updateUIView(_ uiView: UIVisualEffectView, context: UIViewRepresentableContext<Self>) {
        uiView.effect = UIBlurEffect(style: style)
    }
}

//
//  ViewModifiers.swift
//  Crunch-App
//
//  Created by Ontiretse Motlagale on 2024/11/25.
//

import SwiftUI

struct DismissDiabledSheet: ViewModifier {
 
    func body(content: Content) -> some View {
        content
            .presentationDetents([.fraction(0.5)])
            .interactiveDismissDisabled()
            .presentationCornerRadius(40)
    }
    
}

//
//  CubeViewModifier.swift
//  GoutTracker
//
//  Created by Татьяна Макеева on 15.11.2024.
//

import SwiftUI

extension View {
    public func cube(cornerRadius: CGFloat = 26) -> some View {
        modifier(CubeViewModifier(cornerRadius: cornerRadius))
    }
}

private struct CubeViewModifier: ViewModifier {
    let cornerRadius: CGFloat
    
    func body(content: Content) -> some View {
        content
            .cornerRadius(cornerRadius)
    }
}

@available(iOS 17.0, *)
#Preview(traits: .fixedLayout(width: 300, height: 300)) {
    VStack {
        Text("Hello, World!")
        Text("Hello, World!")
        Text("Hello, World!")
    }
    .background(Color.red)
    .cube()
}

//
//  Spaced.swift
//  GoutTracker
//
//  Created by Татьяна Макеева on 29.11.2024.
//

import SwiftUI

extension View {
    public func spaced() -> some View {
        modifier(SpacedModifier())
    }
}

private struct SpacedModifier: ViewModifier {
    struct SpacedLayout: _VariadicView_MultiViewRoot {
        @ViewBuilder
        func body(children: _VariadicView.Children) -> some View {
            let last = children.last?.id

            ForEach(children) { child in
                child

                if child.id != last {
                    Spacer()
                }
            }
        }
    }
    func body(content: Content) -> some View {
        _VariadicView.Tree(SpacedLayout()) {
            content
        }
    }
}

@available(iOS 17.0, *)
#Preview {
    VStack {
        VStack {
            Group {
                Text("Alpha")
                Text("Beta")
                Text("Gamma")
            }
            .spaced()
        }
        
        HStack {
            Group {
                Text("Alpha")
                Text("Beta")
                Text("Gamma")
            }
            .spaced()
        }
    }
}

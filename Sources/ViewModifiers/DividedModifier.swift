//
//  Divided.swift
//  GoutTracker
//
//  Created by Татьяна Макеева on 29.11.2024.
//

import SwiftUI

extension View {
    public func divided() -> some View {
        modifier(DividedModifier())
    }
}

private struct DividedModifier: ViewModifier {
    struct DividedLayout: _VariadicView_MultiViewRoot {
        @ViewBuilder
        func body(children: _VariadicView.Children) -> some View {
            let last = children.last?.id

            ForEach(children) { child in
                child

                if child.id != last {
                    Divider()
                }
            }
        }
    }
    func body(content: Content) -> some View {
        _VariadicView.Tree(DividedLayout()) {
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
            .divided()
        }
        
        HStack {
            Group {
                Text("Alpha")
                Text("Beta")
                Text("Gamma")
            }
            .divided()
        }
    }
}

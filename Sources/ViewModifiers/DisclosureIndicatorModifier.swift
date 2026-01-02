//
//  DisclosureIndicatorModifier.swift
//  GoutTracker
//
//  Created by Татьяна Макеева on 15.11.2024.
//

import SwiftUI

extension View {
    public func disclosureIndicator(
        tapAction: (() -> Void)? = nil,
        foregroundColor: Color? = nil
    ) -> some View {
        modifier(DisclosureIndicatorModifier(
            tapAction: tapAction,
            foregroundColor: foregroundColor
        ))
    }
}

private struct DisclosureIndicatorModifier: ViewModifier {
    let tapAction: (() -> Void)?
    let foregroundColor: Color?
    
    func body(content: Content) -> some View {
        Button {
            tapAction?()
        } label: {
            HStack {
                content
                Spacer()
                Image(systemName: "chevron.right")
                    .modifier(let: foregroundColor) { view, foregroundColor in
                        view
                            .renderingMode(.template)
                            .foregroundColor(foregroundColor)
                    }
            }
        }
    }
}


#Preview {
    Text("Hello, World!")
        .disclosureIndicator(tapAction: {})
}

//
//  TouchGestureViewModifier.swift
//  GoutTracker
//
//  Created by Татьяна Макеева on 15.11.2024.
//

import SwiftUI

extension View {
    public func onTouchGesture(
        touchBegan: @escaping () -> Void,
        touchEnd: @escaping (Bool) -> Void
    ) -> some View {
        modifier(TouchGestureViewModifier(
            touchBegan: touchBegan,
            touchEnd: touchEnd
        ))
    }
}

private struct TouchGestureViewModifier: ViewModifier {
    let touchBegan: () -> Void
    let touchEnd: (Bool) -> Void

    @State private var hasBegun = false
    @State private var hasEnded = false

    private func isTooFar(_ translation: CGSize) -> Bool {
        let distance = sqrt(pow(translation.width, 2) + pow(translation.height, 2))
        return distance >= 20.0
    }

    func body(content: Content) -> some View {
        content.gesture(DragGesture(minimumDistance: 0)
            .onChanged { event in
                guard !self.hasEnded else { return }
                
                if self.hasBegun == false {
                    self.hasBegun = true
                    self.touchBegan()
                } else if self.isTooFar(event.translation) {
                    self.hasEnded = true
                    self.touchEnd(false)
                }
            }
            .onEnded { event in
                if !self.hasEnded {
                    let success = !self.isTooFar(event.translation)
                    self.touchEnd(success)
                }
                self.hasBegun = false
                self.hasEnded = false
            }
        )
    }
}

//
//  View+Conditional.swift
//  GoutTracker
//
//  Created by Татьяна Макеева on 29.11.2024.
//

import SwiftUI

extension View {
    /// Applies the given transform if the given condition evaluates to `true`.
    /// - Parameters:
    ///   - condition: The condition to evaluate.
    ///   - transform: The transform to apply to the source `View`.
    /// - Returns: Either the original `View` or the modified `View` if the condition is `true`.
    @ViewBuilder public func `if`<Content: View>(_ condition: Bool, transform: (Self) -> Content) -> some View {
        if condition {
            transform(self)
        } else {
            self
        }
    }
}

extension View {
    /// Applies a modifier to a view if an optional item can be unwrapped.
    ///
    ///     someView
    ///         .modifier(let: model) {
    ///             $0.background(BackgroundView(model.bg))
    ///         }
    ///
    /// - Parameters:
    ///   - condition: The optional item to determine if the content should be applied.
    ///   - content: The modifier and unwrapped item to apply to the view.
    /// - Returns: The modified view.
    @ViewBuilder public func modifier<T: View, Item>(
        `let` item: Item?,
        then content: (Self, Item) -> T
    ) -> some View {
        if let item {
            content(self, item)
        } else {
            self
        }
    }
}

@ViewBuilder public func doTry(
    @ViewBuilder try success: () throws -> some View,
    @ViewBuilder catch failure: (any Error) -> some View
) -> some View {
    switch Result(catching: success) {
    case .success(let success):
        success
    case .failure(let error):
        failure(error)
    }
}

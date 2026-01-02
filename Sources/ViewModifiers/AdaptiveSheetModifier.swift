//
//  AdaptiveSheetModifier.swift
//  Dependencies
//
//  Created by Татьяна Макеева on 24.08.2025.
//

import SwiftUI

extension View {
    public func adaptiveSheet<Item: Identifiable, SheetContent: View>(
        item: Binding<Item?>,
        onDismiss: (() -> Void)? = nil,
        @ViewBuilder content: @escaping (Item) -> SheetContent
    ) -> some View {
        self.modifier(AdaptiveSheetModifier(
            item: item,
            onDismiss: onDismiss,
            makeContent: content
        ))
    }
    
    public func adaptiveSheet<SheetContent: View>(
        isPresented: Binding<Bool>,
        onDismiss: (() -> Void)? = nil,
        @ViewBuilder content: @escaping () -> SheetContent
    ) -> some View {
        self.modifier(AdaptiveBoolSheetModifier(
            isPresented: isPresented,
            onDismiss: onDismiss,
            makeContent: content
        ))
    }
}

private struct AdaptiveBoolSheetModifier<SheetContent: View>: ViewModifier {
    @Binding var isPresented: Bool
    let onDismiss: (() -> Void)?
    let makeContent: () -> SheetContent

    @Environment(\.horizontalSizeClass) private var hSizeClass

    func body(content: Content) -> some View {
        content
            .background(
                Group {
                    if hSizeClass == .regular {
                        // iPad / regular width → fullscreen
                        Color.clear
                            .fullScreenCover(isPresented: $isPresented, onDismiss: onDismiss, content: makeContent)
                    } else {
                        // iPhone / compact width → sheet
                        Color.clear
                            .sheet(isPresented: $isPresented, onDismiss: onDismiss, content: makeContent)
                    }
                }
            )
    }
}

private struct AdaptiveSheetModifier<Item: Identifiable, SheetContent: View>: ViewModifier {
    @Binding var item: Item?
    let onDismiss: (() -> Void)?
    let makeContent: (Item) -> SheetContent

    @Environment(\.horizontalSizeClass) private var hSizeClass

    func body(content: Content) -> some View {
        content
            .background(
                Group {
                    if hSizeClass == .regular {
                        // iPad / regular width → fullscreen
                        Color.clear
                            .fullScreenCover(item: $item, onDismiss: onDismiss, content: makeContent)
                    } else {
                        // iPhone / compact width → sheet
                        Color.clear
                            .sheet(item: $item, onDismiss: onDismiss, content: makeContent)
                    }
                }
            )
    }
}

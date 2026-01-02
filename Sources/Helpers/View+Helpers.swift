//
//  View+Helpers.swift
//  GoutTracker
//
//  Created by Татьяна Макеева on 24.12.2024.
//

import SwiftUI

extension View {
    public func hidden(_ shouldHide: Bool) -> some View {
        opacity(shouldHide ? 0 : 1)
    }
}

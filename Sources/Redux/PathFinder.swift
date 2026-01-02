//
//  PathFinder.swift
//  Storage
//
//  Created by Татьяна Макеева on 18.04.2025.
//

import Foundation
import SwiftUI

public final class PathFinder<Route: Hashable>: ObservableObject {
    @Published public var path: Route?
    @Published public var sheetRoute: Route?
    
    public init() {}
    
    public func push(route: Route) {
        path = route
    }
    
    public func present(route: Route) {
        sheetRoute = route
    }
}

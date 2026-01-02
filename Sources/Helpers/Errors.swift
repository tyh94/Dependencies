//
//  Errors.swift
//  LazyMum
//
//  Created by Татьяна Макеева on 24.07.2024.
//

import Foundation

infix operator !!: NilCoalescingPrecedence
infix operator ?!: NilCoalescingPrecedence

public func !!<T>(value: T?, error: @autoclosure () -> String) -> T {
    if let value = value { return value }
    fatalError(error())
}

public func ?!<T>(value: T?, error: @autoclosure () -> Error) throws -> T {
    if let value = value { return value }
    throw error()
}

extension String: @retroactive Error {}


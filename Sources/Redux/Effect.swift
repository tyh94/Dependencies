//
//  Effect.swift
//  Dependencies
//
//  Created by Татьяна Макеева on 14.04.2025.
//

import Foundation

public struct Effect<Feedback, Output> {
    public typealias Operation = (@Sendable @escaping (Feedback) async -> Void) async -> Void
    
    let output: Output?
    let operation: Operation

    public init(
        output: Output?,
        operation: @escaping Operation
    ) {
        self.output = output
        self.operation = operation
    }
}

public extension Effect {
    static var none: Self {
        Effect(output: nil) { _ in }
    }

    static func output(_ output: Output) -> Self {
        Effect(output: output) { _ in }
    }
    
    static func run(output: Output, operation: @escaping Operation) -> Self {
        Effect(output: output, operation: operation)
    }

    static func run(operation: @escaping Operation) -> Self {
        Effect(output: nil, operation: operation)
    }
}

//
//  Reducer.swift
//  Dependencies
//
//  Created by Татьяна Макеева on 14.04.2025.
//

import Foundation

@MainActor
public protocol Reducer<State, Input, Feedback, Output>: AnyObject where State: Equatable {
    associatedtype State
    associatedtype Input
    associatedtype Feedback = Never
    associatedtype Output = Never

    func reduce(
        message: Message<Input, Feedback>,
        into state: inout State
    ) -> Effect<Feedback, Output>
}

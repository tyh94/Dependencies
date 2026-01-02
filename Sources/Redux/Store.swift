//
//  Store.swift
//  Dependencies
//
//  Created by Татьяна Макеева on 14.04.2025.
//

import Foundation
import Combine

@MainActor
@dynamicMemberLookup
public class Store<State, Input, Feedback, Output>: ObservableObject where State: Equatable, Input: Sendable, Feedback: Sendable {
    public typealias StoreReducer = Reducer<State, Input, Feedback, Output>
    
    @Published
    public private(set) var state: State

    private let reducer: any StoreReducer

    private let stateSubject: CurrentValueSubject<State, Never>
    public lazy var stateStream = stateSubject.removeDuplicates().values

    private let outputSubject: PassthroughSubject<Output, Never> = .init()
    public lazy var outputStream = outputSubject.values

    private var tasks: [Task<Void, Never>] = []

    deinit {
        for task in tasks {
            task.cancel()
        }
    }

    public init(
        state: State,
        reducer: some StoreReducer
    ) {
        self.state = state
        self.reducer = reducer
        stateSubject = .init(state)
    }

    @discardableResult
    public func send(_ message: Input) -> Task<Void, Never> {
        let task = Task { await send(.input(message)) }
        tasks.append(task)
        return task
    }

    public func send(_ message: Input) async {
        await send(.input(message))
    }

    private func send(_ message: Message<Input, Feedback>) async {
        guard !Task.isCancelled else { return }

        let effect = reducer.reduce(message: message, into: &state)
        stateSubject.send(state)

        if let output = effect.output {
            outputSubject.send(output)
        }

        await effect.operation { [weak self] feedback in
            guard !Task.isCancelled else { return }

            await self?.send(.feedback(feedback))
        }
    }

    public subscript<Value>(dynamicMember keypath: KeyPath<State, Value>) -> Value {
        state[keyPath: keypath]
    }
}

//
//  Message.swift
//  Dependencies
//
//  Created by Татьяна Макеева on 14.04.2025.
//

import Foundation

public enum Message<Input, Feedback>: Sendable where Input: Sendable, Feedback: Sendable {
    case input(Input)
    case feedback(Feedback)
}

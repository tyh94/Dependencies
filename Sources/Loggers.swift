//
//  Loggers.swift
//  GoutTracker
//
//  Created by Татьяна Макеева on 04.01.2025.
//

import OSLog
import SwiftUI

extension Logger {
    private static let subsystem = Bundle.main.bundleIdentifier!

    static let viewCycle = Logger(subsystem: subsystem, category: "viewcycle")

    static let notifications = Logger(subsystem: subsystem, category: "notifications")
    
    static let database = Logger(subsystem: subsystem, category: "database")
    
    static func viewLogger(_ view: any View.Type) -> Logger {
        Logger(subsystem: subsystem, category: "viewui-\(view.self)")
    }
}

extension Logger {
    public func error(error: Error, file: String = #file, function: String = #function, line: Int = #line) {
        let fileInfo = "\(file):\(line):\(function)"
        self.error("\(fileInfo): error:\(error.localizedDescription, privacy: .public)")
    }
    
    public func debug(message: String, file: String = #file, function: String = #function, line: Int = #line) {
        let fileInfo = "\(file):\(line):\(function)"
        self.debug("\(fileInfo): \(message)")
    }
    
    public func info(message: String, file: String = #file, function: String = #function, line: Int = #line) {
        let fileInfo = "\(file):\(line):\(function)"
        self.info("\(fileInfo): \(message)")
    }
    
    public func warning(message: String, file: String = #file, function: String = #function, line: Int = #line) {
        let fileInfo = "\(file):\(line):\(function)"
        self.warning("\(fileInfo): \(message)")
    }
}

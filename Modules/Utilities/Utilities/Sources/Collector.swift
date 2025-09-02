//
//  Collector.swift
//  Utilities
//
//  Created by Тигран Гарибян on 26.08.2025.
//

import Foundation

public final class Collector<T: AnyObject>: @unchecked Sendable {
    private let lock = NSLock()
    private var slots: [T?]
    private var firstError: Swift.Error?
    
    public init(count: Int) {
        slots = Array(repeating: nil, count: count)
    }
    
    public func addImage(_ slot: T, at index: Int) {
        lock.lock()
        defer { lock.unlock() }
        slots[index] = slot
    }
    
    public func setError(_ error: Swift.Error) {
        lock.lock()
        defer { lock.unlock() }
        if firstError == nil {
            firstError = error
        }
    }
    
    public var result: Result<[T], Swift.Error> {
        lock.lock()
        defer { lock.unlock() }
        if let error = firstError {
            return .failure(error)
        } else {
            return .success(slots.compactMap { $0 })
        }
    }
}

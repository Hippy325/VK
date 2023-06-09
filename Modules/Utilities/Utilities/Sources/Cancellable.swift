//
//  Cancellable.swift
//  Utilities
//
//  Created by User on 09.06.2023.
//

import Foundation

public protocol ICancellable: AnyObject {
	func cancel()
}

public final class Cancellable: ICancellable {
	public init(_ closure: @escaping () -> Void) {
		self.closure = closure
	}

	var closure: () -> Void

	public func cancel() {
		closure()
	}
}

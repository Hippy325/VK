//
//  IAPIRequest.swift
//  VK
//
//  Created by User on 29.04.2023.
//

import Foundation

public protocol IAPIRequest {
	associatedtype Response: Decodable

	var path: String { get }
	var parameters: [String: String] { get }
	var headers: [String: String] { get }
	var userIdPath: String { get }

	var needToken: Bool { get }
}

public extension IAPIRequest {
	var parameters: [String: String] {
		[:]
	}
	var headers: [String: String] {
		[:]
	}

	var needToken: Bool {
		true
	}
}

public protocol ICancellable: AnyObject {
	func cancel()
}

public final class Cancellable: ICancellable {
	internal init(_ closure: @escaping () -> Void) {
		self.closure = closure
	}

	var closure: () -> Void

	public func cancel() {
		closure()
	}
}

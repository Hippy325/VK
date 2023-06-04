//
//  IAPIRequest.swift
//  VK
//
//  Created by User on 29.04.2023.
//

import Foundation

protocol IAPIRequest {
	associatedtype Response: Decodable

	var path: String { get }
	var parameters: [String: String] { get }
	var headers: [String: String] { get }
	var userIdPath: String { get }

	var needToken: Bool { get }
}

extension IAPIRequest {
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

protocol ICancellable: AnyObject {
	func cancel()
}

final class Cancellable: ICancellable {
	internal init(_ closure: @escaping () -> Void) {
		self.closure = closure
	}


	var closure: () -> Void

	func cancel() {
		closure()
	}
}

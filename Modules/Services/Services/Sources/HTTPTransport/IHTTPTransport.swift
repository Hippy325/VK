//
//  IHTTPTransport.swift
//  VK
//
//  Created by User on 26.04.2023.
//

import Foundation
import Utilities

public protocol IHTTPTransport {
	@discardableResult
	func load<T: Decodable>(
		url: URL,
		responseType: T.Type,
		complition: @escaping (Result<T, Error>) -> Void
	) -> ICancellable

	@discardableResult
	func loadData(
		url: URL,
		completion: @escaping (Result<Data, Error>) -> Void
	) -> ICancellable

	@discardableResult
	func load<T: Decodable>(
		urlRequest: URLRequest,
		responseType: T.Type,
		complition: @escaping (Result<T, Error>) -> Void
	) -> ICancellable
}

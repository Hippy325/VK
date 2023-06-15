//
//  IHTTPTransportPublishers.swift
//  Services
//
//  Created by User on 09.06.2023.
//

import Foundation
import Combine

public protocol IHTTPTransportPublishers {
	func loadPublisher<T: Decodable>(
		urlRequest: URLRequest,
		responseType: T.Type
	) -> AnyPublisher<T, Error>

	func loadPublisher(
		urlRequest: URLRequest
	) -> AnyPublisher<Data, Error>
}

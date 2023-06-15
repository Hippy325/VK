//
//  HTTPTransportPublishers.swift
//  Services
//
//  Created by User on 09.06.2023.
//

import Foundation
import Combine

public final class HTTPTransportPublishers: IHTTPTransportPublishers {
	private let session: URLSession
	private let decoder: JSONDecoder

	public init(session: URLSession = .shared, decoder: JSONDecoder) {
		self.session = session
		self.decoder = decoder
	}

	public func loadPublisher<T>(
		urlRequest: URLRequest,
		responseType: T.Type
	) -> AnyPublisher<T, Error> where T: Decodable {
		session.dataTaskPublisher(for: urlRequest)
			.map { $0.data }
			.decode(type: responseType.self, decoder: decoder)
			.catch { Fail(error: $0) }
			.eraseToAnyPublisher()
	}

	public func loadPublisher(
		urlRequest: URLRequest
	) -> AnyPublisher<Data, Error> {
		session.dataTaskPublisher(for: urlRequest)
			.map { $0.data }
			.catch { Fail(error: $0) }
			.eraseToAnyPublisher()
	}
}

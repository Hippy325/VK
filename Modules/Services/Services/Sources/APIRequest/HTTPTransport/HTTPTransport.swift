//
//  HTTPTransport.swift
//  VK
//
//  Created by User on 26.04.2023.
//

import Foundation

public final class HTTPTransport: IHTTPTransport {
	private let session: URLSession
	private let decoder: JSONDecoder

	public init(session: URLSession = .shared, decoder: JSONDecoder) {
		self.session = session
		self.decoder = decoder
	}

	public func load<T: Decodable>(
		url: URL,
		responseType: T.Type,
		complition: @escaping (Result<T, Error>) -> Void
	) -> ICancellable {
		let task = session.dataTask(with: url) { [decoder] (data, _, error) in
			if let error = error {
				return complition(.failure(error))
			}

			if let data = data {
				do {
					let decodeData = try decoder.decode(responseType.self, from: data)
					return complition(.success(decodeData))
				} catch let error {
					return complition(.failure(error))
				}
			}
			return
		}

		task.resume()
		return task
	}

	public func loadData(url: URL, completion: @escaping (Result<Data, Error>) -> Void) -> ICancellable {

		let task = session.dataTask(with: url) { (data, _, error) in
			if let data = data {
				completion(.success(data))
			} else if let error = error {
				completion(.failure(error))
			}
		}

		task.resume()
		return task
	}

	public func load<T>(
		urlRequest: URLRequest,
		responseType: T.Type,
		complition: @escaping (Result<T, Error>) -> Void
	) -> ICancellable where T: Decodable {
		let task = session.dataTask(with: urlRequest) { [decoder] (data, _, error) in
			if let error = error {
				return complition(.failure(error))
			}

			if let data = data {
				do {
					let decodeData = try decoder.decode(responseType.self, from: data)
					return complition(.success(decodeData))
				} catch let error {
					return complition(.failure(error))
				}
			}
			return
		}

		task.resume()

		return task
	}
}

extension URLSessionTask: ICancellable {}

//
//  HTTPTransport.swift
//  VK
//
//  Created by User on 26.04.2023.
//

import Foundation

final class HTTPTransport: IHTTPTransport {
	private let session: URLSession
	private let decoder: JSONDecoder

	init(session: URLSession = .shared, decoder: JSONDecoder) {
		self.session = session
		self.decoder = decoder
	}

	func load<T: Decodable>(
		url: URL,
		responseType: T.Type,
		complition: @escaping (Result<T, Error>) -> Void
	) -> ICancellable {
		let task = session.dataTask(with: url) { [decoder] (data, response, error) in
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

	func loadData(url: URL, completion: @escaping (Result<Data, Error>) -> Void) -> ICancellable {

		let task = session.dataTask(with: url) { (data, response, error) in
			if let data = data {
				completion(.success(data))
			} else if let error = error {
				completion(.failure(error))
			}
		}

		task.resume()
		return task
	}

	func load<T>(
		urlRequest: URLRequest,
		responseType: T.Type,
		complition: @escaping (Result<T, Error>) -> Void
	) -> ICancellable where T : Decodable {
		let task = session.dataTask(with: urlRequest) { [decoder] (data, response, error) in
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

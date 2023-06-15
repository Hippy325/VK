//
//  APIRequestPublishers.swift
//  Services
//
//  Created by User on 12.06.2023.
//

import Foundation
import Combine
import Storage
import Utilities

public protocol IAPITransportPublishers {
	func perform<R: IAPIRequest>(
		_ request: R,
		_ userId: Int?
	) -> AnyPublisher<R.Response, Error>
}

public class APITransportPublishers: IAPITransportPublishers {
	enum Errors: String, Error {
		case invalidRequest
		case notHaveToken
	}

	private let httpTransport: IHTTPTransportPublishers
	private let tokenStorage: ITokenStorage

	public init(
		httpTransport: IHTTPTransportPublishers,
		tokenStorage: ITokenStorage
	) {
		self.httpTransport = httpTransport
		self.tokenStorage = tokenStorage
	}

	public func perform<R>(
		_ request: R,
		_ userId: Int?
	) -> AnyPublisher<R.Response, Error> where R: IAPIRequest {
		let nativeRequest: URLRequest

		switch getNativeRequest(from: request, userId) {
		case .success(let request):
			nativeRequest = request
		case .failure(let error):
			return Fail(error: error).eraseToAnyPublisher()
		}

		return httpTransport.loadPublisher(urlRequest: nativeRequest, responseType: R.Response.self)
	}

	private func getNativeRequest<R: IAPIRequest>(from request: R, _ userId: Int?) -> Result<URLRequest, Errors> {
		var urlCopmonents = URLComponents()
		urlCopmonents.scheme = "https"
		urlCopmonents.host = "api.vk.com"
		urlCopmonents.path = "/method/\(request.path)"

		urlCopmonents.queryItems = [
			.init(name: "v", value: "5.131")
		]

		if request.needToken {
			if let token = tokenStorage.token {
				urlCopmonents.queryItems?.append(URLQueryItem(name: "access_token", value: token))
			} else {
				return .failure(Errors.notHaveToken)
			}
		}

		if let userId = userId {
			urlCopmonents.queryItems?.append(.init(name: request.userIdPath, value: String(userId)))
		}

		request.parameters.forEach { (key, value) in
			urlCopmonents.queryItems?.append(URLQueryItem(name: key, value: value))
		}

		guard let url = urlCopmonents.url else {
			return .failure(Errors.invalidRequest)
		}

		var nativeRequest = URLRequest(url: url)
		nativeRequest.allHTTPHeaderFields = request.headers
		return .success(nativeRequest)
	}
}

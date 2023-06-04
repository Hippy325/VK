//
//  APIRequest.swift
//  VK
//
//  Created by User on 29.04.2023.
//

import Foundation

protocol IAPITransport {
	@discardableResult
	func perform<R: IAPIRequest>(
		_ request: R,
		_ userId: Int?,
		completion: @escaping (Result<R.Response, Error>) -> Void
	) -> ICancellable
}

class APITransport: IAPITransport {

	enum Errors: String, Error {
		case invalidRequest
		case notHaveToken
	}

	private let httpTransport: IHTTPTransport
	private let tokenStorage: ITokenStorage

	init(httpTransport: IHTTPTransport,
		 tokenStorage: ITokenStorage) {
		self.httpTransport = httpTransport
		self.tokenStorage = tokenStorage
	}

	@discardableResult
	func perform<R: IAPIRequest>(
		_ request: R,
		_ userId: Int? = nil,
		completion: @escaping (Result<R.Response, Error>) -> Void
	) -> ICancellable {
		let nativeRequest: URLRequest

		switch getNativeRequest(from: request, userId) {
		case .success(let unwrappedRequest):
			nativeRequest = unwrappedRequest
		case .failure(let error):
			completion(.failure(error))
			return Cancellable {}
		}

		return httpTransport.load(urlRequest: nativeRequest, responseType: R.Response.self) { result in
			completion(result)
		}
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

		print(url.absoluteString)
		var nativeRequest = URLRequest(url: url)
		nativeRequest.allHTTPHeaderFields = request.headers
		return .success(nativeRequest)
	}
}



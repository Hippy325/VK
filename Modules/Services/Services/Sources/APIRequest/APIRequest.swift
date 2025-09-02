//
//  APIRequest.swift
//  VK
//
//  Created by User on 29.04.2023.
//

import Foundation
import Storage
import Utilities

public protocol IAPITransport: Sendable {
    @discardableResult
    func perform<R: IAPIRequest>(
        _ request: R,
        _ userId: Int?
    ) async throws -> R.Response
}

public final class APITransport: IAPITransport {
    private let session: URLSession
	private let tokenStorage: ITokenStorage
    private let decoder: JSONDecoder

	public init(
        session: URLSession = .shared,
		tokenStorage: ITokenStorage,
        decoder: JSONDecoder = .init()
	) {
		self.session = session
		self.tokenStorage = tokenStorage
        self.decoder = decoder
	}

	public func perform<R: IAPIRequest>(
		_ request: R,
		_ userId: Int? = nil
	) async throws -> R.Response {
		let nativeRequest: URLRequest
        nativeRequest = try getNativeRequest(from: request, userId)
        let response = try await session.data(for: nativeRequest)
        let decodeResponse = try decoder.decode(R.Response.self, from: response.0)
        return decodeResponse
	}

	private func getNativeRequest<R: IAPIRequest>(
        from request: R,
        _ userId: Int?
    ) throws -> URLRequest {
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
                throw Errors.notHaveToken
			}
		}

		if let userId = userId {
			urlCopmonents.queryItems?.append(.init(name: request.userIdPath, value: String(userId)))
		}

		request.parameters.forEach { (key, value) in
			urlCopmonents.queryItems?.append(URLQueryItem(name: key, value: value))
		}

		guard let url = urlCopmonents.url else {
            throw Errors.invalidRequest
		}
		var nativeRequest = URLRequest(url: url)
		nativeRequest.allHTTPHeaderFields = request.headers
		return nativeRequest
	}
}

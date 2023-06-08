//
//  VKAuthorize.swift
//  VK
//
//  Created by User on 24.04.2023.
//

import Foundation
import WebKit

public protocol IAuthorizeDelegate: AnyObject {
	func user(token: String)
}

public final class VKAuthorizeView: WKWebView {
	private var urlAuthorize: URLComponents {
		var urlComponents = URLComponents()
		urlComponents.scheme = "https"
		urlComponents.host = "oauth.vk.com"
		urlComponents.path = "/authorize"
		urlComponents.queryItems = [
			.init(name: "client_id", value: "51623232"),
			.init(name: "redirect_uri", value: "https://oauth.vk.com/blank.html"),
			.init(name: "display", value: "mobile"),
			.init(name: "scope", value: "photos"),
			.init(name: "response_type", value: "token")
		]
		return urlComponents
	}

	private var isAuthorize = true

	public weak var delegate: IAuthorizeDelegate?

	public init() {
		super.init(frame: .zero, configuration: .init())
		setup()
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	private func setup() {
		navigationDelegate = self

		guard let url = urlAuthorize.url else { return }

		load(URLRequest(url: url))
	}

	private func splitFragmentURL(fragment: String) -> [String: String] {
		let array = fragment.split(separator: "&").map({ $0.split(separator: "=").map({ String($0) }) })
		var dictionary: [String: String] = [:]
		array.forEach { (queryItems) in
			if queryItems.count == 2 {
				dictionary[queryItems[0]] = queryItems[1]
			}
		}
		return dictionary
	}
}

extension VKAuthorizeView: WKNavigationDelegate {

	public func webView(
		_ webView: WKWebView,
		decidePolicyFor navigationResponse: WKNavigationResponse,
		decisionHandler: @escaping (WKNavigationResponsePolicy) -> Void
	) {
		guard
			let url = navigationResponse.response.url,
			let fragment = url.fragment,
			let token = splitFragmentURL(fragment: fragment)["access_token"]
		else {
			return decisionHandler(.allow)
		}
		decisionHandler(.cancel)
		delegate?.user(token: token)
	}
}

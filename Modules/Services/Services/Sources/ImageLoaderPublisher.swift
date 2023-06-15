//
//  ImageLoaderPublisher.swift
//  Services
//
//  Created by User on 12.06.2023.
//

import Foundation
import Combine
import UIKit

public protocol IImageLoaderPublisher {
	func loadImage(
		urlAbsolute: String
	) -> AnyPublisher<UIImage, Swift.Error>

	func loadImages(
		urlAbsolutes: [String]
	) -> AnyPublisher<UIImage, Swift.Error>
}

public final class ImageLoaderPublisher: IImageLoaderPublisher {

	public enum Error: String, Swift.Error {
		case cannotConvertDataToImage
		case invalidURL
	}

	private let lock = NSLock()
	private var images = NSCache<NSString, UIImage>()
	private var cancellable = Set<AnyCancellable>()

	private let httpTransport: IHTTPTransportPublishers

	public init(httpTransport: IHTTPTransportPublishers) {
		self.httpTransport = httpTransport
	}

	private func set(image: UIImage, for url: URL) {
		lock.lock()
		images.setObject(image, forKey: url.absoluteString as NSString)
		lock.unlock()
	}

	private func get(for url: URL) -> UIImage? {
		lock.lock()
		let image = images.object(forKey: url.absoluteString as NSString)
		lock.unlock()
		return image
	}

	public func loadImage(urlAbsolute: String) -> AnyPublisher<UIImage, Swift.Error> {
		guard let url = URL(string: urlAbsolute) else {
			return Fail(error: Error.invalidURL).eraseToAnyPublisher()
		}

		if let image = get(for: url) {
			return Just(image)
				.setFailureType(to: Swift.Error.self)
				.eraseToAnyPublisher()
		}

		return httpTransport.loadPublisher(urlRequest: URLRequest(url: url))
			.tryMap { data -> UIImage in
				guard let image = UIImage(data: data) else { throw Error.cannotConvertDataToImage }
				self.set(image: image, for: url)
				return image
			}
			.eraseToAnyPublisher()
	}

	public func loadImages(urlAbsolutes: [String]) -> AnyPublisher<UIImage, Swift.Error> {
		let publisher = PassthroughSubject<UIImage, Swift.Error>()

		for urlAbolute in urlAbsolutes {
			loadImage(urlAbsolute: urlAbolute)
				.sink { _ in }
					receiveValue: { (image) in
						DispatchQueue.main.asyncAfter(deadline: .now() + 0.01) {
							self.lock.lock()
							publisher.send(image)
							self.lock.unlock()
						}
					}
				.store(in: &cancellable)
		}
		return publisher.eraseToAnyPublisher()
	}
}

//
//  ImageLoader.swift
//  VK
//
//  Created by User on 27.04.2023.
//

import Foundation
import UIKit

public protocol IImageLoader {
	func loadImage(
		urlAbsolute: String,
		completion: @escaping (Result<UIImage, Error>) -> Void
	)

	func loadImages(
		urlAbsolutes: [String],
		complition: @escaping (Result<[UIImage], Swift.Error>) -> Void
		)
}

public final class ImageLoader: IImageLoader {
	enum Error: String, Swift.Error {
		case cannotConvertDataToImage
	}

	private let lock = NSLock()
	private var images = NSCache<NSString, UIImage>()

	private let httpTransport: IHTTPTransport

	public init(httpTransport: IHTTPTransport) {
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

	public func loadImage(
		urlAbsolute: String,
		completion: @escaping (Result<UIImage, Swift.Error>) -> Void
	) {
		guard let url = URL(string: urlAbsolute) else {
			return
		}
		if let image = get(for: url) {
			completion(.success(image))
			return
		}

		httpTransport.loadData(url: url) { (result) in
			switch result {
			case .success(let data):
				guard let image = UIImage(data: data) else {
					return completion(.failure(Error.cannotConvertDataToImage))
				}
				self.set(image: image, for: url)
				completion(.success(image))
			case .failure(let error):
				completion(.failure(error))
			}
		}
	}

	public func loadImages(
		urlAbsolutes: [String],
		complition: @escaping (Result<[UIImage], Swift.Error>) -> Void
	) {
		var images: [UIImage] = []
		let group = DispatchGroup()

		for urlAbsolut in urlAbsolutes {
			group.enter()
			self.loadImage(urlAbsolute: urlAbsolut) { (result) in
				self.lock.lock()
				switch result {
				case .failure(let error):
					complition(.failure(error))
					self.lock.unlock()
					return
				case .success(let image):
					images.append(image)
				}
				self.lock.unlock()
				group.leave()
			}
		}

		group.notify(queue: .main) {
			complition(.success(images))
		}
	}
}

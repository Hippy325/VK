//
//  ImageLoader.swift
//  VK
//
//  Created by User on 27.04.2023.
//

import Foundation
import UIKit

public protocol IImageLoader: Sendable {
    func loadImage(
        urlAbsolute: String
    ) async throws -> UIImage
    
    func loadImages(
        urlAbsolutes: [String]
    ) async throws -> [UIImage]
}

public actor ImageLoader: IImageLoader {
    private var images = NSCache<NSString, UIImage>()
    private let session: URLSession
    
    public init(session: URLSession) {
        self.session = session
    }
    
    private func set(image: UIImage, for url: URL) {
        images.setObject(image, forKey: url.absoluteString as NSString)
    }
    
    private func get(for url: URL) -> UIImage? {
        return images.object(forKey: url.absoluteString as NSString)
    }
    
    public func loadImage(
        urlAbsolute: String
    ) async throws -> UIImage {
        guard let url = URL(string: urlAbsolute) else {
            throw Errors.invalidURL
        }
        if let image = get(for: url) {
            return image
        }
  
        let (data, _) = try await session.data(from: url)
        guard let image = UIImage(data: data) else {
            throw Errors.cannotConvertDataToImage
        }
        set(image: image, for: url)
        return image
    }
    
    public func loadImages(
        urlAbsolutes: [String]
    ) async throws -> [UIImage] {
        await withTaskGroup(of: (String, Result<UIImage, Error>).self) { group in
                for url in urlAbsolutes {
                    group.addTask {
                        do {
                            let image = try await self.loadImage(urlAbsolute: url)
                            return (url, .success(image))
                        } catch {
                            return (url, .failure(error))
                        }
                    }
                }

                var dictionary: [String: UIImage] = [:]
                for await (url, result) in group {
                    switch result {
                    case .success(let image):
                        dictionary[url] = image
                    case .failure:
                        continue
                    }
                }
                return urlAbsolutes.compactMap { dictionary[$0] }
            }
    }
}

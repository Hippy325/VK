//
//  PhotosResponse.swift
//  VK
//
//  Created by User on 08.05.2023.
//

import Foundation

public struct PhotosResponse: Decodable {
	public var response: PhotosInfo
}

public struct PhotosInfo: Decodable {
	public var count: Int
	public var items: [Photo]
}

public struct Photo: Decodable {
	public var date: Int
	public var sizes: [PhotoSize]
	public var text: String
	public var likes: PhotoLikes
}

public struct PhotoSize: Decodable {
	var type: String
	public var url: String
}

public struct PhotoLikes: Decodable {
	public var count: Int
	public var userLike: Int

	enum CodingKeys: String, CodingKey {
		case count = "count"
		case userLike = "user_likes"
	}
}

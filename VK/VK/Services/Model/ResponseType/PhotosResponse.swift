//
//  PhotosResponse.swift
//  VK
//
//  Created by User on 08.05.2023.
//

import Foundation

struct PhotosResponse: Decodable {
	var response: PhotosInfo
}

struct PhotosInfo: Decodable {
	var count: Int
	var items: [Photo]
}

struct Photo: Decodable {
	var date: Int
	var sizes: [PhotoSize]
	var text: String
	var likes: PhotoLikes
}

struct PhotoSize: Decodable {
	var type: String
	var url: String
}

struct PhotoLikes: Decodable {
	var count: Int
	var userLike: Int

	enum CodingKeys: String, CodingKey {
		case count = "count"
		case userLike = "user_likes"
	}
}

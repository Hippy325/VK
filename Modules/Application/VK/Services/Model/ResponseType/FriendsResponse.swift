//
//  FriendsResponse.swift
//  VK
//
//  Created by User on 26.04.2023.
//

import Foundation

struct FriendsResponse: Decodable {
	var response: FriendsInfo
}

struct FriendsInfo: Decodable {
	var count: Int
	var items: [Item]
}

struct Item: Decodable {
	var firstName: String
	var lastName: String
	var photo: String
	var idd: Int

	enum CodingKeys: String, CodingKey {
		case firstName = "first_name"
		case lastName = "last_name"
		case photo = "photo_50"
		case idd = "id"
	}
}

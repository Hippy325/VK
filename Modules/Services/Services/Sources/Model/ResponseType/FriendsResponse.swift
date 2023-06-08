//
//  FriendsResponse.swift
//  VK
//
//  Created by User on 26.04.2023.
//

import Foundation

public struct FriendsResponse: Decodable {
	public var response: FriendsInfo
}

public struct FriendsInfo: Decodable {
	public var count: Int
	public var items: [Item]
}

public struct Item: Decodable {
	public var firstName: String
	public var lastName: String
	public var photo: String
	public var idd: Int

	enum CodingKeys: String, CodingKey {
		case firstName = "first_name"
		case lastName = "last_name"
		case photo = "photo_50"
		case idd = "id"
	}
}

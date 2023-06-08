//
//  UsersResponse.swift
//  VK
//
//  Created by User on 27.04.2023.
//

import Foundation

public struct UsersResponse: Decodable {
	public var response: [UserInfo]
}

public struct UserInfo: Decodable {
	public var firstName: String
	public var lastName: String
	public var dateBirth: String?
	public var avatarUrl: String
	public var city: City?
	public var occupation: Occupation?

	enum CodingKeys: String, CodingKey {
		case firstName = "first_name"
		case lastName = "last_name"
		case dateBirth = "bdate"
		case city = "city"
		case avatarUrl = "photo_200"
		case occupation = "occupation"
	}
}

public struct City: Decodable {
	public var title: String
}

public struct Occupation: Decodable {
	public var name: String
}

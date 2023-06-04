//
//  UsersResponse.swift
//  VK
//
//  Created by User on 27.04.2023.
//

import Foundation

struct UsersResponse: Decodable {
	var response: [UserInfo]
}

struct UserInfo: Decodable {
	var firstName: String
	var lastName: String
	var dateBirth: String?
	var avatarUrl: String
	var city: City?
	var occupation: Occupation?

	enum CodingKeys: String, CodingKey {
		case firstName = "first_name"
		case lastName = "last_name"
		case dateBirth = "bdate"
		case city = "city"
		case avatarUrl = "photo_200"
		case occupation = "occupation"
	}
}

struct City: Decodable {
	var title: String
}

struct Occupation: Decodable {
	var name: String
}

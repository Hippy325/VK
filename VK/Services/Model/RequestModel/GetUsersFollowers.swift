//
//  GetUsersFollowers.swift
//  VK
//
//  Created by User on 13.05.2023.
//

import Foundation

final class GetUsersFollowers: IAPIRequest {
	typealias Response = FriendsResponse

	var userIdPath: String = "user_ids"
	var path: String = "users.getFollowers"
	var parameters: [String : String] = ["fields": "photo_50"]
}

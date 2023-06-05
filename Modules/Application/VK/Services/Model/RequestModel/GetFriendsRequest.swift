//
//  GetFriendsRequest.swift
//  VK
//
//  Created by User on 12.05.2023.
//

import Foundation

final class GetFriendsRequest: IAPIRequest {
	typealias Response = FriendsResponse

	var userIdPath: String = "user_id"
	var path: String = "friends.get"
	var parameters: [String: String] = ["fields": "photo_50"]
}

//
//  GetUsersFollowers.swift
//  VK
//
//  Created by User on 13.05.2023.
//

import Foundation

public final class GetUsersFollowers: IAPIRequest {
	public typealias Response = FriendsResponse

	public var userIdPath: String = "user_ids"
	public var path: String = "users.getFollowers"
	public var parameters: [String: String] = ["fields": "photo_50"]

	public init() {}
}

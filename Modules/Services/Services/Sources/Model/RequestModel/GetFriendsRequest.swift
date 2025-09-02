//
//  GetFriendsRequest.swift
//  VK
//
//  Created by User on 12.05.2023.
//

import Foundation

public final class GetFriendsRequest: IAPIRequest {
	public typealias Response = FriendsResponse

	public let userIdPath: String = "user_id"
	public let path: String = "friends.get"
	public let parameters: [String: String] = ["fields": "photo_50"]

	public init() {}
}

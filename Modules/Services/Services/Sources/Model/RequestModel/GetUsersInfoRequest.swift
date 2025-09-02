//
//  GetUsersInfoRequest.swift
//  VK
//
//  Created by User on 12.05.2023.
//

import Foundation

public final class GetUsersInfoRequest: IAPIRequest {
	public typealias Response = UsersResponse

	public let userIdPath: String = "user_ids"
	public let path: String = "users.get"
	public let parameters: [String: String] = ["fields": "bdate, city, occupation, photo_200"]

	public init() {}
}

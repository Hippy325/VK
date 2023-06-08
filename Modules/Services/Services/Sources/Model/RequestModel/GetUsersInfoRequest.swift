//
//  GetUsersInfoRequest.swift
//  VK
//
//  Created by User on 12.05.2023.
//

import Foundation

public final class GetUsersInfoRequest: IAPIRequest {
	public typealias Response = UsersResponse

	public var userIdPath: String = "user_ids"
	public var path: String = "users.get"
	public var parameters: [String: String] = ["fields": "bdate, city, occupation, photo_200"]

	public init() {}
}

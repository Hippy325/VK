//
//  GetUsersInfoRequest.swift
//  VK
//
//  Created by User on 12.05.2023.
//

import Foundation

final class GetUsersInfoRequest: IAPIRequest {
	typealias Response = UsersResponse

	var userIdPath: String = "user_ids"
	var path: String = "users.get"
	var parameters: [String : String] = ["fields": "bdate, city, occupation, photo_200"]
}

//
//  GetPhotosRequest.swift
//  VK
//
//  Created by User on 12.05.2023.
//

import Foundation

final class GetPhotosRequest: IAPIRequest {
	typealias Response = PhotosResponse

	var userIdPath: String = "owner_id"
	var path: String = "photos.getAll"
	var parameters: [String : String] = ["extended": "1"]
}

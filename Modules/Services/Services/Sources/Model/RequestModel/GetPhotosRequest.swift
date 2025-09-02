//
//  GetPhotosRequest.swift
//  VK
//
//  Created by User on 12.05.2023.
//

import Foundation

public final class GetPhotosRequest: IAPIRequest {
	public typealias Response = PhotosResponse

	public let userIdPath: String = "owner_id"
	public let path: String = "photos.getAll"
	public let parameters: [String: String] = ["extended": "1"]

	public init() {}
}

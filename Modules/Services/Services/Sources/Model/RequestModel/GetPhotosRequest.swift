//
//  GetPhotosRequest.swift
//  VK
//
//  Created by User on 12.05.2023.
//

import Foundation

public final class GetPhotosRequest: IAPIRequest {
	public typealias Response = PhotosResponse

	public var userIdPath: String = "owner_id"
	public var path: String = "photos.getAll"
	public var parameters: [String: String] = ["extended": "1"]

	public init() {}
}

//
//  AlbumsCellModel.swift
//  VK
//
//  Created by User on 08.05.2023.
//

import Foundation
import UIKit

struct AlbumsCellModel {

	struct AlbumPhoto {
		let date: Int
		let likes: PhotoLikes
		let loadImages: (_ imagesSetter: @escaping (UIImage?) -> Void) -> Void
	}

	var name: String
	let count: Int
	let photos: [AlbumPhoto]
}

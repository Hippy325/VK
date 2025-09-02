//
//  AlbumsCellModel.swift
//  VK
//
//  Created by User on 08.05.2023.
//

import Foundation
import Services
import UIKit

struct AlbumsCellModel: Sendable {
    struct AlbumPhoto: Sendable {
		let date: Int
		let likes: PhotoLikes
        
        let loadImages: @Sendable (_ imagesSetter: @escaping @Sendable (UIImage?) -> Void) async -> Void
	}

	var name: String
	let count: Int
	let photos: [AlbumPhoto]
}

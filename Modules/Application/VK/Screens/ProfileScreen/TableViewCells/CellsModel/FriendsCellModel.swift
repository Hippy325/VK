//
//  FriendsCellModel.swift
//  VK
//
//  Created by User on 05.05.2023.
//

import Foundation
import UIKit

struct FriendsCellModel {
	let count: Int?

	let firstImage: UIImage?
	let secondImage: UIImage?
	let thriedImage: UIImage?

	let loadImages: (_ imageSetter: @escaping ([UIImage?]) -> Void) -> Void
}

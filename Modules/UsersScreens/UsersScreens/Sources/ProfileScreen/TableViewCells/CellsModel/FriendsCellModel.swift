//
//  FriendsCellModel.swift
//  VK
//
//  Created by User on 05.05.2023.
//

import Foundation
import UIKit

struct FriendsCellModel: Sendable {
	let count: Int?
	let firstImage: UIImage?
	let secondImage: UIImage?
	let thriedImage: UIImage?

    let loadImages: @Sendable (_ imageSetter: @escaping @Sendable ([UIImage?]) -> Void) async -> Void
}

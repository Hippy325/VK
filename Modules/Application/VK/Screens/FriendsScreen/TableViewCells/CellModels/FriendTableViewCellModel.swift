//
//  FriendTableViewCellModel.swift
//  VK
//
//  Created by User on 13.05.2023.
//

import Foundation
import UIKit

struct FriendTableViewCellModel {
	let userId: Int
	let name: String
	let avatarSetter: (_ imageSetter: @escaping (UIImage?) -> Void) -> Void
}

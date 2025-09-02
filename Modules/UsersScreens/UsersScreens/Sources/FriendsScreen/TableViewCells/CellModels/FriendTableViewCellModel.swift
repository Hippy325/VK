//
//  FriendTableViewCellModel.swift
//  VK
//
//  Created by User on 13.05.2023.
//

import Foundation
import UIKit

struct FriendTableViewCellModel: Sendable {
	let userId: Int
	let name: String
    let avatarSetter: @Sendable (_ imageSetter: @escaping @Sendable (UIImage?) -> Void) -> Void
}

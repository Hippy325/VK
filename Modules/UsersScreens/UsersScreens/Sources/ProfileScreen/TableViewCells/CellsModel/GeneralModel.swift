//
//  generalModel.swift
//  VK
//
//  Created by User on 07.05.2023.
//

import Foundation
import UIKit

struct GeneralModel: @unchecked Sendable {
	var userInfo: UserInfoCellModel
	var friendsinfo: FriendsCellModel
	var albumsInfo: AlbumsCellModel
    var avatarSetter: (_ imageSetter: @escaping @Sendable (UIImage?) -> Void) async -> Void
}

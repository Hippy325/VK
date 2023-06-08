//
//  FriendsRouter.swift
//  VK
//
//  Created by User on 10.05.2023.
//

import Foundation
import UIKit

protocol IFriendsRouter {
	func goToProfileFriendScreen(userId: Int)
}

final class FriendsRouter: IFriendsRouter {
	private let profileViewControllerAssembly: IProfileViewControllerAssembly

	weak var navigationController: UINavigationController?

	init(profileViewControllerAssembly: IProfileViewControllerAssembly) {
		self.profileViewControllerAssembly = profileViewControllerAssembly
	}

	func goToProfileFriendScreen(userId: Int) {
		navigationController?.pushViewController(
			profileViewControllerAssembly.assembly(
				userId: userId,
				navigationControler: navigationController
			),
			animated: true
		)
	}
}

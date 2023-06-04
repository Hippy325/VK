//
//  ProfileRouter.swift
//  VK
//
//  Created by User on 19.05.2023.
//

import Foundation
import UIKit

protocol IProfileRouter {
	var friendsViewControllerAssembly: IFriendsViewControllerAssembly? { get set }
	func goToFriendsScreen(userId: Int?)
}

final class ProfileRouter: IProfileRouter {

	weak var friendsViewControllerAssembly: IFriendsViewControllerAssembly?
	weak var navigationController: UINavigationController?

	func goToFriendsScreen(userId: Int?) {
		guard
			let navigationController = navigationController,
			let friendsViewControllerAssembly = friendsViewControllerAssembly
		else {
			return
		}

		navigationController.pushViewController(
			friendsViewControllerAssembly.assembly(userId: userId, navigationControler: navigationController),
			animated: true
		)
	}
}
